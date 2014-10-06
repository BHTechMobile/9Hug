//
//  SDWebImageManager+MJ.m
//  9hug
//
//  Created by Bùi Văn Huy on 9/24/14.
//  Copyright (c) 2014 Home. All rights reserved.
//


#import "SDWebImageManager+MJ.h"

@implementation SDWebImageManager (MJ)
+ (void)downloadWithURL:(NSURL *)url
{
    // cmp不能为空
    [[self sharedManager] downloadWithURL:url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        
    }];
}
@end
