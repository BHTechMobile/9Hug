//
//  UIImage+Helpers.h
//  Miruzo
//
//  Created by setacinq on 4/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helpers)

-(UIImage *)imageWithOverlayColor:(UIColor *)color;
+(UIImage *)imageWithColor:(UIColor *)color;
+(UIImage*)customImageNamed:(NSString*)name;

-(UIImage*)scaledToWidth: (float) i_width;
-(UIImage*)scaledToHeight: (float) i_height;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
