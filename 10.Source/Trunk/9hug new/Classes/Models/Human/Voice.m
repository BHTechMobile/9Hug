//
//  Voice.m
//  9hug
//
//  Created by DuongMac on 11/11/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "Voice.h"

@implementation Voice
+(Voice*)createByDictionary:(NSDictionary*)dict
{
    NSString* vid = [dict stringForKey:@"id"];
    Voice* voice = [Voice getVoiceById:vid];
    if (!voice) {
        voice = [Voice MR_createEntity];
        voice.vid = [dict stringForKey:@"id"];
    }
    voice.message_id = [dict stringForKey: @"message_id"];
    voice.media_link = [dict stringForKey:@"media_link"];
    voice.message = [dict stringForKey:@"message"];
    voice.sent_date = [NSDate dateFromTimeInterval:[dict stringForKey:@"sent_date"]];
    voice.type = [dict stringForKey:@"type"];
    voice.userid = [dict stringForKey:@"userid"];

    return voice;
}

+(Voice*)getVoiceById:(NSString *)vid
{
   return [Voice MR_findFirstByAttribute:@"vid" withValue:vid];

}

@end
