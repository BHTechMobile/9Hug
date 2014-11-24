//
//  MSGDetailViewController.m
//  9hug
//
//  Created by vtn on 8/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MSGDetailViewController.h"

#define BG_COLOR_BLUE [UIColor colorWithRed:0 green:190.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define PHOTO_SOURCE_PICKER_TITLE @"Attach a Picture"
#define PHOTO_SOURCE_CAMERA @"From Camera"
#define PHOTO_SOURCE_ALBUM @"From Photo Album"
#define PHOTO_SOURCE_PICKER_CANCEL @"Cancel"
#define TEXTVIEW_HEGHT 140
#define URL_RECORD [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Documents/MySounds.aac", NSHomeDirectory()]]

#define PHOTO_KEY @"photos"
#define MEDIA_KEY @"media_link"
#define VOICE_KEY @"voices"

#define _IMAGE_UNDER       [UIImage imageNamed:@"black_bg_ip5.png"]
#define _IMAGE_MIC_NORMAL  [UIImage imageNamed:@"mic_normal_358x358.png"]
#define _IMAGE_MIC_TALKING [UIImage imageNamed:@"mic_talk_358x358.png"]
#define _IMAGE_MIC_WAVE [UIImage imageNamed:@"wave70x117.png"]


@implementation MSGDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:@"View Message"];
    
    for (UIButton  *btn in _theScrollPicture.subviews) {
        [_theScrollPicture scrollRectToVisible:btn.frame animated:YES];
    }
    UIButton *backMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    [backMessage setFrame:CGRectMake(0, 0, 20, 30)];
    [backMessage setBackgroundImage:[UIImage imageNamed:@"btn_back_cyan@2x"] forState:UIControlStateNormal];
    [backMessage addTarget:self action:@selector(backMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:backMessage];
    [self.navigationItem setLeftBarButtonItem:barButton];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)backMessage{
    [audioPlayer stop];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setDataWithMessage:(HMessage*)message{
    _labelFullName.text = ([message.fullname isEqualToString:@""])?@"Guest":message.fullname;
    [_labelSentDate setText:[self setFormatDate:message.sentdate andFormat:@"dd/MM/yy HH:mm:ss"]];
    [_textDescreption setText:message.text];
    [self resetFrameViewMedia:message.text];
    [_labelReads setText:message.reads];
}

- (void)resetFrameViewMedia:(NSString *)string{
    if (string.length>0) {
        if ([Utilities getTextHeight:_textDescreption]<TEXTVIEW_HEGHT) {
            CGRect frameText = [_textDescreption frame];
            frameText.size.height = [Utilities getTextHeight:_textDescreption];
            [_textDescreption setFrame:frameText];
            //reset frame media
            CGRect frameMedia = [_viewMedia frame];
            frameMedia.origin.y = CGRectGetMaxY(_textDescreption.frame)+10;
            [_viewMedia setFrame:frameMedia];
            [_quoteButton setHidden:NO];
        }
    }else{
        CGRect frameMedia = [_viewMedia frame];
        frameMedia.origin.y = CGRectGetMaxY(_theLine.frame)+10;
        [_viewMedia setFrame:frameMedia];
        [_quoteButton setHidden:YES];
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)+ (IS_IPHONE_5 ? 180:270))];
    }
}

- (NSString *)setFormatDate :(NSDate *)date andFormat:(NSString *)stringFormat{
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:stringFormat];
    NSString *sentDate = [_formatter stringFromDate:date];
    return sentDate;
}

-(void)setMessageObj:(HMessage *)messageObj{
    _messageObj = messageObj;
    [self setDataWithMessage:_messageObj];
    [self reloadMediaWithDic];
}

-(void)getMessageByKey:(NSString*)key{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BaseServices getMessageByKey:key sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (dicResponse) {
            dicResponse = nil;
        }
        dicResponse = [NSDictionary dictionaryWithDictionary:(NSDictionary *)responseObject];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        _messageObj = [HMessage createByDictionary:dicResponse];
        [self setDataWithMessage:_messageObj];
        [self reloadMediaWithDic];
    } failure:^(NSString* bodyString, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
}

