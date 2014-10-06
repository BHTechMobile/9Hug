//
//  AudioRangerSelectorView.m
//  9hug
//
//  Created by setacinq on 6/30/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "AudioRangerSelectorView.h"

@interface AudioRangerSelectorView ()

@property(nonatomic,assign) CGFloat duration;

@property (weak, nonatomic) IBOutlet UIView *rangeView;

@end

@implementation AudioRangerSelectorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [_rangeView addGestureRecognizer:panRecognizer];
}

-(void)updateWithDuration:(float)duration
{
    _duration = duration;
    CGFloat audioLeng = [NSUserDefaults facebookLoggedIn] ? 15:12;
    
    if (_duration < audioLeng) {
        _rangeView.width = self.width;
        _rangeView.left = 0.0;
        return;
    }
    
    _rangeView.width = (audioLeng*self.width)/duration;
    _rangeView.left = 0.0;
}

-(void)move:(UIPanGestureRecognizer *)recognizer {
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:_rangeView.superview];
        CGRect old_rect = _rangeView.frame;
        
        old_rect.origin.x = old_rect.origin.x + movement.x;
        
        if (old_rect.origin.x <= 0) {
            old_rect.origin.x = 0;
        }
        
        if (old_rect.origin.x >= 240-_rangeView.width) {
            old_rect.origin.x = 240-_rangeView.width;
        }
        
        _rangeView.left = old_rect.origin.x;
        
        [recognizer setTranslation:CGPointZero inView:_rangeView.superview];
        
        
    }else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(audioRangerSelectorViewValueChanged)]) {
            [_delegate audioRangerSelectorViewValueChanged];
        }
    }
}

-(CGFloat)getSecondStartAt
{
    return (_rangeView.left*_duration)/self.width;
}
@end
