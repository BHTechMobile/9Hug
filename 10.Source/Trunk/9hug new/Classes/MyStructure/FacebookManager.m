//
//  FacebookManager.m
//  9hug
//
//  Created by Quang Mai Van on 6/28/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "FacebookManager.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation FacebookManager

+(void)handleFacebookError:(NSError*)error
{
    if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
        // Error requires people using an app to make an action outside of the app to recover
        // The SDK will provide an error message that we have to show the user
        [UIAlertView showTitle:@"Something went wrong" message:[FBErrorUtility userMessageForError:error]];
        
    } else {
        // If the user cancelled login
        if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
            [UIAlertView showTitle:@"Login cancelled" message:@"Your birthday will not be entered in our calendar because you didn't grant the permission."];
            
        } else {
            // For simplicity, in this sample, for all other errors we show a generic message
            // You can read more about how to handle other errors in our Handling errors guide
            // https://developers.facebook.com/docs/ios/errors/
            NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"]
                                               objectForKey:@"body"]
                                              objectForKey:@"error"];
            
            [UIAlertView showTitle:@"Something went wrong"
                           message:[NSString stringWithFormat:@"Please retry. \n If the problem persists contact us and mention this error code: %@",
                                                                    [errorInformation objectForKey:@"message"]]];
        }
    }
}

+(void)requestPermissions:(NSArray*)permissions success:(void (^)(void))success
{
    if (FBSession.activeSession.isOpen)
    {
        //not set
        if (!permissions) {
            success();
            return;
        }
        
        NSArray* oldPermissions = [[FBSession activeSession] permissions];
        NSMutableArray* newPermissions = [NSMutableArray arrayWithArray:permissions];
        
        for (NSString* permission in oldPermissions) {
            if ([newPermissions indexOfObject:permission] != NSNotFound) {
                [newPermissions removeObject:permission];
            }
        }
        
        //not has new
        if ([newPermissions count] == 0) {
            success();
            return;
        }
        NSLog(@"%@",newPermissions);
        //reauthorize
        [[FBSession activeSession] requestNewPublishPermissions:(NSArray*)newPermissions
                                                defaultAudience:FBSessionDefaultAudienceFriends
                                              completionHandler:^(FBSession *session, NSError *error) {
                                                    
                                                    if (error) {
                                                        [FacebookManager handleFacebookError:error];
                                                        return;
                                                    }
                                                    
                                                    success();
                                                }];
    }
    else
    {
        [FBSession openActiveSessionWithPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceFriends allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            if (error) {
                [FacebookManager handleFacebookError:error];
                return;
            }
            
            success();
        }];
        return;
        //authorize
        [FBSession openActiveSessionWithReadPermissions:permissions
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              [FacebookManager handleFacebookError:error];
                                              return;
                                          }
                                          
                                          success();
                                      }];
    }
}

+(void)shareMessage:(NSString*)message link:(NSString*)link
{
    
    [FacebookManager requestPermissions:@[@"publish_actions"] success:^{
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        if (message) {
            [params setObject:message forKey:@"message"];
        }
        
        if (link) {
            [params setObject:link forKey:@"link"];
        }
        
        [FBRequestConnection startWithGraphPath:@"me/feed"
                                     parameters:params
                                     HTTPMethod:@"POST"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error)
         {
             if (error) {
                 [FacebookManager handleFacebookError:error];
             } else {
                 NSLog(@"%@",result);
             }
         }];
    }];
    
    
}

+(void)likeUrl:(NSString*)urlString
{
    [FacebookManager requestPermissions:@[@"publish_actions"] success:^{
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                urlString, @"object",
                                [[[FBSession activeSession] accessTokenData] accessToken],@"access_token",
                                nil
                                ];
        FBRequest *uploadRequest = [FBRequest requestWithGraphPath:@"me/og.likes" parameters:params HTTPMethod:@"POST"];
        /* make the API call */
        [uploadRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (error) {
                [FacebookManager handleFacebookError:error];
            } else {
                NSLog(@"%@",result);
            }
        }];
        
        /* Debug
         NSString *urlToLikeFor = @"http://worldcup.thethaovanhoa.vn/world-cup-2014/tai-sao-ronaldo-xung-dang-duoc-ton-trong-du-bdn-bi-loai-n20140628071411650.htm";
         NSString *theWholeUrl = [NSString stringWithFormat:@"https://graph.facebook.com/me/og.likes?object=%@&access_token=%@", urlToLikeFor, [[[FBSession activeSession] accessTokenData] accessToken]];
         
         NSURL *facebookUrl = [NSURL URLWithString:theWholeUrl];
         
         NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:facebookUrl];
         [req setHTTPMethod:@"POST"];
         
         NSURLResponse *response;
         NSError *err;
         NSData *responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&err];
         NSString *content = [NSString stringWithUTF8String:[responseData bytes]];
         
         NSLog(@"responseData: %@", content);
         */
    }];
}

+(void)requestForMeSuccess:(FacebookResponse)success
{
    [FacebookManager requestPermissions:@[@"public_profile"] success:^{
        FBRequest *request = [FBRequest requestForMe];
        [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (error) {
                [FacebookManager handleFacebookError:error];
                return;
            }
            [NSUserDefaults saveObject:[[[FBSession activeSession] accessTokenData] accessToken] forKey:USER_LOGGEDIN_TOKEN];
            success(result);
        }];
    }];
}
@end

/*
-(void)postVideoToFacebook
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/export.mov"];
    NSData *videoData = [NSData dataWithContentsOfFile:pathToMovie];
    NSMutableDictionary<FBGraphObject>* params = [FBGraphObject graphObject];
    [params setDictionary:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                           videoData, @"video.mov",
                           @"video/quicktime", @"contentType",
                           @"", @"title",
                           @"Ghep nhac choi choi", @"description",nil]];
    
    FBRequest *uploadRequest = [FBRequest requestWithGraphPath:@"me/videos" parameters:params HTTPMethod:@"POST"];
    [uploadRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSLog(@"result %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [UIAlertView showError:error];
            return;
        }
        [UIAlertView showMessage:@"done"];
    }];
    
    return;
    
}
*/