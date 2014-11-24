//
//  Voice.h
//  9hug
//
//  Created by DuongMac on 11/11/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_Voice.h"
@interface Voice : _Voice{}
+(Voice*)createByDictionary:(NSDictionary*)dict;
+(Voice*)getVoiceById:(NSString*)vId;


@end
