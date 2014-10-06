//
//  UIViewController+Utils.h
//  Miruzo
//
//  Created by setacinq on 4/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

+ (id)fromNib:(NSString *)nibName;
+ (id)fromNib;

+(id)fromStoryboard;
@end
