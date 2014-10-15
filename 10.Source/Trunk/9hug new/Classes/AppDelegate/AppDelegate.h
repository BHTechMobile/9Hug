//
//  AppDelegate.h
//  9hug
//
//  Created by Quang Mai Van on 6/23/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CodeViewController.h"
#import "MeViewController.h"
#import "FriendsViewController.h"
#import "MessagesViewController.h"
#import "PublicViewController.h"
#import "NHTabbarViewController.h"
#import "MsgController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "CrittercismDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CrittercismDelegate>

@property (strong, nonatomic) CodeViewController *codeVC;
@property (strong, nonatomic) MeViewController *meVC;
@property (strong, nonatomic) FriendsViewController *friendsVC;
@property (strong, nonatomic) MsgController *messagesVC;
@property (strong, nonatomic) PublicViewController *publicVC;

@property (strong, nonatomic) UINavigationController *codeNC;
@property (strong, nonatomic) UINavigationController *meNC;
@property (strong, nonatomic) UINavigationController *friendsNC;
@property (strong, nonatomic) UINavigationController *messagesNC;
@property (strong, nonatomic) UINavigationController *publicNC;


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NHTabbarViewController *tabbar;

@property (strong, nonatomic) FBSession *session;

@end
