//
//  MessageModel.m
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MessageModel.h"
#import "HMessage.h"

@implementation MessageModel


-(id)init{
    self = [super init];
    
    if(self){
        _messages = [NSMutableArray array];
        
    }
    return self;
}

-(void)loadMessageFromDB
{
    NSArray* messages = [HMessage MR_findAll];
    if (messages) {
        [_messages addObjectsFromArray:messages];
    }
}

-(void)getAllMessagesSuccess:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure
{
//    if (![NSUserDefaults facebookLoggedIn]) {
    
//        [self loadMessageFromDB];
//        [_iCarousel reloadData];
    
//        return;
//    }
    
    [_messages removeAllObjects];
    [BaseServices getAllMessageSussess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* dict = (NSDictionary*)responseObject;
        NSArray* aaData = [dict customObjectForKey:@"aaData"];
        NSLog(@"%@",aaData);
        for (NSDictionary* mDict in aaData) {
            HMessage* message = [HMessage createByDictionary:mDict];
            [_messages addObject:message];
        }
        
//        [self loadMessageFromDB];
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSString *bodyString, NSError *error) {
        NSLog(@"%@",bodyString);
        
        [self loadMessageFromDB];
        if (failure) {
            failure(error);
        }
    }];
}

-(void)ResetMessages:(HMessage*)message Success:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure
{
    //    if (![NSUserDefaults facebookLoggedIn]) {
    
    //        [self loadMessageFromDB];
    //        [_iCarousel reloadData];
    
    //        return;
    //    }
    

    [BaseServices resetMessage:message Sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [BaseServices getAllMessageSussess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSString *bodyString, NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
        
        
    } failure:^(NSString *bodyString, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
