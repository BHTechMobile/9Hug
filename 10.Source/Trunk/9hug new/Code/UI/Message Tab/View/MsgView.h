//
//  MsgView.h
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "MessageViewCell.h"

@class MessageModel;

@protocol MsgViewDataSource <NSObject>

-(MessageModel*)getModel;

@end

@protocol MsgViewDelegate <NSObject>
@optional

- (void)selectedCellAtIndex:(NSIndexPath*)index;
- (void)resetMessageCellAtIndex:(NSIndexPath*)index;
- (void)showMoreTapped;
- (void)addMessageTapped;

@end

@interface MsgView : UIView<UITableViewDataSource,UITableViewDelegate,MessageViewCellDelegate>
{
    IBOutlet UITableView* _msgTblView;
}

@property (weak,nonatomic) id<MsgViewDelegate> delegate;
@property (nonatomic,assign) id<MsgViewDataSource> datasource;


-(void) reloadTableView;

@end
