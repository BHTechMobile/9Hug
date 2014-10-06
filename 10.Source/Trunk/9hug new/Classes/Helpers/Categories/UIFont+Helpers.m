//
//  UIFont+Helpers.m
//  Miruzo
//
//  Created by setacinq on 4/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "UIFont+Helpers.h"

@implementation UIFont (Helpers)

/**
 *  HelveticaNeue-Bold
 *
 *  @param size CGFloat
 *
 *  @return UIFont
 */

+(UIFont*)boldAppFontOfSize:(CGFloat)size
{
    return [self fontWithName:@"HelveticaNeue-Bold" size:size];
}

/**
 *  HelveticaNeue
 *
 *  @param size CGFloat
 *
 *  @return UIFont
 */

+(UIFont*)regularAppFontOfSize:(CGFloat)size
{
    return [self fontWithName:@"HelveticaNeue" size:size];
}

/**
 *  HelveticaNeue-Light
 *
 *  @param size CGFloat
 *
 *  @return UIFont
 */

+(UIFont*)lightAppFontOfSize:(CGFloat)size
{
    return [self fontWithName:@"HelveticaNeue-Light" size:size];
}

/**
 *  HelveticaNeue-Medium
 *
 *  @param size CGFloat
 *
 *  @return UIFont
 */

+(UIFont*)mediumAppFontOfSize:(CGFloat)size
{
    return [self fontWithName:@"HelveticaNeue-Medium" size:size];
}

/**
 *  HelveticaNeue-Thin
 *
 *  @param size CGFloat
 *
 *  @return UIFont
 */

+(UIFont*)thinAppFontOfSize:(CGFloat)size
{
    return [self fontWithName:@"HelveticaNeue-Thin" size:size];
}

/**
 *  HiraKakuProN-W6
 *
 *  @param size CGFloat
 *
 *  @return UIFont
 */

+(UIFont*)w6HiraKakuProNFontOfSize:(CGFloat)size
{
    return [self fontWithName:@"HiraKakuProN-W6" size:size];
}

/**
 *  HiraKakuProN-W3
 *
 *  @param size CGFloat
 *
 *  @return UIFont
 */

+(UIFont*)w3HiraKakuProNFontOfSize:(CGFloat)size
{
    return [self fontWithName:@"HiraKakuProN-W3" size:size];
}

/**
 *  Get all fonts
 *
 *  @return UIFont
 */

+(void)showAllFonts
{
    for (NSString* font in [UIFont familyNames]) {
        NSLog(@"%@",font);
        for (NSString* f in [UIFont fontNamesForFamilyName:font]) {
            NSLog(@"============>%@",f);
        }
    }
}
@end
