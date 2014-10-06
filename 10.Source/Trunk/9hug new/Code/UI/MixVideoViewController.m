//
//  MixVideoViewController.m
//  9hug
//
//  Created by Tommy on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MixVideoViewController.h"
#import "AppDelegate.h"

#import "VideoFilterActionView.h"

@implementation MixVideoViewController{
    UIButton *buttonBack;
}
#define BG_COLOR_PROCESS [UIColor colorWithRed:224.0/255.0 green:100.0/255.0 blue:176.0/255.0 alpha:1.0]

+ (NSArray *)filters
{
    static NSArray *names;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        names = @[
                  @"GPUImageFilter",
                  @"GPUImageBilateralFilter",
                  @"GPUImageBoxBlurFilter",
                  @"GPUImageBulgeDistortionFilter",
                  @"GPUImageColorInvertFilter",
                  @"GPUImageGaussianBlurPositionFilter",
                  @"GPUImageGaussianSelectiveBlurFilter",
                  @"GPUImageGrayscaleFilter",
                  @"GPUImageMissEtikateFilter",
                  @"GPUImageMonochromeFilter",
                  @"GPUImagePinchDistortionFilter",
                  @"GPUImageSepiaFilter",
                  @"GPUImageZoomBlurFilter"
                  ];
    });
    
    return names;
}

+ (NSArray *)titleFilter{
    static NSArray *titles;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        titles = @[
                  @"None",
                  @"Bilateral",
                  @"Box Blur",
                  @"Bulge",
                  @"Invert",
                  @"Blur",
                  @"Selective",
                  @"Grayscale",
                  @"Etikate",
                  @"Monochrome",
                  @"Distortion",
                  @"Sepia",
                  @"Zoom Blur"
                  ];
    });
    
    return titles;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Mix Video";
    [self playVideoWithFilter:@"GPUImageFilter"];
    [self createUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}



