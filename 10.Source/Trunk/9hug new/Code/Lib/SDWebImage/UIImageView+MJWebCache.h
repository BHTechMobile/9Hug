//
//  UIImageView+MJWebCache.h
//  9hug
//
//  Created by Bùi Văn Huy on 9/24/14.
//  Copyright (c) 2014 Home. All rights reserved.
//
#import "UIImageView+WebCache.h"

@interface UIImageView (MJWebCache)
- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder;
- (void)setImageURLStr:(NSString *)urlStr placeholder:(UIImage *)placeholder;
@end