//
//  ExampleClient.m
//  AFNetworking
//
//  Created by Quang Mai Van on 10/7/13.
//  Copyright (c) 2013 CNC SOFT. All rights reserved.
//

#import "BaseAPI.h"

NSString *const kMySiteBaseURL = @"http://ws.9hug.com/api/";
NSInteger const kNetworkingTimeout = 30;

@interface BaseAPI()

@end

@implementation BaseAPI

#pragma mark - init

- (id)initClient
{
    NSURL* url = [NSURL URLWithString:kMySiteBaseURL];
    
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.requestSerializer setTimeoutInterval:kNetworkingTimeout];
    
    return self;
}

-(id)initWithToken:(NSString*)token
{
    self = [self initClient];
    
    _token = token;
    
    return self;
}

#pragma mark - AFHTTPClient Services

-(NSString*)getMethodName:(METHOD)m
{
    switch (m) {
        case METHOD_POST:
            return @"POST";
        case METHOD_PUT:
            return @"PUT";
        case METHOD_DELETE:
            return @"DELETE";
        case METHOD_GET:
            return @"GET";
    }
    return @"GET";
}

-(void)cancel
{
    [[self operationQueue] cancelAllOperations];
}

-(AFHTTPRequestOperation*)requestByMethod:(METHOD)method
                                widthPath:(NSString*)path
                           withParameters:(NSDictionary*)dict
                                  success:(SuccessResponse)success
                                  failure:(FailureResponse)failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:[self getMethodName:method] URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:dict error:nil];
    
    AFHTTPRequestOperation *operation =
    [super HTTPRequestOperationWithRequest:request
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       if (success) {
                                           success(operation,responseObject);
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
    [self.operationQueue addOperation:operation];
    return operation;
}

@end





