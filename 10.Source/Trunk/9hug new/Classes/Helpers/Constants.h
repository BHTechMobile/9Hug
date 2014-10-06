//
//  Constants.h
//  TShot
//
//  Created by setacinq on 3/12/14.
//  Copyright (c) 2014 Seta. All rights reserved.
//

/* Categories */

#import "UIImage+Helpers.h"
#import "UIView+Utils.h"
#import "UIViewController+Utils.h"
#import "NSDictionary+Helpers.h"
#import "NSUserDefaults+Helpers.h"
#import "NSDate+Helpers.h"
#import "UIAlertView+Helpers.h"
#import "UIColor+Helpers.h"
#import "UIFont+Helpers.h"
#import "UIView+AutoLayout.h"
#import "NSString+Helpers.h"
#import "UINavigationBar+customBar.h"

/* Base Services*/

#import "BaseServices.h"

/* AppDelegate */

#import "AppDelegate.h"

#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/* MagicalRecord */

#import "CoreData+MagicalRecord.h"

/* MBProgressHUD */

#import "MBProgressHUD.h"

/* Cache Image*/

#import "FTWCache.h"
#import "NSString+MD5.h"

/* Screen */

#define kHeightScreen           [UIScreen mainScreen].bounds.size.height

/* Device */

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define URL_ATTACH_IMAGE [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"my_capture.jpg"]]
/* OS */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IOS_7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define IS_IOS_5 SYSTEM_VERSION_LESS_THAN(@"6.0")

/* User setting key */
#define TitleColor     [UIColor blackColor]
#define CalibriFont(fontSize) [UIFont fontWithName : @"Calibri" size : fontSize]
#define FaceookAppID @"521268487983316"

#define USER_LOGGEDIN_ID    @"USER_LOGGEDIN_ID"
#define USER_LOGGEDIN_NAME    @"USER_LOGGEDIN_NAME"
#define USER_LOGGEDIN_TOKEN    @"USER_LOGGEDIN_TOKEN"
#define USER_LOGGEDIN_AVATAR    @"USER_LOGGEDIN_AVATAR"

/* Debug */

#define debug(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])