- (void)reloadMediaWithDic {
    if ([[dicResponse objectForKey:PHOTO_KEY] isKindOfClass:[NSArray class]] ) {
        if (_arrayPicture.count != [(NSArray *)[dicResponse objectForKey:PHOTO_KEY] count]) {
            [self addImageToScrollView];
        }
    }
    
    if ([[dicResponse objectForKey:VOICE_KEY] isKindOfClass:[NSArray class]] ) {
        if (_arrayAudios.count != [(NSArray *)[dicResponse objectForKey:VOICE_KEY] count]) {
            [self addAudioToScroll];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [APP_DELEGATE.tabbar hideMe];
    
    if (_capturePath!=nil) {
        [self createUI];
        [self setupRemotePlayerByUrl:_capturePath];
    }
    [_scrollView addSubview:_playerView];
    
    CGRect frameExtend = [_viewExtend frame];
    frameExtend.origin.y = CGRectGetHeight(_playerView.frame);
    [_viewExtend setFrame:frameExtend];
    CGRect frameScroll = [_scrollView frame];
    frameScroll.size.height= CGRectGetHeight(_playerView.frame)+CGRectGetHeight(_viewExtend.frame);
    [_scrollView setFrame:frameScroll];
    [_scrollView addSubview:_viewExtend];
    [_scrollView setContentSize:CGSizeMake(320, CGRectGetHeight(_scrollView.frame)+ (IS_IPHONE_5 ? 330:400))];
    [_viewRecord setHidden:YES];
    [_btnCancelRecord setHidden:YES];
    [_btnSendRecord setHidden:YES];
    
    self.voice = [[LCVoice alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//btn_message_play_all@2x
#pragma mark - Voice Actions

- (IBAction)playDefault:(id)sender {
    if (_arrayAudios.count) {
        if ([_videoPlayer isPlaying]) {
            [_videoPlayer pause];
        }
        if ([audioPlayer isPlaying]) {
            [audioPlayer pause];
            [_btnPlayAll setBackgroundImage:[UIImage imageNamed:@"btn_message_play_all_on@2x"] forState:UIControlStateNormal];
        }else{
            if (_arrayAudios.count) {
                [self setUpUrlAudio:[[_arrayAudios lastObject] integerValue]];
                [audioPlayer play];
                [_btnPlayAll setBackgroundImage:[UIImage imageNamed:@"btn_message_play_all@2x"] forState:UIControlStateNormal];
            }
        }
    }
}

-(IBAction)clickCancelRecord:(id)sender {
    [self btnRecordTapped:nil];
    
    [self hideRecordView];
    
}

- (IBAction)sendRecord:(id)sender{
    [self btnRecordTapped:nil];
    [self hideRecordView];
    
    NSString *token = [[UserData currentAccount] strFacebookToken];
    [BaseServices uploadAudioWithToken:token?token:@"" messageID:_messageObj.mId type:TYPE_UPLOAD_AUDIO path:URL_RECORD  sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getMessageByKey:_mKey];
    } failure:^(NSString *bodyString, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


#pragma mark Create View

-(void)createUI{
    [Utilities setBorderForView:_viewAudio];
    //for test add audio
    _arrayAudios = [NSMutableArray new];
    _arrayPicture = [NSMutableArray new];

    //image picker
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.navigationBar.translucent = NO;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.delegate = self;
    //action sheet
    _imageSourceActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(PHOTO_SOURCE_PICKER_TITLE, nil) delegate:self cancelButtonTitle:NSLocalizedString(PHOTO_SOURCE_PICKER_CANCEL, nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(PHOTO_SOURCE_CAMERA, nil), NSLocalizedString(PHOTO_SOURCE_ALBUM, nil), nil];
    //record
}

- (void)prepareRecord{
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:[self arrComponent]];
	
	// Setup audio session
	AVAudioSession *session = [AVAudioSession sharedInstance];
	[session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
	
	// Define the recorder setting
	NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
	[recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
	[recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
	[recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
	
	// Initiate and prepare the recorder
    self.audioRecorder = nil;
	self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:nil];
	self.audioRecorder.delegate = self;
	self.audioRecorder.meteringEnabled = YES;
	[self.audioRecorder prepareToRecord];
}

- (NSArray *)arrComponent{
    NSString *str = [NSString stringWithFormat:@"MySounds.aac"];
    return [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], str, nil];
}

-(void)setupRemotePlayerByUrl:(NSURL*)url{
    _videoPlayer = [PlayerView fromNib];
    [_videoPlayer setFrame:CGRectMake(0, 0, _playerView.frame.size.width, _playerView.frame.size.height)];
    [_playerView addSubview:_videoPlayer];
    [_videoPlayer playWithUrl:url];
    if ([audioPlayer isPlaying]) {
        [audioPlayer pause];
    }
    
}

- (IBAction)backButtonTapped:(id)sender {
    [_videoPlayer pause];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addAudioToScroll{
    for (UIView *view in _scrollAudio.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    if (_arrayAudios) {
        [_arrayAudios removeAllObjects];
        _arrayAudios = nil;
    }
    _arrayAudios = [NSMutableArray new];
    NSArray* reversedArray = [[[dicResponse objectForKey:VOICE_KEY] reverseObjectEnumerator] allObjects];

    for (NSDictionary *dic in reversedArray) {
        NSInteger index = [reversedArray indexOfObject:dic];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(index*(CGRectGetHeight(_scrollAudio.frame)+5), 0 , CGRectGetHeight(_scrollAudio.frame), CGRectGetHeight(_scrollAudio.frame))];
        [btn setTag:index];
        [btn setTitle:[NSString stringWithFormat:@"%ld",(long)btn.tag] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectAudio:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn.titleLabel setTextColor:[UIColor blueColor]];
        [btn.layer setCornerRadius:17.0f];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_user_placeholder.png"] forState:UIControlStateNormal];
        [_scrollAudio addSubview:btn];
        [_arrayAudios addObject:[dic objectForKey:MEDIA_KEY]];
        NSString* fileName = [NSString stringWithFormat:@"Documents/%@",[[[_arrayAudios objectAtIndex:index] pathComponents] lastObject]];
        NSString *urlOutPut2 = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:urlOutPut2];
        if (fileExists) {
            [self calculateTotalDuration];
        }else{
            [BaseServices downloadAudio:[_arrayAudios objectAtIndex:index] sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self calculateTotalDuration];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            } progress:^(float progress) {
                NSLog(@"downoad %lf",progress);
            }];
        }
 
    }
    
    [_scrollAudio setContentSize:CGSizeMake([(NSArray *)[dicResponse objectForKey:VOICE_KEY] count]*(CGRectGetHeight(_scrollAudio.frame)+5), CGRectGetHeight(_scrollAudio.frame))];
    for (UIButton  *btn in _scrollAudio.subviews) {
        [_scrollAudio scrollRectToVisible:btn.frame animated:YES];
    }
}

- (void)calculateTotalDuration{
    float totalDuraion = 0;
    
    for (NSString *strPathAudio in _arrayAudios) {
        NSArray *parts = [strPathAudio componentsSeparatedByString:@"/"];
        NSString* fileName = [NSString stringWithFormat:@"Documents/%@",[parts objectAtIndex:[parts count]-1]];
        NSString *urlOutPut2 = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
        AVAudioPlayer *audioTemp =  [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:urlOutPut2]
                                                                           error:nil];
        totalDuraion +=audioTemp.duration;
    }
    _totalTimeAudio.text = [NSString stringWithFormat:@"%@",[Utilities timeFromAudio:totalDuraion]];
}

- (void)setUpUrlAudio :(NSInteger )index{
    NSString *url = [_arrayAudios objectAtIndex:index];
    NSArray *parts = [url componentsSeparatedByString:@"/"];
    NSString* fileName = [NSString stringWithFormat:@"Documents/%@",[parts objectAtIndex:[parts count]-1]];
    NSLog(@"file name = %@",fileName);
    NSString *urlOutPut2 = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    audioPlayer = nil;
    [_btnPlay setBackgroundImage:[UIImage imageNamed:@"btn_mix_play@2x"] forState:UIControlStateNormal];
    NSError *err;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:urlOutPut2]
                                                         error:nil];
    _labelTotalDuration.text = [NSString stringWithFormat:@"%@",[Utilities timeFromAudio:audioPlayer.duration]];
    
    if (err)
    {
        NSLog(@"Error in audioPlayer: %@",
              [err localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
        [audioPlayer play];
        [self createPlayerTimer];
    }
}



- (void)selectAudio :(id)sender{
    UIButton *btnAudio = (UIButton *)sender;
    for (UIView *view in _scrollAudio.subviews) {
        UIButton *btn = nil;
        if ([view isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)view;
            if (btn.tag == btnAudio.tag) {
                [btn.layer setBorderColor:BG_COLOR_BLUE.CGColor];
                [btn.layer setBorderWidth:2.0f];
                [_btnCurrentAudio setTitle:[NSString stringWithFormat:@"%@",[btn.titleLabel text]] forState:UIControlStateNormal];
                     [self setUpUrlAudio:btnAudio.tag];
                     [self handleStatusPlayAllButtonOn];
                 }else
                     [btn.layer setBorderWidth:0.0f];
            }
    }
}

- (void)setFrameCurrentAudio :(float)with{
    CGRect frame = self.viewCurrentProcess.frame;
    frame.size.width = with;
    frame.origin.x = 0;
    [self.viewCurrentProcess setFrame:frame];
}

- (void)handleStatusPlayAllButtonOn{
    [_btnPlayAll setBackgroundImage:[UIImage imageNamed:@"btn_message_play_all_on@2x"] forState:UIControlStateNormal];
    [_btnPlay setBackgroundImage:[UIImage imageNamed:@"btn_mix_pause@2x"] forState:UIControlStateNormal];
}

- (void)handleStatusPlayAllButtonOff{
    [_btnPlayAll setBackgroundImage:[UIImage imageNamed:@"btn_message_play_all@2x"] forState:UIControlStateNormal];
    [_btnPlay setBackgroundImage:[UIImage imageNamed:@"btn_mix_play@2x"] forState:UIControlStateNormal];
}


#pragma mark - AVAudioPlayer Delegate

-(IBAction)playAudio:(id)sender{
    if (audioPlayer) {
        if ([audioPlayer isPlaying]) {
            [audioPlayer pause];
            [self handleStatusPlayAllButtonOff];
        }
        else{
            [self playCurrentAudio];
        }
    }
}

- (void)playCurrentAudio{
    [self createPlayerTimer];
    if ([_videoPlayer isPlaying]) {
        [_videoPlayer pause];
    }
    [audioPlayer play];
    [self handleStatusPlayAllButtonOn];
}

#pragma mark - Add Picture

- (IBAction)addImage:(id)sender{
    [self imagePickerPressed];
}

#pragma mark - Record

- (IBAction)stopRecording:(UIButton *)sender {
	[_audioRecorder stop];
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	[audioSession setActive:NO error:nil];
}

- (void)createRecordTimer{
    recordTimmer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(recordStart) userInfo:nil repeats:YES];
}

-(void)recordStart{
    [_labelCurrentRecord setText:[Utilities timeFromAudio:(floorf)(_audioRecorder.currentTime)]];
}

- (void)vibrate {
    NSLog(@"rung");
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

- (void)hideRecordView{
    [_btnCancelRecord setHidden:YES];
    
    [_btnSendRecord setHidden:YES];
    
    [_btnPlayAll setHidden:NO];
    [_btnAddimage setHidden:NO];
    self.viewRecord.alpha = 1;
    [UIView animateWithDuration:.35 animations:^{
        self.viewRecord.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.viewRecord.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (IBAction)holdAndRecord:(id)sender {
    [self createRecordTimer];
    CGRect fRecord = _viewRecord.frame;
    [_viewRecord.layer setCornerRadius:5.0f];
    [_viewRecord.layer setMasksToBounds:YES];
    [self vibrate];
    
    fRecord.origin.y = (CGRectGetHeight(self.view.frame) - CGRectGetHeight(_viewRecord.frame))/2;
    [_viewRecord setFrame:fRecord];
    self.viewRecord.transform = CGAffineTransformMakeScale(1, 1);
    self.viewRecord.alpha = 1;
    [_viewRecord setHidden:NO];
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            [self prepareRecord];
            if (!_audioRecorder.recording) {
                AVAudioSession *session = [AVAudioSession sharedInstance];
                [session setActive:YES error:nil];
                [self.audioRecorder record];
            }        }
        else {
            [UIAlertView showTitle:@"Microphone Access Denied" message:@"You must allow microphone access in Settings > Privacy > Microphone"];
        }
    }];
    
}


- (IBAction)btnRecordTapped:(id)sender {
    if (recordTimmer) {
        [recordTimmer invalidate];
        recordTimmer = nil;
    }
    [_videoPlayer pause];
    [_audioRecorder stop];
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	[audioSession setActive:NO error:nil];
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    _recordURL = recorder.url;
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
	NSLog(@"Encode Error occurred");
}


- (void)imagePickerPressed
{
    
    if ([_videoPlayer isPlaying]) {
        [_videoPlayer pause];
    }

    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        [_imageSourceActionSheet showInView:self.view];
    } else {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self showImagePicker];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            SquareCamViewController *squareVC = [SquareCamViewController new];
            squareVC.delegate = self;
            [self.navigationController pushViewController:squareVC animated:YES];
            break;
        }
        case 1:
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self showImagePicker];
            break;
            
        default:
            break;
    }

}

