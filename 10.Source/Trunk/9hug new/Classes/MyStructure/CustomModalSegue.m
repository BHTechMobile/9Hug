//
//  CustomModalSegue.m
//  9hug
//
//  Created by setacinq on 6/30/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "CustomModalSegue.h"

@implementation CustomModalSegue

-(void)perform {
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    sourceViewController.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    destinationController.view.alpha = 0.0;
    [sourceViewController.navigationController presentViewController:destinationController animated:NO completion:nil];
    [UIView beginAnimations: nil context: nil];
    destinationController.view.alpha = 1.0;
    [UIView commitAnimations];
}


@end
