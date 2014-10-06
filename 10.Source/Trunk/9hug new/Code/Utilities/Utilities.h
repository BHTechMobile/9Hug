//
//  Utilities.h
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#define appDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]

@interface Utilities : NSObject

+ (void) hideTabBar:(UITabBarController *) tabbarcontroller;
+ (void) showTabBar:(UITabBarController *) tabbarcontroller;

+(UIButton*)squareButtonWithSize:(CGFloat)size background:(UIImage*)background text:(NSString*)text target:(id)target selector:(SEL)selector tag:(int)tag isTypeFrame:(BOOL)type;
+(void)showAlertViewWithTitle :(NSString *)title andMessage:(NSString *)message andDelegate:(id)delegate;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIView *)viewSpace :(float)pointX;
+ (void)setBorderForView:(UIView *)view;
+ (NSString*)timeFromAudio:(float)value;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;
+ (CGFloat)getTextHeight :(UITextView *)m_pDesTextView;
+ (NSArray *)findFiles:(NSString *)extension;
+ (void)setImage :(UIImageView *)imageView andURLImage :(NSString *)strUrl addToArray:(NSMutableArray *)arrCache;
+ (void)setImageForButton:(UIButton *)btn andURLImage:(NSString *)strUrl andArrayCaches:(NSMutableArray *)arr;
+ (UIImage *)setThumbnail :(UIImage *)image withSize:(CGSize )destinationSize;
@end
