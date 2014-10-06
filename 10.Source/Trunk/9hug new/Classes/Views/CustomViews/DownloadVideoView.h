//
//  DownloadVideoView.h
//  9hug
//
//  Created by Quang Mai Van on 6/29/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DownloadVideoDelegate <NSObject>

-(void)downloadVideoSuccess;
-(void)downloadVideoFailure;

@end

@class HMessage;
@interface DownloadVideoView : UIView

@property(nonatomic,weak)id<DownloadVideoDelegate>delegate;

-(void)downloadVideoByMessage:(HMessage*)message;

@end