- (void)showImagePicker
{

   [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (void)saveImage :(UIImage *)image{
    NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToFile:URL_ATTACH_IMAGE atomically:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    // set thumbnail
    [self saveImage:image];
    //create param
    NSString *token = [[UserData currentAccount] strFacebookToken];
    NSDictionary *dicParam = @{@"token":token?token:@"",
                               @"message_id":_messageObj.mId,
                               @"type":TYPE_UPLOAD_IMAGE,
                               };
    //upload
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BaseServices uploadImage:dicParam path:[NSURL fileURLWithPath:URL_ATTACH_IMAGE] sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self getMessageByKey:_mKey];
    } failure:^(NSString *bodyString, NSError *error) {
        NSLog(@"fail %@", bodyString);
    }];

}

- (void)addImageToScrollView{
    for (UIView *view in _theScrollPicture.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    if (_arrayPicture) {
        [_arrayPicture removeAllObjects];
    }
    _arrayPictureCaches = [NSMutableArray new];
    NSArray* reversedArray = [[[dicResponse objectForKey:PHOTO_KEY] reverseObjectEnumerator] allObjects];
    
    for (NSDictionary *dic in reversedArray) {
        UIButton *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger index = [reversedArray indexOfObject:dic];
        [imageView setFrame:CGRectMake(index*(CGRectGetHeight(_theScrollPicture.frame)+5), 0 , CGRectGetHeight(_theScrollPicture.frame), CGRectGetHeight(_theScrollPicture.frame))];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.alpha = 1.0;
        activityIndicator.center = imageView.center;
        [activityIndicator startAnimating];
        UIView *viewBoder = [[UIView alloc]initWithFrame:imageView.frame];
        viewBoder.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [viewBoder.layer setCornerRadius:6.0f];
        [viewBoder.layer setBorderWidth:1.0f];
        [_theScrollPicture addSubview:viewBoder];
        [_theScrollPicture addSubview:activityIndicator];
        [_arrayPicture addObject:[dic objectForKey:MEDIA_KEY]];
        [Utilities setImageForButton:imageView andURLImage:[dic objectForKey:MEDIA_KEY] andArrayCaches:_arrayPictureCaches];
        imageView.tag = index;
        
        imageView.userInteractionEnabled = YES;
        [imageView addTarget:self action:@selector(tapImage:) forControlEvents:UIControlEventTouchUpInside ];
        imageView.clipsToBounds = YES;
        [imageView.layer setCornerRadius:5.0f];
        [imageView.layer setMasksToBounds:YES];
        [_theScrollPicture addSubview:imageView];
        [_theScrollPicture setContentSize:CGSizeMake([reversedArray count]*(CGRectGetHeight(_theScrollPicture.frame)+5), CGRectGetHeight(_theScrollPicture.frame))];
        for (UIButton  *btn in _theScrollPicture.subviews) {
            [_theScrollPicture scrollRectToVisible:CGRectMake(0, 0, CGRectGetWidth(btn.frame), CGRectGetWidth(btn.frame)) animated:YES];
        }        //set imagecache
    }
    NSLog(@"_arrayPicture = %@",_arrayPicture);
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)tapImage:(UIButton *)tap{
    SlideImageViewController *slideVC = [[SlideImageViewController alloc]initWithIndex:tap.tag];
    slideVC.arrImages = [NSMutableArray arrayWithArray:_arrayPicture];
    [self presentViewController:slideVC animated:YES completion:^{
    }];
}

- (void)removeImageCache
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:URL_ATTACH_IMAGE error:&error];
    if (success) {
        NSLog(@"Deleted");
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}


