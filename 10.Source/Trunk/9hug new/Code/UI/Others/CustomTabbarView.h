//
//  CustomTabbarView.h
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class CustomTabbarView;

@protocol CustomTabbarViewDelegate <NSObject>

-(void)customTabbarView:(CustomTabbarView*)view didSelectTabIndex:(int)tabIndex;

@end


@interface CustomTabbarView : UIView
@property (assign, nonatomic) id<CustomTabbarViewDelegate> delegate;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *icons;

-(void)selectTabIndex:(int)tabIndex;

@end
