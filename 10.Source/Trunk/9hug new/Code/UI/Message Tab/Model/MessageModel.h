//
//  MessageModel.h
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,strong) NSMutableArray* messages;

-(id)init;

-(void)ResetMessages:(HMessage*)message Success:(void (^)(id result))success
             failure:(void (^)(NSError *error))failure;

-(void)getAllMessagesSuccess:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure;

@end
