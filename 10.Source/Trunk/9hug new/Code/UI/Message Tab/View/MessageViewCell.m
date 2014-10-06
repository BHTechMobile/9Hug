//
//  MessageViewCell.m
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MessageViewCell.h"

#import "HMessage.h"
#import "UIImageView+WebCache.h"
#import "Globals.h"

@implementation MessageViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] objectAtIndex:0];
        UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
        rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [rightRecognizer setNumberOfTouchesRequired:1];
        
        //add the gestureRecognizer
        [self addGestureRecognizer:rightRecognizer];
        
        UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
        leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [leftRecognizer setNumberOfTouchesRequired:1];
        
        [self addGestureRecognizer:leftRecognizer];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)resetPress:(id)sender{

    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(resetMessageAtCell:)]){
        [self.delegate resetMessageAtCell:self];
    }

}

-(void)setMessageData:(HMessage*)message{
    [self hideDelete];
    [_messageTitel setText:message.fullname];
    [_messageContent setText:[NSString stringWithFormat:@"%@-%@",message.key,message.text]];
    
    
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"dd/MM/yy HH:mm:ss"];
    NSString *sentDate = [_formatter stringFromDate:message.sentdate];
    [_messageReceivedDate setText:sentDate];//[self timestamp2date:[message.sentdate description]]];
    
    NSString *imgURL = [NSString stringWithFormat:@"%@%@",Thumbnail_Message_Cell_URL,message.key];
    
    [_imgView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"holder.png"] options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(error.code == 404){
            NSLog(@"Error: Image not found");
        }
    }];
    
}


- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self hideDelete];
    NSLog(@"rightSwipeHandle");
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self showDelete];
    NSLog(@"leftSwipeHandle");

}

- (void)showDelete
{
    if(_isEditing == NO){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        _contentView.frame = CGRectMake(_contentView.frame.origin.x - 65, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
        
        [_btnDelete setHidden:NO];
        
        [UIView commitAnimations];
        _isEditing = YES;
    }
}

- (void)hideDelete
{
    if(_isEditing == YES){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        _contentView.frame = CGRectMake(_contentView.frame.origin.x + 65, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);

        [_btnDelete setHidden:YES];
        
        [UIView commitAnimations];
        _isEditing = NO;
    }
    
}

@end
