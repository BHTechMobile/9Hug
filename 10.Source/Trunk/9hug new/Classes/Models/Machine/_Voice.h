//
//  _Voice.h
//  9hug
//
//  Created by DuongMac on 11/11/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const struct VoiceAttributes {
    __unsafe_unretained NSString *media_link;
    __unsafe_unretained NSString *message;
    __unsafe_unretained NSString *vid;
    __unsafe_unretained NSString *sent_date;
    __unsafe_unretained NSString *type;
    __unsafe_unretained NSString *userid;
    __unsafe_unretained NSString *message_id;
    
}VoiceAttributes;
extern const struct VoiceRelationships {
    
} VoiceRelationships;

extern const struct VoiceFetchedProperties {
} VoiceFetchedProperties;


@interface VoiceID : NSManagedObjectID {}
@end
@class _Voice;
@interface _Voice : NSManagedObject{}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (VoiceID*)objectID;
@property (nonatomic, strong) NSString* message_id;
@property (nonatomic, strong) NSString* vid;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* userid;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* media_link;
@property (nonatomic, strong) NSDate* sent_date;

@end
