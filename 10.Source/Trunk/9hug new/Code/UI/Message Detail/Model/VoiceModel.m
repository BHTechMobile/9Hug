//
//  VoiceModel.m
//  9hug
//
//  Created by DuongMac on 11/11/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "VoiceModel.h"

@implementation VoiceModel
-(id)init{
    self = [super init];
    
    if(self){
        _voices = [NSMutableArray array];
        
    }
    return self;
}
-(void)loadVoiceFromDB{
    NSArray* voices = [_Voice MR_findAll];
    if (voices) {
        [_voices addObjectsFromArray:voices];
    }
}

-(void)getAllVoicesSuccess:(void (^)(id))success
                   failure:(void (^)(NSError *))failure :(NSString*)key
{
    
    
    [_voices removeAllObjects];
    [BaseServices getMessageByKey:key sussess:^(AFHTTPRequestOperation *operation, id responseObject)  {
        
        NSDictionary *dictVoice = (NSDictionary*)responseObject;
   
        for (NSDictionary *dicVoiceObject in [dictVoice objectForKey:@"voices"]) {
            Voice *voiceObject = [Voice createByDictionary:dicVoiceObject];
            [_voices addObject:voiceObject];
        }
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSString *bodyString, NSError *error) {
        NSLog(@"%@",bodyString);
        
        [self loadVoiceFromDB];
        if (failure) {
            failure(error);
        }
    }];
}
@end
