//
//  DownloadVideoView.m
//  9hug
//
//  Created by Quang Mai Van on 6/29/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "DownloadVideoView.h"
#import "YLProgressBar.h"
#import "BaseServices.h"
#import "HMessage.h"

@interface DownloadVideoView ()

@property (weak, nonatomic) IBOutlet YLProgressBar *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIView *activeView;

@end

@implementation DownloadVideoView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _activeView.layer.cornerRadius = 8;
    _activeView.layer.masksToBounds = YES;
    _activeView.layer.borderColor = [UIColor blackColor].CGColor;
    _activeView.layer.borderWidth = 0.0;
    
    _progressView.type               = YLProgressBarTypeFlat;
    _progressView.progressTintColor = [UIColor colorWithHex:0x007aff];
    _progressView.trackTintColor = [UIColor colorWithHex:0xb5b6b7];
    _progressView.hideStripes        = YES;
    _progressView.behavior           = YLProgressBarBehaviorDefault;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)downloadVideoByMessage:(HMessage*)message
{
    message.downloadedValue = NO;
    NSString* output = [message localVideoPath];
    unlink([output UTF8String]);
    [_progressView setProgress:0.0 animated:YES];
    [BaseServices downloadVideoUrl:message.attachement1 outputPath:output sussess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        message.downloadedValue = YES;
        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfWithCompletion:nil];
        
        if (_delegate && [_delegate respondsToSelector:@selector(downloadVideoSuccess)]) {
            [_delegate downloadVideoSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        message.downloadedValue = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(downloadVideoFailure)]) {
            [_delegate downloadVideoFailure];
        }
        
    } progress:^(float progress) {
        [_progressView setProgress:progress animated:YES];
        _progressLabel.text = [NSString stringWithFormat:@"Downloading %d%%",(int)(progress*100)];
    }];
}

@end
