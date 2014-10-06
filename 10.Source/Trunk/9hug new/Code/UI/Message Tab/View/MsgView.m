//
//  MsgView.m
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MsgView.h"

//#import "MessageViewCell.h"


@implementation MsgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] objectAtIndex:0];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void) reloadTableView{
    [_msgTblView reloadData];
}

- (void)showMoreTapped{
    
}

- (void)addMessageTapped{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(addMessageTapped)]){
        [self.delegate addMessageTapped];
    }
}

#pragma mark TableView Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"count : %d",[_datasource getModel].messages.count);
    return [_datasource getModel].messages.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Gifts - Stickers";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if(indexPath.row < [_datasource getModel].listSubscribeChannel.count){
    static NSString* cellIdentify = @"MessageViewCell";
    MessageViewCell* cell = (MessageViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[MessageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }    
    [cell setDelegate:self];
   HMessage* message = (HMessage*)[[_datasource getModel].messages objectAtIndex:indexPath.row];
    [cell setMessageData:message];
    [cell hideDelete];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark TableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_delegate && [_delegate respondsToSelector:@selector(selectedCellAtIndex:)]){
//        Channel* chn = (Channel*)[[_datasource getModel].listSubscribeChannel objectAtIndex:indexPath.row];
        [_delegate selectedCellAtIndex:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 60)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton* footerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [footerButton setTitle:@"Show more..." forState:UIControlStateNormal];
    [footerButton.titleLabel setFont:[UIFont regularAppFontOfSize:14.0]];
    [footerButton addTarget:self action:@selector(showMoreTapped) forControlEvents:UIControlEventTouchUpInside];
    footerButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    footerButton.layer.borderWidth = 0.0;
    [footerButton setFrame:CGRectMake(5, 2, tableView.frame.size.width - 5, 18)];
    
    [footerView addSubview:footerButton];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 60)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(20, 10, tableView.frame.size.width, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont regularAppFontOfSize:14.0];
    headerLabel.text = @"Gifts - Stickers";
    headerLabel.textAlignment = NSTextAlignmentLeft;
    
    UIButton* headerButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [headerButton addTarget:self action:@selector(addMessageTapped) forControlEvents:UIControlEventTouchUpInside];
    [headerButton setFrame:CGRectMake(tableView.frame.size.width - 37, 8, 20, 20)];
    
    
    [headerView addSubview:headerLabel];
    [headerView addSubview:headerButton];
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
#pragma mark Message Cell Delegate

- (void)resetMessageAtCell:(id)cell{
    MessageViewCell *currentCell = (MessageViewCell *)cell;
    NSIndexPath *indexPath = [_msgTblView indexPathForCell:currentCell];
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(resetMessageCellAtIndex:)]){
        [self.delegate resetMessageCellAtIndex:indexPath];
    }
}


@end
