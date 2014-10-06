//
//  CodeViewController.h
//  9hug
//
//  Created by Tommy on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXingObjC/ZXingObjC.h>
#import "HMessage.h"
#import "QuartzCore/CALayer.h"
#import "DownloadVideoView.h"
#import "VolumeView.h"
#import <FacebookSDK/FacebookSDK.h>
#import <QuartzCore/QuartzCore.h>

#define NICEHUG_DOMAIN @"www.9hug.com"

@interface CodeViewController : UIViewController<ZXCaptureDelegate,DownloadVideoDelegate,UITextFieldDelegate,AVCaptureMetadataOutputObjectsDelegate>{
    int _yesSwipe;
}

@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIButton *checkCodeButton;
@property (weak, nonatomic) IBOutlet UIView *scanRectView;
@property (weak, nonatomic) IBOutlet UIView *enterCodeView;
@property (weak, nonatomic) IBOutlet UITextField *enterCodeTextField;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *lblSwipe;

@property (weak, nonatomic) IBOutlet UIImageView *scannerSquareImv;
@property (nonatomic, strong) DownloadVideoView *downloadView;

@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, strong) HMessage *message;
@property (nonatomic, strong) NSString *mKey;
@property (nonatomic, assign) BOOL scaned;

@property (weak, nonatomic) IBOutlet UIImageView *imvAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (nonatomic, strong) AVCaptureSession *session;

- (IBAction)checkCodeButtonTapped:(UIButton *)sender;
- (IBAction)okButtonTapped:(id)sender;
@end
