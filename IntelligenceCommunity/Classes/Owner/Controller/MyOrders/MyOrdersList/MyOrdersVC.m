//
//  MyOrdersVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MyOrdersVC.h"

#import "AllOrdersTableVC.h"   // 全部订单
#import "WaitPaymentTableVC.h" // 待付款
#import "WaitReceiveTableVC.h" // 待收货

#import "NeighborhoodCircleHeaderView.h"


@interface MyOrdersVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) NeighborhoodCircleHeaderView *orderHeaderView;

@property (nonatomic,weak) UIScrollView *contentView;

@property (nonatomic,assign) MyOrdersType myOrdersType;


@end

@implementation MyOrdersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeComponent];
    
    [self setupChildVces];
    
    [self setupContentView];
}

- (void)setupChildVces
{
    AllOrdersTableVC *allOrdersTableVC = [[AllOrdersTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    allOrdersTableVC.allOrderType = AllOrders;//邻里
    [self addChildViewController:allOrdersTableVC];
    
    WaitPaymentTableVC *waitPaymentTableVC = [[WaitPaymentTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    waitPaymentTableVC.waitPaymentType = WaitPayment;//邻里
    [self addChildViewController:waitPaymentTableVC];
    
    WaitReceiveTableVC *waitReceiveTableVC = [[WaitReceiveTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    waitReceiveTableVC.waitReceiveType = WaitReceive;//邻里
    [self addChildViewController:waitReceiveTableVC];
    
}


- (void)initializeComponent{
    
    [_orderHeaderView removeFromSuperview];
    
    NeighborhoodCircleHeaderView *headerView = [[NeighborhoodCircleHeaderView alloc] initWithFrame:CGRectMake(0, 64, KWidth, 43) titles:@[@"全部",@"待付款",@"待收货"] clickBlick:^void(NSInteger index) {
        
        [self titleClick:(index - 1)];
        
        NSLog(@"%ld",index);
    }];
    headerView.titleSelectColor = GreenColer;
    headerView.titleFont = UIFontLargest;
    
    _orderHeaderView = headerView;
    [self.view addSubview:headerView];
}

- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.x = 0;
    contentView.y = 88;
    contentView.height = self.view.bounds.size.height - 20;
    contentView.width = self.view.width;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}


- (void)titleClick:(NSInteger)index
{
    _orderHeaderView.defaultIndex = index + 1;
    _myOrdersType = index + 1;
    
    CGPoint offset = _contentView.contentOffset;
    offset.x = index * _contentView.width;
    [_contentView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height - 20; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:index];
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