-(void)createUI{
    _imvFrame.image = _imgFrame;
    _enterMessageView = [EnterMessageView fromNib];
    _enterMessageView.delegate = self;
    _enterMessageView.center = _playerView.center;
    [self.view addSubview:_enterMessageView];
    _enterMessageView.hidden = YES;
    _scheduleView = [ScheduleView fromNib];
    _scheduleView.frame = CGRectMake(0, self.view.size.height-_scheduleView.frame.size.height, 320, _scheduleView.frame.size.height);
    _scheduleView.alpha = 0.0;
    [self.view addSubview:_scheduleView];
    _scheduleView.hidden = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(sendButtonTapped:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [button setBackgroundImage:[UIImage imageNamed:@"btn_nex_cyan"] forState:UIControlStateNormal];
    button.frame = CGRectMake(2 ,2,14,22);
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    buttonBack=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setFrame:CGRectMake(2 ,2,14,22)];
    [buttonBack addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [buttonBack setImage:[UIImage imageNamed:@"btn_back_cyan@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnback = [[UIBarButtonItem alloc]initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = btnback;
    
    const NSArray* frameNames =@[@"bgr_frame_select_no_frame",
                                 @"1_pink_heart_thumb",
                                 @"2_blue amazing curve_thumb",
                                 @"4_halloween_thumb",
                                 @"3_butter_fly_thumb",
                                 @"5_floral_on_the_right_thumb",
                                 @"6_golden_flora_thumb",
                                 @"7_daisies_yellow_thumb"];
    
    changeFrameButtons = @[
                           [Utilities squareButtonWithSize:60 background:[UIImage imageNamed:[frameNames objectAtIndex:0]] text:nil target:self selector:@selector(changeFrame:) tag:0 isTypeFrame:YES],
                           [Utilities squareButtonWithSize:58 background:[UIImage imageNamed:[frameNames objectAtIndex:1]] text:nil target:self selector:@selector(changeFrame:) tag:1 isTypeFrame:YES],
                           [Utilities squareButtonWithSize:58 background:[UIImage imageNamed:[frameNames objectAtIndex:2]] text:nil target:self selector:@selector(changeFrame:) tag:2 isTypeFrame:YES],
                           [Utilities squareButtonWithSize:58 background:[UIImage imageNamed:[frameNames objectAtIndex:3]] text:nil target:self selector:@selector(changeFrame:) tag:3 isTypeFrame:YES],
                           [Utilities squareButtonWithSize:58 background:[UIImage imageNamed:[frameNames objectAtIndex:4]] text:nil target:self selector:@selector(changeFrame:) tag:4 isTypeFrame:YES],
                           [Utilities squareButtonWithSize:58 background:[UIImage imageNamed:[frameNames objectAtIndex:5]] text:nil target:self selector:@selector(changeFrame:) tag:5 isTypeFrame:YES],
                           [Utilities squareButtonWithSize:58 background:[UIImage imageNamed:[frameNames objectAtIndex:6]] text:nil target:self selector:@selector(changeFrame:) tag:6 isTypeFrame:YES],
                           [Utilities squareButtonWithSize:58 background:[UIImage imageNamed:[frameNames objectAtIndex:7]] text:nil target:self selector:@selector(changeFrame:) tag:7 isTypeFrame:YES]
                           ];
    
    _selectFrameScrollView.contentSize = CGSizeMake(changeFrameButtons.count*66, _selectFrameScrollView.frame.size.height);
    _selectFrameScrollView.scrollEnabled = YES;

    for (int i = 0;i<changeFrameButtons.count;i++) {
        
        UIButton * button = changeFrameButtons[i];
        if (i ==0) {
            button.layer.borderWidth = 3;
            button.layer.borderColor = [UIColor colorWithRed:69/255.0 green:187/255.0 blue:255/255.0 alpha:1.0].CGColor;
            
        }
        button.center = CGPointMake(4+button.size.width/2 + i*(button.size.width+8), 36);
        [_selectFrameScrollView addSubview:button];
        if (i==_indexFrame) {
            [_selectFrameScrollView scrollRectToVisible:button.frame animated:YES];
            [self changeFrame:button];
        }
    }
    
    _videoFilterScrollView.contentSize = CGSizeMake([MixVideoViewController filters].count*60, _videoFilterScrollView.frame.size.height);
    _videoFilterScrollView.scrollEnabled = YES;

    for (int i = 0;i<[MixVideoViewController filters].count;i++) {
        
        VideoFilterActionView * actionView = [VideoFilterActionView fromNib];
        actionView.imageView.image = [[self class] makeRoundedImage:[UIImage imageNamed:[MixVideoViewController filters][i]] radius:30];
        actionView.layer.masksToBounds = YES;
//        actionView.imageView.layer.cornerRadius = actionView.imageView.image.size.width/2;
        actionView.label.text = [MixVideoViewController titleFilter][i];
        actionView.button.tag = i;
        [actionView.button addTarget:self action:@selector(changeFilter:) forControlEvents:UIControlEventTouchUpInside];
        actionView.frame = CGRectMake(i * 60, 0, actionView.frame.size.width, actionView.frame.size.height);
        [_videoFilterScrollView addSubview:actionView];
    }
    
    _videoFilterScrollView.backgroundColor = [UIColor colorWithRed:43.0/255.0f green:41.0/255.0f blue:50.0/255.0f alpha:1];
    _selectFrameScrollView.backgroundColor = [UIColor colorWithRed:43.0/255.0f green:41.0/255.0f blue:50.0/255.0f alpha:1];
    [self clickedVideoFilterButton:nil];

}
- (IBAction)clickedFramesButtons:(id)sender {
    _videoFilterScrollView.hidden = YES;
    _selectFrameScrollView.hidden = NO;
    _btnFrames.selected = YES;
    _btnVideoFilters.selected = NO;
}

- (IBAction)clickedVideoFilterButton:(id)sender {
    _videoFilterScrollView.hidden = NO;
    _selectFrameScrollView.hidden = YES;
    _btnFrames.selected = NO;
    _btnVideoFilters.selected = YES;
}

-(IBAction)changeFilter:(id)sender{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    for (int i = 0;i<_videoFilterScrollView.subviews.count;i++) {
        if (i==[sender tag]) {
            ((VideoFilterActionView*)_videoFilterScrollView.subviews[i]).imageView.layer.borderWidth = 3;
            ((VideoFilterActionView*)_videoFilterScrollView.subviews[i]).imageView.layer.borderColor = [UIColor colorWithRed:69/255.0 green:187/255.0 blue:255/255.0 alpha:1.0].CGColor;
        }
        else{
            ((VideoFilterActionView*)_videoFilterScrollView.subviews[i]).imageView.layer.borderWidth = 0;
        }
    }
    [self playVideoWithFilter:[[MixVideoViewController filters] objectAtIndex:[sender tag]]];

}

-(IBAction)changeFrame:(id)sender{
    for (UIView * view in _selectFrameScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            ((UIButton*)view).layer.borderWidth = 0;
        }
    }
    
    const NSArray* frameNames =@[@"",@"1_pink_heart",
                                 @"2_blue amazing curve",
                                 @"4_halloween",
                                 @"3_butter_fly",
                                 @"5_floral_on_the_right",
                                 @"6_golden_flora",
                                 @"7_daisies_yellow"];
    
    _imvFrame.image = [UIImage imageNamed:[frameNames objectAtIndex:[sender tag]]];
    UIButton * button = sender;
    _imgFrame = _imvFrame.image;
    button.layer.borderWidth = 3;
    button.layer.borderColor = [UIColor colorWithRed:69/255.0 green:187/255.0 blue:255/255.0 alpha:1.0].CGColor;
    NSLog(@"%s",__PRETTY_FUNCTION__);
}




-(void)setupRemotePlayerByUrl:(NSURL*)url{
    
    NSError * audioError = nil;
    if (_audioPlayer) {
        [_audioPlayer stop];
    }
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_capturePath error:&audioError];
    _audioPlayer.delegate = self;
    if (!audioError) {
        [_audioPlayer prepareToPlay];
    }
    movieFile = [[GPUImageMovie alloc] initWithURL:url];
    movieFile.playAtActualSpeed = YES;
    movieFile.shouldRepeat = NO;
    
    filter = [[GPUImageFilter alloc] init];
    [movieFile addTarget:filter];
    GPUImageView *filterView = (GPUImageView *)self.playerView;
    [filter addTarget:filterView];
    [movieFile startProcessing];
    [_audioPlayer performSelector:@selector(play) withObject:nil afterDelay:0.2];
    _currentFilterClassString = @"GPUImageFilter";

}

-(void)playVideoWithFilter:(NSString*)filterClassString{
    _currentFilterClassString = filterClassString;
    _imvPlay.hidden = YES;
    _isPlaying = YES;
    if (movieFile) {
        [movieFile cancelProcessing];
        [movieFile endProcessing];
        movieFile = nil;
    }
    [_audioPlayer stop];
    NSError * audioError = nil;

    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:(_exportUrl)?_exportUrl:_capturePath error:&audioError];
    _audioPlayer.delegate = self;
    if (!audioError) {
        [_audioPlayer prepareToPlay];
    }

    movieFile = [[GPUImageMovie alloc] initWithURL:_capturePath];
    movieFile.playAtActualSpeed = YES;
    movieFile.shouldRepeat = NO;
    if (filter) {
        [filter removeAllTargets];
        filter = nil;
    }
    filter = [[NSClassFromString(filterClassString) alloc] init];
    if (filter == nil) {
        return;
    }
    [movieFile addTarget:filter];
    GPUImageView *filterView = (GPUImageView *)self.playerView;
    [filter addTarget:filterView];
    [movieFile startProcessing];
    [_audioPlayer performSelector:@selector(play) withObject:nil afterDelay:0.1];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


-(void)audioSetupViewControllerDidCancel
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

-(void)audioSetupViewController:(AudioSetupViewController *)setupViewController didMixVideoUrl:(NSURL *)mixUrl
{
    _exportUrl = mixUrl;
//    _mixed = YES;
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
//        [_videoPlayer playWithUrl:_exportUrl];
    }];
}

