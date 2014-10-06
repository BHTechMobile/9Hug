//
//  QRCodeView.m
//  9hug
//
//  Created by Quang Mai Van on 6/29/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "QRCodeView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface QRCodeView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation QRCodeView

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
}

-(void)showQRCodeWithUrl:(NSString*)url
{
    [_imageView setImageWithURL:[NSURL URLWithString:url]];
}

@end
