//
//  QRCodeView.h
//  9hug
//
//  Created by Quang Mai Van on 6/29/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeView : UIView
@property (weak, nonatomic) IBOutlet UIControl *overlayView;

-(void)showQRCodeWithUrl:(NSString*)url;

@end