- (void)showAudioSetup{

    AudioSetupViewController * audioVC =  [[AudioSetupViewController alloc] initWithNibName:nil bundle:nil];
    audioVC.capturePath = _capturePath;
    audioVC.audioItem = _audioItem;
    audioVC.delegate = self;
    UIViewController *sourceViewController = self;
    UIViewController *destinationController = audioVC;
    sourceViewController.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    destinationController.view.alpha = 0.0;
    [sourceViewController.navigationController presentViewController:destinationController animated:NO completion:nil];
    [UIView beginAnimations: nil context: nil];
    destinationController.view.alpha = 1.0;
    [UIView commitAnimations];
}

- (IBAction)musicButtonTapped:(id)sender {
    if (_isPlaying) {
        [self clickedPlayButton:nil];
    }
    if (_audioItem) {
        [self showAudioSetup];
        
    }
    else{
        MPMediaPickerController *picker =
        [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
        
        picker.delegate						= self;
        picker.allowsPickingMultipleItems	= NO;
//        picker.prompt						= NSLocalizedString (@"Add song", "Prompt in media item picker");
        picker.navigationController.navigationBarHidden = YES;
        
        //    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated: YES];
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark Media item picker delegate methods________

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection {
    if ([[mediaItemCollection items] count] == 0) {
        return;
    }
    
    _audioItem = [[mediaItemCollection items] objectAtIndex:0];
    
    if (!_audioItem || ![_audioItem valueForProperty:MPMediaItemPropertyAssetURL]) {
        [UIAlertView showMessage:@"Invalid Audio"];
    }
    _mixed = NO;
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self showAudioSetup];

    }];
}

