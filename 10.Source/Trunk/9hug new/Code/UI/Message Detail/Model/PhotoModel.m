//
//  PhotoModel.m
//  9hug
//
//  Created by DuongMac on 11/11/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel
-(id)init{
    self = [super init];
    
    if(self){
        _photos = [NSMutableArray array];
        
    }
    return self;
}
-(void)loadPhotoFromDB{
    NSArray* photos = [Photo MR_findAll];
    if (photos) {
        [_photos addObjectsFromArray:photos];
    }
}

-(void)getAllPhotosSuccess:(void (^)(id))success
                   failure:(void (^)(NSError *))failure :(NSString*)key
{
    
  
    [_photos removeAllObjects];
    [BaseServices getMessageByKey:key sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* dictPhoto = (NSDictionary*)responseObject;
        for (NSDictionary *dicPhotoObject in [dictPhoto objectForKey:@"photos"]) {
            Photo *photoObject = [Photo createByDictionary:dicPhotoObject];
            [_photos addObject:photoObject];
           
            
        }
        if (success) {
            success(responseObject);
        }
       
    } failure:^(NSString *bodyString, NSError *error) {
        NSLog(@"%@",bodyString);
        
        [self loadPhotoFromDB];
        if (failure) {
            failure(error);
        }
    }];
}

@end
