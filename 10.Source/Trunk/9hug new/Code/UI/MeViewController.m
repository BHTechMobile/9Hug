//
//  MeViewController.m
//  9hug
//
//  Created by Tommy on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MeViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "FacebookManager.h"
#import <QuartzCore/QuartzCore.h>

@interface MeViewController (){
    UIButton *button1;
}
@property (nonatomic, strong) FacebookManager *_facebookManager;
@end

@implementation MeViewController
@synthesize _facebookManager;

#define objectLogin @"objectlogin"
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
    self.tfStatus.delegate = self;
    [_indicatorAvatar setHidden:YES];
    // Do any additional setup after loading the view from its nib.
    [self.olImageUser setHidden:NO];
    self.navigationItem.title = @"Me";
	[self setFontCalibri];
    _facebookManager = [FacebookManager sharedManager];
    [_facebookManager awakeFBSession];
    [self.olImageUser.layer setMasksToBounds:YES];
    [self.olImageUser.layer setCornerRadius:30];
    
    [_olImageUser setImage:[UIImage imageNamed:@"btn_me_add_photo.png"]];
    [_lbUsername setFont:CalibriFont(21.0)];
    if ([_facebookManager isFBSessionOpen]) {
        NSDictionary *dicUser = [[NSUserDefaults standardUserDefaults] objectForKey:objectLogin];
        [_lbUsername setText:[dicUser valueForKey:@"name"]];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",
                                           [dicUser objectForKey:@"id"]]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

        [self.olImageUser setImage:[self imageWithImage:image scaledToScale:2]];
//        [self.olImageUser setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
        
    }
    
    
    
    
    button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(10.0, 0.0, 30.0, 30.0)];
    [button1 addTarget:self action:@selector(Loginoutfb:) forControlEvents:UIControlEventTouchUpInside];
    //    if ([_facebookManager isFBSessionOpen] ) {
    if ([_facebookManager isFBSessionOpen] ) {
        [button1 setImage:[UIImage imageNamed:@"btn_me_logout@2x.png"] forState:UIControlStateNormal];
    }else{
        [button1 setImage:[UIImage imageNamed:@"btn_bar_me@2x.png"] forState:UIControlStateNormal];
    }
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)setFontCalibri{
    [_labelGift setFont:CalibriFont(21)];
    [_labelRequest setFont:CalibriFont(21)];
    [_labelStickers setFont:CalibriFont(28)];
    [_labelFriends setFont:CalibriFont(21)];
    [_labelCredits setFont:CalibriFont(21)];
    [_labelCreditsAbove setFont:CalibriFont(18)];
    [_lbUsername setFont:CalibriFont(28)];
    [_tfStatus setFont:CalibriFont(21)];
    [_btnGift.titleLabel setFont:CalibriFont(18)];
    [_btnRequest.titleLabel setFont:CalibriFont(18)];
    [_btnFriends.titleLabel setFont:CalibriFont(18)];
    [_btnCredit.titleLabel setFont:CalibriFont(18)];
    [_btnStickers.titleLabel setFont:CalibriFont(28)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.tfStatus) {
        [theTextField resignFirstResponder];
    }
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
-(void)Loginoutfb:(UIBarButtonItem *)sender{
    if ([_facebookManager isFBSessionOpen] ) {
        [Utilities showAlertViewWithTitle:@"" andMessage:@"Are you sure you want to logout?" andDelegate:self];
        }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [_facebookManager loginWithCompletion:^(BOOL success, NSDictionary *userInfo)
             {

                 [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:objectLogin];
                 [self Loginid:userInfo];
                 [self handleLogin:userInfo];
             }];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [_facebookManager logout];
        [button1 setImage:[UIImage imageNamed:@"btn_bar_me@2x.png"] forState:UIControlStateNormal];
        [_olImageUser setImage:[UIImage imageNamed:@"btn_me_add_photo.png"]];
        [_lbUsername setText:@""];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:objectLogin];
        [[UserData currentAccount] clearCached];
 
    }
}


-(void)Loginid:(NSDictionary *)user{
    //change icon


    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [_lbUsername setText:[user valueForKey:@"name"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",
                                       [user objectForKey:@"id"]]];
    if (user) {
        [_indicatorAvatar setHidden:NO];
        [_indicatorAvatar startAnimating];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        [_olImageUser setImage:image];
        [self.olImageUser setImage:[self imageWithImage:image scaledToScale:2]];
        [button1 setImage:[UIImage imageNamed:@"btn_me_logout@2x.png"] forState:UIControlStateNormal];
        [[UserData currentAccount] setStrFacebookToken:[[[_facebookManager getActiveFBSession] accessTokenData] accessToken]];
        [[UserData currentAccount] setStrFacebookId:[user valueForKey:@"id"]];
        [[UserData currentAccount] setStrFullName:[user valueForKey:@"name"]];
        NSDictionary *dicParam = @{@"code":[user valueForKey:@"id"],@"fullname":[user valueForKey:@"name"],@"facebookid":[user valueForKey:@"id"],@"facebook_token":[[[_facebookManager getActiveFBSession] accessTokenData] accessToken],@"nickname":[user valueForKey:@"name"],@"mobile":@"",@"email":[user valueForKey:@"email"],@"password":@""};
        [BaseServices createUserWithParam:dicParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response = %@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error = %@",error);
        }];
        /*
        [BaseServices loginWithCode:[user valueForKey:@"id"] fullName:[user valueForKey:@"name"] fbID:[user valueForKey:@"id"] fbToken:[[[_facebookManager getActiveFBSession] accessTokenData] accessToken] nickname:@""  mobile:@"" email:[user valueForKey:@"email"] password:@"" success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dicResponse = (NSDictionary *)responseObject;
            NSLog(@"responseObject = %@",responseObject);
            // delete all information of current user
            [[UserData currentAccount] setStrCode:[dicResponse valueForKey:@"code"]];
            [[UserData currentAccount] setStrEmail:[dicResponse valueForKey:@"email"]];
            [[UserData currentAccount] setStrFacebookToken:[dicResponse valueForKey:@"facebook_token"]];
            [[UserData currentAccount] setStrFacebookId:[dicResponse valueForKey:@"facebookid"]];
            [[UserData currentAccount] setStrFullName:[dicResponse valueForKey:@"fullname"]];
            [[UserData currentAccount] setStrNickname:[dicResponse valueForKey:@"nickname"]];
            [[UserData currentAccount] setStrMobile:[dicResponse valueForKey:@"mobile"]];
            [[UserData currentAccount] setStrPassword:[dicResponse valueForKey:@"password"]];
            [[UserData currentAccount] setStrId:[dicResponse valueForKey:@"id"]];
            [[UserData currentAccount] setStrCreateDate:[dicResponse valueForKey:@"createddate"]];
            NSLog(@"current user = %@",[[UserData currentAccount] strCode]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error = %@",error);
        }];
        */
    }else{
        [[UserData currentAccount] clearCached];
        [_indicatorAvatar setHidden:YES];
        [_olImageUser setImage:[UIImage imageNamed:@"btn_me_add_photo.png"]];
        [_lbUsername setText:[user valueForKey:@""]];
        [button1 setImage:[UIImage imageNamed:@"btn_bar_me@2x.png"] forState:UIControlStateNormal];
    }
}

- (void)handleLogin :(NSDictionary *)user{
   
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToScale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(59, 59), YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [image drawInRect:CGRectMake(0, 0, 59, 59)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
