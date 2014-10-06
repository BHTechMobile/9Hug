//
//  MeViewController.h
//  9hug
//
//  Created by Tommy on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBSession.h>
#import "UserData.h"

@interface MeViewController : UIViewController<FBLoginViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbUsername;
@property (weak, nonatomic) IBOutlet UIImageView *olImageUser;
@property (weak, nonatomic) IBOutlet UIButton *btnStickers;
@property (weak, nonatomic) IBOutlet UILabel *labelStickers;
@property (weak, nonatomic) IBOutlet UIButton *btnGift;
@property (weak, nonatomic) IBOutlet UIButton *btnFriends;
@property (weak, nonatomic) IBOutlet UIButton *btnRequest;
@property (weak, nonatomic) IBOutlet UIButton *btnCredit;
@property (weak, nonatomic) IBOutlet UILabel *labelRequest;
@property (weak, nonatomic) IBOutlet UILabel *labelCredits;
@property (weak, nonatomic) IBOutlet UILabel *labelFriends;
@property (weak, nonatomic) IBOutlet UILabel *labelGift;
@property (weak, nonatomic) IBOutlet UILabel *labelCreditsAbove;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorAvatar;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@end
