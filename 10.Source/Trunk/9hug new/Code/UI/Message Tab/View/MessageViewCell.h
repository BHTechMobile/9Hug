//
//  MessageViewCell.h
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageViewCellDelegate <NSObject>

@optional
- (void)resetMessageAtCell:(id)cell;

@end



@class HMessage;

@interface MessageViewCell : UITableViewCell<UIGestureRecognizerDelegate>
{
    IBOutlet UILabel *_messageTitel;
    IBOutlet UILabel *_messageContent;
    IBOutlet UILabel *_messageReceivedDate;
    IBOutlet UIImageView *_imgView;
    IBOutlet UIButton *_btnDelete;
    BOOL _isEditing;
    IBOutlet UIView *_contentView;
}

@property (nonatomic, assign)id<MessageViewCellDelegate> delegate;

-(void)setMessageData:(HMessage*)message;

-(IBAction)resetPress:(id)sender;

- (void)showDelete;
- (void)hideDelete;

@end