// Invoked when the user taps the Done button in the media item picker having chosen zero
//		media items to play
- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker {
    
	[self dismissViewControllerAnimated:YES completion:nil];
	
//	[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated: YES];
    
}


#pragma mark - buttons clicked

- (IBAction)addMessageButtonTapped:(UIButton *)sender {
    _messageButton.selected = YES;
    _enterMessageView.hidden = NO;
    [_enterMessageView.textView setText:@""];
    _topPosition.constant = 40.0f;
    [_enterMessageView showUpKeyboard];
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.view layoutIfNeeded];
        
    }];
}

-(void)enterMessageDidCancel
{
    
    if (![_message isEqualToString:@""]&&_message!=nil) {
        _messageButton.selected = YES;
    }
    else{
        _messageButton.selected = NO;
    }
    _enterMessageView.hidden = YES;

    _topPosition.constant = -_enterMessageView.height;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)enterMessage:(EnterMessageView *)enterMessageController DidEnterMessage:(NSString *)message
{
    if (![message isEqualToString:@""]&&message!=nil) {
        _messageButton.selected = YES;
    }
    else{
        _messageButton.selected = NO;
    }
    _enterMessageView.hidden = YES;
    _message = message;
    [self enterMessageDidCancel];
}

- (IBAction)notificationButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)tagButtonTapped:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (IBAction)calenderButtonTapped:(UIButton *)sender {
    _scheduleView.hidden = NO;
    [_scheduleView showWithAnimation];
}

- (IBAction)sendButtonTapped:(UIButton *)sender {
    [self mixVideo];
}

