//
//  UIViewController+Utils.m
//  Miruzo
//
//  Created by setacinq on 4/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

/**
 *  Init with self name
 *
 *  @return id
 */

+ (id)fromNib
{
    NSString *nibName = NSStringFromClass(self);
    return [self fromNib:nibName];
}

/**
 *  Init with nibName
 *
 *  @param nibName NSString
 *
 *  @return id
 */

+ (id)fromNib:(NSString *)nibName
{
    return [[self alloc] initWithNibName:nibName bundle:nil];
}


+(id)fromStoryboard
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSString *nibName = NSStringFromClass(self);
    return [storyboard instantiateViewControllerWithIdentifier:nibName];
}
@end
