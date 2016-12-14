//
//  RootNavigationController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RootNavigationController.h"

@implementation RootNavigationController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self defaultNavigationBarStyle];
}

-(BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *viewController = self.viewControllers.lastObject;
    return [viewController preferredStatusBarStyle];
}

@end
