
#import "NHTabbarViewController.h"
#import "Utilities.h"

@implementation NHTabbarViewController

- (id)init{
    self = [super init];
    if (self) {
        [self hideDefault];
        [self addCustomElements];
        [self showMe];
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
}

- (void)hideDefault
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
        
        
	}
    [self hideTabBar:YES];
}

- (void) hideTabBar:(BOOL)yesOrNo {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    for(UIView *view in self.view.subviews)
    {
        CGRect _rect = view.frame;
        if(![view isKindOfClass:[UITabBar class]]){
            if (!yesOrNo) {
                _rect.size.height = APP_SCREEN_HEIGHT-49;
                [view setFrame:_rect];
            } else {
                _rect.size.height = APP_SCREEN_HEIGHT;
                [view setFrame:_rect];
            }
        }
    }
    [UIView commitAnimations];
}

- (void)hideMe{
    _customTabbarView.hidden = YES;
    [self hideTabBar:YES];
}

- (void)trans{
    [self hideTabBar:YES];
}

- (void)showMe{
    _customTabbarView.hidden = NO;
    [self hideTabBar:NO];
}

-(void)addCustomElements
{
     _customTabbarView = [[CustomTabbarView alloc] initWithFrame:CGRectMake(0, APP_SCREEN_HEIGHT-143/2, 320, 143/2)];
    [self.view addSubview:_customTabbarView];
    _customTabbarView.delegate = self;
    
}

- (void)selectTab:(int)tabIndex
{
    if (self.selectedIndex==tabIndex) {
        return;
    }
    [self setSelectedIndex:tabIndex];
    [_customTabbarView selectTabIndex:tabIndex];
}

#pragma mark - CustomTabbarViewDelegate

-(void)customTabbarView:(CustomTabbarView *)view didSelectTabIndex:(int)tabIndex{
    if (self.selectedIndex==tabIndex) {
        return;
    }
    self.selectedIndex = tabIndex;

}

@end
