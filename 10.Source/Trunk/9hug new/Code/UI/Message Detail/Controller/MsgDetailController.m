//
//  MsgDetailController.m
//  9hug
//
//  Created by vtn on 8/1/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "MsgDetailController.h"

@interface MsgDetailController ()

@end

@implementation MsgDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadView{
    _msgDetailView = [[MsgDetailView alloc] init];
    self.view = _msgDetailView;
    [self.navigationItem setTitle:@"Message Detail"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

@end
