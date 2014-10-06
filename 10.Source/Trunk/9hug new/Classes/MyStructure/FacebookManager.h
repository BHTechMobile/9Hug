//
//  FacebookManager.h
//  9hug
//
//  Created by Quang Mai Van on 6/28/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FacebookResponse)(id result);

@interface FacebookManager : NSObject

+(void)handleFacebookError:(NSError*)error;
+(void)requestPermissions:(NSArray*)permissions success:(void (^)(void))success;
+(void)shareMessage:(NSString*)message link:(NSString*)link;
+(void)likeUrl:(NSString*)urlString;
+(void)requestForMeSuccess:(FacebookResponse)success;

@end