- (void)createPlayerTimer{
    playTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

-(void)tick{
    [self setFrameCurrentAudio:(audioPlayer.currentTime*1.0)/(1.0*audioPlayer.duration)*CGRectGetWidth(self.processViewAudio.frame)];
    _labelCurrentDuration.text = [Utilities timeFromAudio:audioPlayer.currentTime];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
        [self setFrameCurrentAudio:0];
        [_labelCurrentDuration setText:@""];
        [self handleStatusPlayAllButtonOff];
        if (playTimer) {
            [playTimer invalidate];
            playTimer = nil;
        }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    [self setFrameCurrentAudio:0];
    
    if (playTimer) {
        [playTimer invalidate];
        playTimer = nil;
    }
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    [self setFrameCurrentAudio:0];
    
    if (playTimer) {
        [playTimer invalidate];
        playTimer = nil;
    }
}


#pragma mark - CameraDelegate

- (void)didCaptureCamera:(UIImage *)image{
    [self saveImage:image];
    //create param
    NSString *token = [[UserData currentAccount] strFacebookToken];
    NSDictionary *dicParam = @{@"token":token?token:@"",
                               @"message_id":_messageObj.mId,
                               @"type":TYPE_UPLOAD_IMAGE,
                               };
    //upload
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BaseServices uploadImage:dicParam path:[NSURL fileURLWithPath:URL_ATTACH_IMAGE] sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self getMessageByKey:_mKey];
    } failure:^(NSString *bodyString, NSError *error) {
        NSLog(@"fail %@", bodyString);
    }];
}

@end
