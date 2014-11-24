//
//  Photo.h
//  9hug
//
//  Created by DuongMac on 11/6/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_Photo.h"
#import "_HMessage.h"
@interface Photo : _Photo{}
+(Photo*)getPhotoById:(NSString*)pId;
+(Photo *)createByDictionary:(NSDictionary*)dict;



@end
