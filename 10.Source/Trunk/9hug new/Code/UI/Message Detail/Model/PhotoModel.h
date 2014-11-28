//
//  PhotoModel.h
//  9hug
//
//  Created by DuongMac on 11/11/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject
@property (nonatomic,strong) NSMutableArray* photos;

-(id)init;


-(void)getAllPhotosSuccess:(void (^)(id result))success
                   failure:(void (^)(NSError *error))failure;
@end
