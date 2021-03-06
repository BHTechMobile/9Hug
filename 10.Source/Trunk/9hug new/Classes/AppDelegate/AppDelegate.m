//
//  AppDelegate.m
//  9hug
//
//  Created by Quang Mai Van on 6/23/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MeViewController.h"
#import "FacebookManager.h"
#import "Crittercism.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [Crittercism enableWithAppID:@"543e3c1e0729df7748000003" andDelegate:self];
    
    [Crittercism beginTransaction:@"App Start"];
    [Crittercism setMaxOfflineCrashReports:5];
    
    UIImage *navBarImage;
    navBarImage = [UIImage imageNamed:@"nav_bg"];
    
    [[UINavigationBar appearance] setBackgroundImage: navBarImage forBarMetrics:UIBarMetricsDefault];
    
    // Override point for customization after application launch.

    [MagicalRecord setupAutoMigratingCoreDataStack];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    ScanerController * _scanController = [[ScanerController alloc] initWithNibName:nil bundle:nil];
    _codeVC = [[CodeViewController alloc] initWithNibName:nil bundle:nil];
    _codeNC = [[UINavigationController alloc] initWithRootViewController:_codeVC];
    [_codeNC.navigationBar customNavigationBar];
    _codeNC.tabBarItem.image = [UIImage imageNamed:@"btn_bar_code"];
    _codeNC.tabBarItem.title = @"Code";

    _messagesVC = [[MsgController alloc] initWithNibName:nil bundle:nil];
    _messagesNC = [[UINavigationController alloc] initWithRootViewController:_messagesVC];
    [_messagesNC.navigationBar customNavigationBar];

    _messagesNC.tabBarItem.image = [UIImage imageNamed:@"btn_bar_messages"];
    _messagesNC.tabBarItem.title = @"Messages";

    _meVC = [[MeViewController alloc] initWithNibName:nil bundle:nil];
    _meNC = [[UINavigationController alloc] initWithRootViewController:_meVC];
    [_meNC.navigationBar customNavigationBar];
    _meNC.tabBarItem.image = [UIImage imageNamed:@"btn_bar_me"];
    _meNC.tabBarItem.title = @"Me";

    _publicVC = [[PublicViewController alloc] initWithNibName:nil bundle:nil];
    _publicNC = [[UINavigationController alloc] initWithRootViewController:_publicVC];
    [_publicNC.navigationBar customNavigationBar];
    _publicNC.tabBarItem.image = [UIImage imageNamed:@"btn_bar_public"];
    _publicNC.tabBarItem.title = @"Public";

    _friendsVC = [[FriendsViewController alloc] initWithNibName:nil bundle:nil];
    _friendsNC = [[UINavigationController alloc] initWithRootViewController:_friendsVC];
    [_friendsNC.navigationBar customNavigationBar];
    _friendsNC.tabBarItem.image = [UIImage imageNamed:@"btn_bar_friends"];
    _friendsNC.tabBarItem.title = @"Friends";
    
    _tabbar = [[NHTabbarViewController alloc] init];
    
    _tabbar.viewControllers = @[_meNC,_friendsNC,_codeNC,_messagesNC,_publicNC];
    [_tabbar selectTab:2];

    self.window.rootViewController = _tabbar;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor blackColor];

    [[FacebookManager sharedManager] awakeFBSession];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [Crittercism endTransaction:@"App Continue"];
    [Crittercism endTransaction:@"App Start"];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [Crittercism beginTransaction:@"App Continue"];
    [FBAppCall handleDidBecomeActiveWithSession:self.session];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [Crittercism endTransaction:@"App Continue"];
    [Crittercism endTransaction:@"App Start"];

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Facebook handleOpenURL

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:self.session];
}
#pragma mark- CrittercismSDK delegate

- (void)crittercismDidCrashOnLastLoad{
    [Crittercism logError:[NSError errorWithDomain:@"BHTech Mobile" code:501 userInfo:@{NSLocalizedDescriptionKey:@"App crash"}]];
}


@end
