//
//  BaseServices.m
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "BaseServices.h"

#define TIME_OUT_INTERVAL 10

@implementation BaseServices

+(AFHTTPRequestOperationManager*)sharedManager{
    AFHTTPRequestOperationManager * manager ;
    if (!manager) {
        manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://ws.9hug.com/api/"]];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setTimeoutInterval:TIME_OUT_INTERVAL];
    }
    return manager;
}

+(void)requestByMethod:(NSString*)method widthPath:(NSString*)path withParameters:(NSDictionary*)dict success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSMutableURLRequest *request = [[BaseServices sharedManager].requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:path relativeToURL:[BaseServices sharedManager].baseURL] absoluteString] parameters:dict error:nil];
    
    AFHTTPRequestOperation *operation =
    [[BaseServices sharedManager] HTTPRequestOperationWithRequest:request
                                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                              
                                                              if (success) {
                                                                  success(operation,[[self class] dictionaryFromData:operation.responseData error:nil]);
                                                              }
                                                              
                                                          }
                                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                              
                                                              NSLog(@"%@",[operation responseString]);
                                                              
                                                              if (error.code == NSURLErrorCancelled) {
                                                                  goto CALL_FAILURE;
                                                              }
                                                              
                                                              if (error.code == NSURLErrorNotConnectedToInternet) {
                                                                  goto CALL_FAILURE;
                                                              }
                                                              
                                                              if (error.code == NSURLErrorTimedOut) {
                                                                  goto CALL_FAILURE;
                                                              }
                                                              
#ifdef APPDEBUG
                                                              [APP_DELEGATE alertView:@"Error" withMessage:@"Somethings was wrong, please contact to Developer" andButton:@"OK"];
#endif
                                                          CALL_FAILURE:
                                                              if (failure) {
                                                                  failure(operation,error);
                                                              }
                                                              
                                                          }];
    [[BaseServices sharedManager].operationQueue addOperation:operation];
    
}




#pragma mark - Login/Logout Services

