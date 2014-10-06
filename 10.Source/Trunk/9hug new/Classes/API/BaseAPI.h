//
//  ExampleClient.h
//  AFNetworking
//
//  Created by Quang Mai Van on 10/7/13.
//  Copyright (c) 2013 CNC SOFT. All rights reserved.
//

#import <AFHTTPRequestOperationManager.h>

@class User,CDSession,Session;

typedef enum {
    METHOD_GET = 0,
    METHOD_POST,
    METHOD_PUT,
    METHOD_DELETE,
} METHOD;

typedef void (^SuccessResponse)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^FailureResponse)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^ProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface BaseAPI : AFHTTPRequestOperationManager

@property(nonatomic,strong) NSString*       token;

- (id)initClient;

-(id)initWithToken:(NSString*)token;

-(void)cancel;

-(NSString*)getMethodName:(METHOD)m;
-(AFHTTPRequestOperation*)requestByMethod:(METHOD)method widthPath:(NSString*)path withParameters:(NSDictionary*)dict success:(SuccessResponse)success failure:(FailureResponse)failure;

@end



