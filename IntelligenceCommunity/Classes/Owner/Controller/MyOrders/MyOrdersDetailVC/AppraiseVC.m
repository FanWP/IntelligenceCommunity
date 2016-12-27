//
//  AppraiseVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/27.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "AppraiseVC.h"

@interface AppraiseVC ()

@property (nonatomic,strong) UIView *storeNameView;// 店铺名称view
@property (nonatomic,strong) UILabel *storeNameLabel;// 店铺名称
@property (nonatomic,strong) UIView *appraiseView;// 评价view
@property (nonatomic,strong) UILabel *appraiselabel;// 评价
@property (nonatomic,strong) UIButton *firstStarButton;
@property (nonatomic,strong) UIButton *secondStarButton;
@property (nonatomic,strong) UIButton *thirdStarButton;
@property (nonatomic,strong) UIButton *fourStarButton;
@property (nonatomic,strong) UIButton *fiveStar;
@property (nonatomic,strong) YYPlaceholderTextView *appraiseTextView;// 输入评价内容
@property (nonatomic,strong) UIView *anonymatView;// 匿名view
@property (nonatomic,strong) UILabel *anonymatLabel;// 匿名评论
@property (nonatomic,strong) UIButton *anonymatButton;// 是否匿名的button

@end

@implementation AppraiseVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initializeComponent
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