+ (void)createUserWithParam:(NSDictionary *)dicParam success:(SuccessBlock)success failure:(FailureBlock)failure{
    [[BaseServices sharedManager].requestSerializer setTimeoutInterval:30];
    [[BaseServices sharedManager] POST:@"user/create" parameters:dicParam
             constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
                 
             } success:^(AFHTTPRequestOperation *operation, id responseObject){
                 if (success) {
                     success(operation,[[self class] dictionaryFromData:operation.responseData error:nil]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error){
                 if (failure) {
                     failure(nil,error);
                 }
                 
             }];
}


+(void)loginWithCode:(NSString*)code fullName:(NSString*)fullName fbID:(NSString*)fbid fbToken:(NSString*)fbToken nickname:(NSString*)nickname mobile:(NSString*)mobile email:(NSString*)email password:(NSString*)password success:(SuccessBlock)success failure:(FailureBlock)failure{

    NSDictionary * params  = @{@"code":code,
                            @"fullname":fullName,
                            @"facebookid":fbid,
                            @"facebook_token":fbToken,
                            @"nickname":nickname,
                            @"mobile":mobile,
                            @"email":email,
                            @"password":password
                            };
    NSLog(@"params %@",params);
   //AFHTTPRequestOperation* operator =
 
    
}


#pragma mark - Message Services

+ (void)getMessageByKey:(NSString*)key sussess:(SuccessBlock)success failure:(MessageBlock)failure{
    NSDictionary* parameters = @{@"key":key};
    //@"token":@"9813bd3a1c9056f8b1449659299205f5"};
    [[BaseServices sharedManager].requestSerializer setTimeoutInterval:30];

    [BaseServices requestByMethod:@"GET" widthPath:@"message/get" withParameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

+(void)uploadAudioWithToken:(NSString*)token messageID:(NSString*)messageId type:(NSString*)type path:(NSURL*)audioPath sussess:(SuccessBlock)success failure:(MessageBlock)failure
{
    NSDictionary* dict;
    dict = @{@"token":token,
             @"message_id":messageId,
             @"type":type,
             };
    
    [[BaseServices sharedManager].requestSerializer setTimeoutInterval:300];
    
    AFHTTPRequestOperation* operator = [[BaseServices sharedManager] POST:@"message/response" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                        {
                                            NSData *audioData = [NSData dataWithContentsOfURL:audioPath];
                                            if (audioData == nil) {
                                                NSError* error = [NSError errorWithDomain:@"DataIsEmpty" code:404 userInfo:nil];
                                                failure(nil,error);
                                                return;
                                            }
                                            NSString *nameAudio = [NSString stringWithFormat:@"%@.aac",[NSString generateRandomString:8]];
                                            [formData appendPartWithFileData:audioData name:@"media_link" fileName:nameAudio mimeType:@"audio/x-hx-aac-adts"];
                                            
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
        NSLog(@"%lu /%lld",(unsigned long)totalBytesWritten,totalBytesWritten);
    }];
}

#pragma mark - UploadImage
+(void)uploadImage:(NSDictionary *)param path:(NSURL*)imagePath sussess:(SuccessBlock)success failure:(MessageBlock)failure
{
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.mycompany.myqueue", 0);
    
    dispatch_async(backgroundQueue, ^{
            UIImage *fetchImage = [Utilities setThumbnail:[UIImage imageWithContentsOfFile:URL_ATTACH_IMAGE] withSize:CGSizeMake(720, 720)];
            
        [[BaseServices sharedManager].requestSerializer setTimeoutInterval:300];
        
        AFHTTPRequestOperation* operator = [[BaseServices sharedManager] POST:@"message/response" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                            {
                                                
                                                
                                                NSData *imageData = UIImagePNGRepresentation(fetchImage);
                                                                                                if (imageData == nil) {
                                                    NSError* error = [NSError errorWithDomain:@"DataIsEmpty" code:404 userInfo:nil];
                                                    failure(nil,error);
                                                    return;
                                                }
                                                NSString *nameAudio = [NSString stringWithFormat:@"%@.jpg",[NSString generateRandomString:8]];
                                                [formData appendPartWithFileData:imageData name:@"media_link" fileName:nameAudio mimeType:@"jpeg/jpg"];
                                                
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
            NSLog(@"%lu /%lld",(unsigned long)totalBytesWritten,totalBytesExpectedToWrite);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{

        });
    });
}



+ (void)updateMessage:(NSString*)message key:(NSString*)key frame:(NSString*)frame path:(NSURL*)videoPath notification:(BOOL)notiF scheduled:(NSString*)scheduled sussess:(SuccessBlock)success failure:(MessageBlock)failure
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
    
    [[BaseServices sharedManager].requestSerializer setTimeoutInterval:300];
    
    AFHTTPRequestOperation* operator = [[BaseServices sharedManager] POST:@"message/update" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
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

+(void)getAllMessageSussess:(SuccessBlock)success failure:(MessageBlock)failure{

    NSDictionary* parameters = @{@"userid":[NSUserDefaults getStringForKey:USER_LOGGEDIN_ID]};
    
    [BaseServices requestByMethod:@"GET" widthPath:@"message/browse?sent=0" withParameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

+(void)resetMessage:(HMessage*)message Sussess:(SuccessBlock)success failure:(MessageBlock)failure{
    NSDictionary* parameters = @{@"userid":[NSUserDefaults getStringForKey:USER_LOGGEDIN_ID]};
    
    [BaseServices requestByMethod:@"GET" widthPath:[NSString stringWithFormat:@"message/reset?code=%@",message.code] withParameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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


#pragma mark - Download Video Services

+(void)downloadVideoUrl:(NSString*)videoUrl outputPath:(NSString*)outputPath sussess:(SuccessBlock)success failure:(FailureBlock)failure progress:(DownloadResponseBlock)progress{
    AFHTTPRequestOperationManager* manager = [BaseServices sharedManager];
    [manager.requestSerializer setTimeoutInterval:300];
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

+ (void)downloadAudio:(NSString *)baseUrl  sussess:(SuccessBlock)success failure:(FailureBlock)failure progress:(DownloadResponseBlock)progress{
    NSString* fileName = [NSString stringWithFormat:@"Documents/%@",[[baseUrl pathComponents] lastObject]];
    NSString *urlOutPut2 = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    
        AFHTTPRequestOperationManager* manager = [BaseServices sharedManager];
        [manager.requestSerializer setTimeoutInterval:300];

        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        AFHTTPRequestOperation *operation = [manager GET:baseUrl
                                              parameters:nil
                                                 success:^(AFHTTPRequestOperation *operation, NSData *responseData)
                                             {
                                                 if (success) {
                                                     success(operation,responseData);
                                                 }
                                             }
                                                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                             {
                                                 NSLog(@"Downloading error: %@", error);
                                             }];
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
         {
             //         [someProgressView setProgress:downloadPercentage animated:YES];
         }];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:urlOutPut2 append:YES];
}

#pragma mark - Utilities

+(id)dictionaryFromData:(id)data error:(NSError**)error{
    NSString *string=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    string= [string stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
    return [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:error];
}


@end
