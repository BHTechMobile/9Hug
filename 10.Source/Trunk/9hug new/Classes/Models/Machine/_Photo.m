//
//  _Photo.m
//  9hug
//
//  Created by DuongMac on 11/6/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "_Photo.h"

const struct PhotoAttributes PhotoAttributes = {
    .media_link = @"media_link",
    .message = @"message",
    .pid = @"pid",
    .sent_date = @"sent_date",
    .type = @"type",
    .userid = @"userid",
    .message_id = @"message_id",
      
};

const struct PhotoRelationships PhotoRelationships = {
    
};

const struct PhotoFetchedProperties PhotoFetchedProperties = {
};

@implementation PhotoID
@end
@implementation _Photo
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (PhotoID*)objectID {
    return (PhotoID*)[super objectID];
}

//+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
//    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
//    
//    if ([key isEqualToString:@"downloadedValue"]) {
//        NSSet *affectingKey = [NSSet setWithObject:@"downloaded"];
//        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
//        return keyPaths;
//    }
//    
//    return keyPaths;
//}
@dynamic pid;
@dynamic message_id;
@dynamic media_link;
@dynamic message;
@dynamic sent_date;
@dynamic type;
@dynamic userid;
@end