- (IBAction)backButtonTapped:(id)sender {
    [movieFile cancelProcessing];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)processMixingWithStatus:(AVAssetExportSessionStatus)status outputURLString:(NSString*)output{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showHUDAddedTo:self.view animated:NO :@"Sending..."];
    });
    
    switch (status){
        case AVAssetExportSessionStatusFailed:
        {
            _mixed = NO;
            break;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        case AVAssetExportSessionStatusCompleted:
        {
            _exportUrl = [NSURL fileURLWithPath:output];
            _mixed = YES;
            [self upload];
            break;
        }
    }
}
- (IBAction)clickedPlayButton:(id)sender {
    if (_isPlaying) {
        [movieFile cancelProcessing];
        [_audioPlayer stop];
        _isPlaying = !_isPlaying;
        _imvPlay.hidden = _isPlaying;
    }
    else{
        [self playVideoWithFilter:_currentFilterClassString];
    }

}

-(void)mixVideo{
    dispatch_async(dispatch_get_main_queue(), ^{
        _imvPlay.hidden = YES;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES :@"Mixing..."];
    });
    if ([[[filter class] description] isEqualToString:@"GPUImageFilter"]) {
        [MixEngine mixImage:_imgFrame videoUrl:_exportUrl?_exportUrl:_capturePath completionHandler:^(NSString *output, AVAssetExportSessionStatus status) {
            [self processMixingWithStatus:status outputURLString:output];
        }];
    }
    else{
        _videoFilterScrollView.userInteractionEnabled = NO;
        if (movieFile) {
            [movieFile endProcessing];
            movieFile = nil;
        }
        movieFile = [[GPUImageMovie alloc] initWithURL:_exportUrl?_exportUrl:_capturePath];
        movieFile.playAtActualSpeed = YES;
        
        if (filter) {
            [filter removeAllTargets];
            filter = nil;
        }
        filter = [[NSClassFromString(_currentFilterClassString) alloc] init];
        
        [movieFile addTarget:filter];
        
        NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/abc.m4v"];
        unlink([pathToMovie UTF8String]);
        NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
        
        movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480, 480.0)];
        
        [filter addTarget:movieWriter];
        
        movieWriter.shouldPassthroughAudio = YES;
        movieFile.audioEncodingTarget = movieWriter;
        [movieFile enableSynchronizedEncodingUsingMovieWriter:movieWriter];
        
        [movieFile startProcessing];
        [movieWriter startRecording];
        
        double delayInSeconds = _duration;
        dispatch_time_t stopTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(stopTime, dispatch_get_main_queue(), ^(void){
            [filter removeTarget:movieWriter];
            movieFile.audioEncodingTarget = nil;
            [movieWriter finishRecording];
            [MixEngine mixImage:_imgFrame videoUrl:movieURL completionHandler:^(NSString *output, AVAssetExportSessionStatus status) {
                [self processMixingWithStatus:status outputURLString:output];
            }];
        });
    }
}

-(void)upload{
    [BaseServices updateMessage:_message?_message:@""
                   key:_mKey
                 frame:@"1"
                  path:_exportUrl
          notification:_notificationButton.selected
             scheduled:[NSString stringWithFormat:@"%f",[[_scheduleView getSelectedDate] timeIntervalSince1970]]
               sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
                   NSDictionary* dict = (NSDictionary*)responseObject;
                   [HMessage createByDictionary:dict];
                   [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfWithCompletion:nil];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                       [UIAlertView showMessage:@"Message sent"];
                       [self.navigationController popToRootViewControllerAnimated:YES];
                   });
                   
               } failure:^(NSString *bodyString, NSError *error) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                   });
                   _mixed = NO;
               }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - AVAudioPlayer Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    _imvPlay.hidden = NO;
    _isPlaying = NO;
    [movieFile cancelProcessing];
}

#pragma mark - Helpers


+ (UIImage *)makeRoundedImage:(UIImage *)image radius:(float)radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id)image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = image.size.height/2;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

//#pragma mark - 
//
//- (void)didCompletePlayingMovie{
//    _isPlaying = NO;
//    
//}

@end
