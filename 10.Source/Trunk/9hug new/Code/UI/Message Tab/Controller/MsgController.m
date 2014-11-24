//
//  MsgController.m
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MsgController.h"

#import "MSGDetailViewController.h"
#import "DownloadVideoView.h"

@interface MsgController ()<DownloadVideoDelegate>
{
    DownloadVideoView *_downloadView;
}
@end

@implementation MsgController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{


    _msgView = [[MsgView alloc] initWithFrame:CGRectZero];
    _msgModel = [[MessageModel alloc] init];
    
    [_msgView setDelegate:self];
    [_msgView setDatasource:self];
    self.view = _msgView;
    [self.navigationItem setTitle:@"Messages"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_msgModel getAllMessagesSuccess:^(id result) {
        
        NSLog(@"count : %lu",(unsigned long)_msgModel.messages.count);
        
        [_msgView reloadTableView];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
//    UIButton *addMessageButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    [addMessageButton addTarget:self action:@selector(mainAddMessage) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:addMessageButton];
//    [self.navigationItem setRightBarButtonItem:barButton];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _downloadView = [DownloadVideoView fromNib];
    _downloadView.alpha = 0.0;
    _downloadView.delegate = self;
    [self.view addSubview:_downloadView];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [APP_DELEGATE.tabbar showMe];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark MsgView Delegate
- (void)selectedCellAtIndex:(NSIndexPath*)index{
    MSGDetailViewController *msgDetailCtr = [MSGDetailViewController new];
    
     HMessage *message = [_msgModel.messages objectAtIndex:index.row];
    
    if (!message.downloadedValue && message.localVideoPath) {
        _downloadView.alpha = 1;
        [_downloadView showWithAnimation];
        [_downloadView downloadVideoByMessage:message];
    }
    else{
        msgDetailCtr.mKey = message.key;
        msgDetailCtr.capturePath = [NSURL fileURLWithPath:message.localVideoPath];
        [self.navigationController pushViewController:msgDetailCtr animated:YES];
        msgDetailCtr.messageObj = message;

    }
}




- (void)resetMessageCellAtIndex:(NSIndexPath*)index{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HMessage *message = [_msgModel.messages objectAtIndex:index.row];
    [_msgModel ResetMessages:message Success:^(id result) {
        
        [_msgView reloadTableView];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
}

- (void)showMoreTapped{
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Show more button tapped"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)addMessageTapped{
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Header Add Button tapped"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)mainAddMessage{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Navigation bar ADD button tapped"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - MsgView Datasource

-(MessageModel*)getModel{
    return _msgModel;
}

#pragma mark - Download Message

- (void)downloadVideoSuccess:(HMessage*)message {
    message.downloadedValue = YES;
    [_downloadView hideWithAnimation];
    MSGDetailViewController *msgDetailCtr = [MSGDetailViewController new];
    msgDetailCtr.mKey = message.key;
    msgDetailCtr.capturePath = [NSURL fileURLWithPath:message.localVideoPath];
    [self.navigationController pushViewController:msgDetailCtr animated:YES];
    msgDetailCtr.messageObj = message;
}

- (void)downloadVideoFailure:(HMessage*)message  {
    [_downloadView hideWithAnimation];
    [UIAlertView showTitle:@"Error" message:@"Cann't download this video"];
}


@end
