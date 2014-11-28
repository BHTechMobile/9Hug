//
//  Photo.m
//  9hug
//
//  Created by DuongMac on 11/6/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "Photo.h"

@implementation Photo
+(Photo *)createByDictionary:(NSDictionary*)dict
{
    
//    Photo* photo = [Photo new];
//    
//    photo.pid = [NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
//    photo.message_id = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message_id"]];
//    photo.media_link = [dict valueForKey:@"media_link"];
//    photo.message = [dict valueForKey:@"message"];
  //  photo.sent_date = [NSDate dateFromTimeInterval:[dict valueForKey:@"sent_date"]];
//    photo.type = [NSString stringWithFormat:@"%@",[dict valueForKey:@"type"]];
//    photo.userid = [NSString stringWithFormat:@"%@",[dict valueForKey:@"userid"]];
//    
    NSString* pid = [dict stringForKey:@"id"];
    Photo* photo = [Photo getPhotoById:pid];
    if (!photo) {
        photo = [Photo MR_createEntity];
        photo.pid = [dict stringForKey:@"id"];
    }
    photo.message_id = [dict stringForKey: @"message_id"];
    photo.media_link = [dict stringForKey:@"media_link"];
    photo.message = [dict stringForKey:@"message"];
    photo.sent_date = [NSDate dateFromTimeInterval:[dict stringForKey:@"sent_date"]];
    photo.type = [dict stringForKey:@"type"];
    photo.userid = [dict stringForKey:@"userid"];
    return photo;
}


+(Photo*)getPhotoById:(NSString*)pid
{
    return [Photo MR_findFirstByAttribute:@"pid" withValue:pid];

}


@end
