//
//  VoiceModel.h
//  9hug
//
//  Created by DuongMac on 11/11/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Voice.h"
@interface VoiceModel : NSObject
@property (nonatomic,strong) NSMutableArray* voices;

-(id)init;


-(void)getAllVoicesSuccess:(void (^)(id result))success
                   failure:(void (^)(NSError *error))failure;
@end
