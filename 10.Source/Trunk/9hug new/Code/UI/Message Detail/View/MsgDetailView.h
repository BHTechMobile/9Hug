//
//  MsgDetailView.h
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MBProgressHUD.h>
#import "HMessage.h"
#import "PlayerView.h"
#import "FacebookView.h"
#import "MessageAPI.h"
#import "EnterMessageView.h"
#import "HMessage.h"
#import "AudioSettingController.h"
#import "MixEngine.h"
#import "ScheduleView.h"

@interface MsgDetailView : UIView<MPMediaPickerControllerDelegate,EnterMessageDelegate,AudioSettingControllerDelegate,UIAlertViewDelegate>{

}

@property(nonatomic,strong) IBOutlet PlayerView* videoPlayer;

@property (nonatomic, strong) NSString *mKey;
@property (nonatomic, strong) NSURL *capturePath;

@end
