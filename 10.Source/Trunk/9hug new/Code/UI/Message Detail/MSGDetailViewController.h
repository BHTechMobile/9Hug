//
//  MSGDetailViewController.h
//  9hug
//
//  Created by vtn on 8/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/CALayer.h>

#import "Globals.h"
#import "HMessage.h"
#import "Voice.h"
#import "Photo.h"
#import "PhotoModel.h"
#import "MessageModel.h"
#import "VoiceModel.h"
#import "PlayerView.h"
#import "UIImage+Resize.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "LCVoice.h"
#import "SlideImageViewController.h"
#import "DownloadVideoView.h"
#import "SquareCamViewController.h"

@class PhotoModel;
@protocol PhoViewDataSource <NSObject>

-(PhotoModel*)getModel;

@end
@interface MSGDetailViewController : UIViewController<AVAudioPlayerDelegate,MPMediaPickerControllerDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,AVAudioRecorderDelegate,CameraDelegate>
{    

    NSURL *_recordURL;
    AVAudioPlayer * audioPlayer;
    NSTimer *playTimer;
    NSTimer *recordTimmer;
    NSMutableArray *_arrayAudios;
    NSMutableArray *_arrayPicture;
    NSMutableArray *_arrayPictureCaches;
    UIImagePickerController *_imagePicker;
    UIActionSheet *_imageSourceActionSheet;
    NSURL *urlRecord;
    NSDictionary *dicResponse;
    PhotoModel *photoModel;
    VoiceModel *voiceModel;
    MessageModel *messageModel;
}
- (IBAction)testViewPhoto:(id)sender;

@property (nonatomic,strong) NSMutableArray* photos;
@property (nonatomic,assign) id<MsgViewDataSource> datasource;
@property(nonatomic,retain) LCVoice * voice;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property(nonatomic,strong) PlayerView* videoPlayer;
@property(nonatomic,strong) MPMediaItem* audioItem;
@property(nonatomic,strong) NSURL* exportUrl;
@property(nonatomic,assign) BOOL mixed;
@property(nonatomic,strong) NSString* message;

@property (nonatomic, strong) HMessage *messageObj;
@property (nonatomic, strong) Photo *photoObj;
@property (nonatomic, strong) Voice *voiceObj;
@property (nonatomic, strong) DownloadVideoView *downloadView;

@property (nonatomic, strong) NSString *mKey;
@property (nonatomic, strong) NSURL *capturePath;
@property (nonatomic, strong) NSMutableArray* listPhotos;
@property (nonatomic, strong) NSMutableArray* listVoices;
@property (nonatomic) IBOutlet UIButton *_btnPlayRecordAudio;

@property (strong, nonatomic) IBOutlet UIView *viewExtend;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIView *viewAudio;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// Extend view
@property (weak, nonatomic) IBOutlet UIImageView *quoteButton;
@property (weak, nonatomic) IBOutlet UIImageView *theLine;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UILabel *labaleCreated;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentDuration;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalDuration;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeAudio;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollAudio;
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollPicture;
@property (weak, nonatomic) IBOutlet UILabel *labelFullName;
@property (weak, nonatomic) IBOutlet UILabel *labelSentDate;
@property (weak, nonatomic) IBOutlet UILabel *labelReads;
@property (weak, nonatomic) IBOutlet UITextView *textDescreption;
@property (weak, nonatomic) IBOutlet UIView *processViewAudio;
@property (weak, nonatomic) IBOutlet UIView *viewCurrentProcess;
@property (weak, nonatomic) IBOutlet UIImageView *imageCurrentAudio;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrentAudio;
@property (weak, nonatomic) IBOutlet UIView *viewMedia;
@property (weak, nonatomic) IBOutlet UIButton *btnPlayAll;
@property (weak, nonatomic) IBOutlet UIButton *btnAddimage;

// view record
@property (weak, nonatomic) IBOutlet UIView *viewRecord;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentRecord;
@property (weak, nonatomic) IBOutlet UIImageView *imageStatusRecord;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelRecord;
@property (weak, nonatomic) IBOutlet UIButton *btnSendRecord;
@property (weak, nonatomic) IBOutlet UIButton *btnRecord;

- (IBAction)clickCancelRecord:(id)sender;
- (IBAction)clickSendRecord:(id)sender;
- (IBAction)recordStart:(id)sender;
- (IBAction)recordEnd:(id)sender;
- (IBAction)sendRecord:(id)sender;
- (IBAction)holdAndRecord:(id)sender;
- (IBAction)playDefault:(id)sender;
-(IBAction)playAudio:(id)sender;
- (IBAction)addImage:(id)sender;

-(void)getMessageByKey:(NSString*)key;

@end
