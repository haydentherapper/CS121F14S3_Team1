//
//  UIViewController+DismissSelf.m
//  SecurityGame
//
//  Created by Guest User on 12/4/14.
//  Copyright (c) 2014 BGKV. All rights reserved.
//

#import "UIViewController+DismissSelf.h"

@implementation UIViewController (DismissSelf)

- (IBAction)dismissSelfSegueT:(UIStoryboardSegue *)segue { }

- (IBAction)dismissSelfT
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
