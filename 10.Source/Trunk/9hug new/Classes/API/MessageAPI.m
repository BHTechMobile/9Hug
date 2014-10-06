//
//  MessageAPI.m
//  9hug
//
//  Created by Quang Mai Van on 6/24/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MessageAPI.h"
#import <AVFoundation/AVFoundation.h>

NSInteger const kNetworkingTimeoutForUploadAndDownload = 5*60;

@implementation MessageAPI

-(void)getMessageByKey:(NSString*)key sussess:(SuccessResponse)success failure:(MessageResponse)failure
{
    NSDictionary* parameters = @{@"key":key};
                                 //@"token":@"9813bd3a1c9056f8b1449659299205f5"};
    
    [self requestByMethod:METHOD_GET widthPath:@"message/get" withParameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(operation,responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString* bodyString = [operation responseString];
        
        if (failure) {
            failure(bodyString,error);
        }
        
    }];
}

-(void)uploadFileWithToken:(NSString*)token messageID:(NSString*)messageId message:(NSString*)message type:(NSString*)type path:(NSURL*)videoPath sussess:(SuccessResponse)success failure:(MessageResponse)failure
{
    NSDictionary* dict;
        dict = @{@"token":token,
                 @"message_id":messageId,
                 @"type":type,
                 @"message":message
                 };
    
    [self.requestSerializer setTimeoutInterval:kNetworkingTimeoutForUploadAndDownload];
    
    AFHTTPRequestOperation* operator = [self POST:@"message/response" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                        {
                                            NSData *videoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://dl.dropboxusercontent.com/s/dmom8tsdmjqa7vl/8bit_fast_menu002.mp3"]];
                                            if (videoData == nil) {
                                                NSError* error = [NSError errorWithDomain:@"DataIsEmpty" code:404 userInfo:nil];
                                                failure(nil,error);
                                                return;
                                            }
                                                
                                            [formData appendPartWithFileData:videoData name:@"media_link" fileName:@"MySound.caf" mimeType:@"audio/caf"];
                                            
                                        } success:^(AFHTTPRequestOperation *operation, id responseObject)
                                        {
                                            if (success) {
                                                success(operation,responseObject);
                                            }
                                            
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                        {
                                            if (failure) {
                                                failure([operation responseString],error);
                                            }
                                            
                                        }];
    [operator setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"%lu /%lld",(unsigned long)bytesWritten,totalBytesWritten);
    }];
}

-(void)updateMessage:(NSString*)message key:(NSString*)key frame:(NSString*)frame path:(NSURL*)videoPath notification:(BOOL)notiF scheduled:(NSString*)scheduled sussess:(SuccessResponse)success failure:(MessageResponse)failure
{
    NSDictionary* dict;
    if ([NSUserDefaults facebookLoggedIn]) {
        dict = @{@"key":key,
                 @"text":message,
                 @"frameid":frame,
                 @"userid":[NSUserDefaults getStringForKey:USER_LOGGEDIN_ID],
                 @"notification":@(notiF),
                 @"scheduled":scheduled};
    }else {
        dict = @{@"key":key,
                 @"text":message,
                 @"frameid":frame,
                 @"notification":@(notiF),
                 @"scheduled":scheduled};
    }
    
    [self.requestSerializer setTimeoutInterval:kNetworkingTimeoutForUploadAndDownload];
    
    AFHTTPRequestOperation* operator = [self POST:@"message/update" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                        {
                                            NSData *videoData = [NSData dataWithContentsOfURL:videoPath];
                                            if (videoData == nil) {
                                                NSError* error = [NSError errorWithDomain:@"DataIsEmpty" code:404 userInfo:nil];
                                                failure(nil,error);
                                                return;
                                            }
                                            
                                            [formData appendPartWithFileData:videoData name:@"attachement1" fileName:@"video.mp4" mimeType:@"video/mp4"];
                                            
                                        } success:^(AFHTTPRequestOperation *operation, id responseObject)
                                        {
                                            if (success) {
                                                success(operation,responseObject);
                                            }
                                            
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                        {
                                            if (failure) {
                                                failure([operation responseString],error);
                                            }

                                        }];
    [operator setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {

    }];
}

-(void)getAllMessageSussess:(SuccessResponse)success failure:(MessageResponse)failure
{
    NSDictionary* parameters = @{@"userid":[NSUserDefaults getStringForKey:USER_LOGGEDIN_ID]};
    
    [self requestByMethod:METHOD_GET widthPath:@"message/browse?sent=0" withParameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(operation,responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString* bodyString = [operation responseString];
        
        if (failure) {
            failure(bodyString,error);
        }
        
    }];
}

-(void)resetMessage:(HMessage*)message Sussess:(SuccessResponse)success failure:(MessageResponse)failure
{
    NSDictionary* parameters = @{@"userid":[NSUserDefaults getStringForKey:USER_LOGGEDIN_ID]};
    
    [self requestByMethod:METHOD_GET widthPath:[NSString stringWithFormat:@"message/reset?code=%@",message.code] withParameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(operation,responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString* bodyString = [operation responseString];
        
        if (failure) {
            failure(bodyString,error);
        }
        
    }];
}


+(void)downloadVideoUrl:(NSString*)videoUrl
             outputPath:(NSString*)outputPath
                sussess:(SuccessResponse)success
                failure:(FailureResponse)failure
               progress:(DownloadResponse)progress
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:kNetworkingTimeoutForUploadAndDownload];
    AFHTTPRequestOperation *op = [manager GET:videoUrl
                                    parameters:nil
                                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                           NSLog(@"success");
                                           if (success) {
                                               success(operation,responseObject);
                                           }
                                           
                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
                                           if (error.code == NSURLErrorCancelled) {
                                               return;
                                           }
                                           
                                           if (error.code == NSURLErrorNotConnectedToInternet) {
                                               [UIAlertView showTitle:@"Error" message:@"Cannot connect to server."];
                                               return;
                                           }
                                           
                                           if (error.code == NSURLErrorTimedOut) {
                                               [UIAlertView showTitle:@"Error" message:@"Connection timeout."];
                                               return;
                                           }
                                           
                                           if (failure) {
                                               failure(operation,error);
                                           }
                                       }];
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float pg = totalBytesRead / (float)totalBytesExpectedToRead;
        if (progress) {
            progress(pg);
        }
    }];
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:outputPath append:YES];
}
@end
