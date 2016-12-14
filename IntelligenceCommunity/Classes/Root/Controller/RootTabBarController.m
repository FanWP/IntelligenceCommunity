//
//  RootTabBarController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RootTabBarController.h"
#import "MainViewController.h"
#import "OfficialRecommendationViewController.h"
#import "KeyViewController.h"
#import "NeighborhoodCircleViewController.h"
#import "OwnerViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeComponent];
}

-(void)initializeComponent{
    
    
    MainViewController *MainController = [[MainViewController alloc] init];
    MainController.tabBarItem.title = @"主界面";
    MainController.tabBarItem.image = [UIImage imageNamed:@"compose_emoticonbutton_background"];
    MainController.tabBarItem.selectedImage = [[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    OfficialRecommendationViewController *OfficialRecommendationController = [[OfficialRecommendationViewController alloc] init];
    OfficialRecommendationController.tabBarItem.title = @"官方推荐";
    OfficialRecommendationController.tabBarItem.image = [UIImage imageNamed:@"compose_emoticonbutton_background"];
    OfficialRecommendationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    KeyViewController *keyController = [[KeyViewController alloc] init];
    keyController.tabBarItem.title = @"钥匙";
    keyController.tabBarItem.image = [UIImage imageNamed:@"compose_emoticonbutton_background"];
    keyController.tabBarItem.selectedImage = [[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NeighborhoodCircleViewController *neighborhoodCircleController = [[NeighborhoodCircleViewController alloc] init];
    neighborhoodCircleController.tabBarItem.title = @"邻里圈";
    neighborhoodCircleController.tabBarItem.image = [UIImage imageNamed:@"compose_emoticonbutton_background"];
    neighborhoodCircleController.tabBarItem.selectedImage = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    
    OwnerViewController *ownerController = [[OwnerViewController alloc] init];
    ownerController.tabBarItem.title = @"我的";
    ownerController.tabBarItem.image = [UIImage imageNamed:@"compose_emoticonbutton_background"];
    ownerController.tabBarItem.selectedImage = [[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self setViewControllers:@[MainController,OfficialRecommendationController,keyController,neighborhoodCircleController,ownerController]];
    self.selectedIndex = 0;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
