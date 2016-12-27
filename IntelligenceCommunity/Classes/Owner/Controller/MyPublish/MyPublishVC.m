//
//  MyPublishVC.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/26.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MyPublishVC.h"


#import "NeighborhoodMainCommonTableVC.h"
#import "FreeArticleViewController.h"

#import "NeighborhoodCircleHeaderView.h"
@interface MyPublishVC ()<UIScrollViewDelegate>

/** headerView */
@property (nonatomic,weak) NeighborhoodCircleHeaderView *headerView;


/** 中间的容器 */
@property (nonatomic,strong) UIScrollView *contentView;

@end

@implementation MyPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的发布";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self defaultViewStyle];
    
    [self initializeComponent];
    
    [self setupChildVces];
    
    [self setupContentView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initializeComponent{
    
    [self.headerView removeFromSuperview];
    
    NeighborhoodCircleHeaderView *headerView = [[NeighborhoodCircleHeaderView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 43) titles:@[@"动态",@"活动",@"闲置物品"] clickBlick:^void(NSInteger index) {
        
        [self titleClick:(index - 1)];
        NSLog(@"%ld",index);
    }];
    headerView.titleSelectColor = GreenColer;
    headerView.titleFont = UIFont17;
    
    self.headerView = headerView;
    [self.view addSubview:headerView];
}


- (void)titleClick:(NSInteger)index
{
    
    //设置顶部的标题改变
    self.headerView.defaultIndex = index + 1;


    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = index * self.contentView.mj_w;
    [self.contentView setContentOffset:offset animated:YES];
     
}

- (void)setupChildVces
{
    NSString *myPulishURL = [NSString stringWithFormat:@"%@smart_community/release/info",Smart_community_URL];

    NSInteger pageNum = 1;
    NSInteger pageSize = 10;
    
    NSMutableDictionary *parmas1 = [NSMutableDictionary dictionary];
    parmas1[@"userId"] = UserID;
    parmas1[@"sessionId"] = SessionID;
    parmas1[@"pageNum"] = @(pageNum);
    parmas1[@"pageSize"] = @(pageSize);
    parmas1[@"type"] = @"1";
    
    NeighborhoodMainCommonTableVC *NeighborhoodAppointmentVC = [[NeighborhoodMainCommonTableVC alloc] init];
    NeighborhoodAppointmentVC.parmas = parmas1;//约
    NeighborhoodAppointmentVC.neiborhoodURL = myPulishURL;
    [self addChildViewController:NeighborhoodAppointmentVC];

    
    NSMutableDictionary *parmas2 = [NSMutableDictionary dictionary];
    parmas2[@"userId"] = UserID;
    parmas2[@"sessionId"] = SessionID;
    parmas2[@"pageNum"] = @(pageNum);
    parmas2[@"pageSize"] = @(pageSize);
    parmas2[@"type"] = @"2";
    NeighborhoodMainCommonTableVC *NeighborhoodShareLifeVC = [[NeighborhoodMainCommonTableVC alloc] init];
    NeighborhoodShareLifeVC.parmas = parmas2;
    NeighborhoodShareLifeVC.neiborhoodURL = myPulishURL;
    [self addChildViewController:NeighborhoodShareLifeVC];
    
    
    NSMutableDictionary *parmas3 = [NSMutableDictionary dictionary];
    parmas3[@"userId"] = UserID;
    parmas3[@"sessionId"] = SessionID;
    parmas3[@"pageNum"] = @(pageNum);
    parmas3[@"pageSize"] = @(pageSize);
    parmas3[@"type"] = @"3";
    FreeArticleViewController *FreeArticleViewVC = [[FreeArticleViewController alloc] init];
    FreeArticleViewVC.parmas = parmas3;
    FreeArticleViewVC.freeArticleURL = myPulishURL;
    [self addChildViewController:FreeArticleViewVC];
    
}



- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    //    contentView.frame = self.view.bounds;
    contentView.mj_x = 0;
    contentView.mj_y = 43;
    contentView.mj_h = self.view.bounds.size.height - 44 ;
    contentView.mj_w = self.view.mj_w;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.mj_x = scrollView.contentOffset.x;
    vc.view.mj_y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.mj_h = scrollView.height - 20; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:index];
}



@end
