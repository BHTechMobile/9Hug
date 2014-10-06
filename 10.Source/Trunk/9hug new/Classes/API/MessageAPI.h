//
//  MessageAPI.h
//  9hug
//
//  Created by Quang Mai Van on 6/24/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "BaseAPI.h"

@class HMessage;

typedef void (^MessageResponse)(NSString* bodyString, NSError *error);
typedef void (^DownloadResponse)(float progress);

@interface MessageAPI : BaseAPI

-(void)getMessageByKey:(NSString*)key sussess:(SuccessResponse)success failure:(MessageResponse)failure;

-(void)getAllMessageSussess:(SuccessResponse)success failure:(MessageResponse)failure;

-(void)resetMessage:(HMessage*)message Sussess:(SuccessResponse)success failure:(MessageResponse)failure;

-(void)uploadFileWithToken:(NSString*)token messageID:(NSString*)messageId type:(NSString*)type path:(NSURL*)videoPath sussess:(SuccessResponse)success failure:(MessageResponse)failure;

-(void)updateMessage:(NSString*)message key:(NSString*)key frame:(NSString*)frame path:(NSURL*)videoPath notification:(BOOL)notiF scheduled:(NSString*)scheduled sussess:(SuccessResponse)success failure:(MessageResponse)failure;

+(void)downloadVideoUrl:(NSString*)videoUrl
             outputPath:(NSString*)outputPath
                sussess:(SuccessResponse)success
                failure:(FailureResponse)failure
               progress:(DownloadResponse)progress;
@end
