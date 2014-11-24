//
//  _Voice.m
//  9hug
//
//  Created by DuongMac on 11/11/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "_Voice.h"
const struct VoiceAttributes VoiceAttributes = {
    .media_link = @"media_link",
    .message = @"message",
    .vid = @"vid",
    .sent_date = @"sent_date",
    .type = @"type",
    .userid = @"userid",
    .message_id = @"message_id",
    
};

const struct VoiceRelationships VoiceRelationships = {

};

const struct VoiceFetchedProperties VoiceFetchedProperties = {
};

@implementation VoiceID
@end
@implementation _Voice
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Voice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"Voice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"Voice" inManagedObjectContext:moc_];
}

- (VoiceID*)objectID {
    return (VoiceID*)[super objectID];
}


@dynamic vid;
@dynamic message_id;
@dynamic media_link;
@dynamic message;
@dynamic sent_date;
@dynamic type;
@dynamic userid;
@end
