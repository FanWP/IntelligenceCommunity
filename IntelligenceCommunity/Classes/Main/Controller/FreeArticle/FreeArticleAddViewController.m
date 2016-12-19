//
//  FreeArticleAddViewController.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleAddViewController.h"




@interface FreeArticleAddViewController ()

@end

@implementation FreeArticleAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"闲置物品添加";

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //设置基本控件
    [self setupControls];
}

- (void)setupControls
{
    //设置顶部的标题和物品详情
    //标题的输入框
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(16, 64 + 12, KWidth - 32, 35)];
    titleText.placeholder = @"输入标题";
    [self.view addSubview:titleText];
    
    //输入物品详情
    YYPlaceholderTextView *detailText = [[YYPlaceholderTextView alloc] initWithFrame:CGRectMake(25,64 + 59, KWidth - 50, 130)];
    detailText.placeholder = @"输入物品详情";
    [self.view addSubview:detailText];
    
    
    
}



@end
