//
//  MixVideoViewController.h
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MBProgressHUD.h>
#import "HMessage.h"
#import "EnterMessageView.h"
#import "HMessage.h"
#import "AudioSetupViewController.h"
#import "MixEngine.h"
#import "ScheduleView.h"
#import "GPUImage.h"


@interface MixVideoViewController : UIViewController<MPMediaPickerControllerDelegate,EnterMessageDelegate,AudioSetupViewControllerDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate,GPUImageMovieDelegate>{
    NSArray * changeFrameButtons;
    GPUImageMovie *movieFile;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageMovieWriter *movieWriter;
    AVAudioPlayer * _audioPlayer;
    BOOL _isPlaying;
    NSString *_currentFilterClassString;
}

@property (nonatomic, strong) NSString *mKey;
@property (nonatomic, strong) NSURL *capturePath;
@property (nonatomic, strong) UIImage* imgFrame;
@property (nonatomic) CGFloat duration;
@property(nonatomic,assign) NSInteger indexFrame;

@property(nonatomic,strong) MPMediaItem* audioItem;
@property(nonatomic,strong) NSURL* exportUrl;
@property(nonatomic,assign) BOOL mixed;
@property(nonatomic,strong) NSString* message;
@property (weak, nonatomic) EnterMessageView *enterMessageView;
@property (weak, nonatomic) ScheduleView *scheduleView;
@property (weak, nonatomic) NSLayoutConstraint *topPosition;

@property (strong, nonatomic) IBOutlet GPUImageView *playerView;
@property (weak, nonatomic) IBOutlet UIImageView *imvFrame;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIScrollView *selectFrameScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *videoFilterScrollView;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIImageView *imvPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnFrames;
@property (weak, nonatomic) IBOutlet UIButton *btnVideoFilters;

@end
