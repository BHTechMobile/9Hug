//
//  EnterMessageController.h
//  9hug
//
//  Created by setacinq on 6/25/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EnterMessageView;

@protocol EnterMessageDelegate <NSObject>

-(void)enterMessageDidCancel;
-(void)enterMessage:(EnterMessageView*)enterMessageController DidEnterMessage:(NSString*)message;

@end

@interface EnterMessageView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,weak)id<EnterMessageDelegate>delegate;

-(void)showUpKeyboard;

@end
