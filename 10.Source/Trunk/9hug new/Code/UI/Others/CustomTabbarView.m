//
//  CustomTabbarView.m
//  9hug
//
//  Created by Tommy on 8/13/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "CustomTabbarView.h"

@implementation CustomTabbarView

- (id)initWithFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] objectAtIndex:0];
    self.frame = frame;
    return self;
}

-(void)selectTabIndex:(int)tabIndex{
    for (int i = 0; i<_buttons.count; i++) {
        UILabel * label = [_labels objectAtIndex:i];
        label.font = [UIFont fontWithName:@"Calibri" size:14];
        UIButton * button = [_buttons objectAtIndex:i];
        UIImageView * imv = [_icons objectAtIndex:i];
        if (i==tabIndex) {
            imv.highlighted = YES;
            label.textColor = [UIColor colorWithRed:108.0/255.0 green:202.0/255.0f blue:254.0/255.0 alpha:1];
            button.enabled = NO;
        }
        else{
            label.textColor = [UIColor colorWithRed:178.0/255.0 green:178.0/255.0f blue:178.0/255.0 alpha:1];
            imv.highlighted = NO;
            button.enabled = YES;
        }
    }
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)drawRect:(CGRect)rect
{
    for (int i = 0; i<_labels.count; i++) {
        UILabel * label = [_labels objectAtIndex:i];
        label.font = [UIFont fontWithName:@"Calibri" size:14];
    }
    // Drawing code

}

- (IBAction)clickedButton:(id)sender {

    [self selectTabIndex:[sender tag]];
    if (_delegate && [_delegate respondsToSelector:@selector(customTabbarView:didSelectTabIndex:) ]){
        [_delegate customTabbarView:self didSelectTabIndex:[sender tag]];
    }
}

@end
