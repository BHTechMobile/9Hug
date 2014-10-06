//
//  MsgController.h
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MsgView.h"

#import "MessageModel.h"

@interface MsgController : UIViewController<MsgViewDelegate,MsgViewDataSource>
{
    MsgView *_msgView;
    MessageModel *_msgModel;
}

@end
