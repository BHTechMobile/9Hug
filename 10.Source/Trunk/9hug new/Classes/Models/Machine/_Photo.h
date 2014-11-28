//
//  _Photo.h
//  9hug
//
//  Created by DuongMac on 11/6/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern const struct PhotoAttributes {
    __unsafe_unretained NSString *media_link;
    __unsafe_unretained NSString *message;
    __unsafe_unretained NSString *pid;
    __unsafe_unretained NSString *sent_date;
    __unsafe_unretained NSString *type;
    __unsafe_unretained NSString *userid;
    __unsafe_unretained NSString *message_id;
    
}PhotoAttributes;
extern const struct PhotoRelationships {
    
} PhotoRelationships;

extern const struct PhotoFetchedProperties {
} PhotoFetchedProperties;


@interface PhotoID : NSManagedObjectID {}
@end
@class _Photo;
@interface _Photo : NSManagedObject{}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PhotoID*)objectID;
@property (nonatomic, strong) NSString* message_id;
@property (nonatomic, strong) NSString* pid;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* userid;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* media_link;
@property (nonatomic, strong) NSDate* sent_date;

@end
