
#import <UIKit/UIKit.h>
#import "CustomTabbarView.h"

@interface NHTabbarViewController : UITabBarController<CustomTabbarViewDelegate> {
    CustomTabbarView * _customTabbarView;
}

-(void) selectTab:(int)tabIndex;

-(void) hideMe;
-(void) showMe;
-(void) trans;

@end
