//
//  neighborhoodSendMessageVC.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "neighborhoodSendMessageVC.h"
#import "YYPlaceholderTextView.h"

@interface neighborhoodSendMessageVC ()

@end

@implementation neighborhoodSendMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"发布动态";
    
    self.view.backgroundColor = MJRefreshColor(240, 240, 242);
    
    //设置发送按钮
    [self setupRightBar];
    
    [self setupControls];
    
}

- (void)setupRightBar
{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
}


- (void)rightBarClick
{
    MJRefreshLog(@"发送");

}

- (void)setupControls
{
    //设置输入框
    YYPlaceholderTextView *view = [[YYPlaceholderTextView alloc] initWithFrame:CGRectMake(20, 90, KWidth - 40, 200)];
    view.backgroundColor = [UIColor whiteColor];
    view.placeholder = @"我想说...";
    view.placeholderColor = [UIColor grayColor];
    [self.view addSubview:view];
}



@end
