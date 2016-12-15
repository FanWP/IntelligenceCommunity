//
//  NeighborhoodCircleViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodCircleViewController.h"
#import "NeighborhoodCircleHeaderView.h"
#import "NeighborhoodCircleCell.h"
#import "NeighborhoodMainCommonTableVC.h" //公共的控制器

@interface NeighborhoodCircleViewController ()<UIScrollViewDelegate>


/** 中间的容器 */
@property (nonatomic,weak) UIScrollView *contentView;

/** 中间的容器 */
@property (nonatomic,weak) NeighborhoodCircleHeaderView *headerView;

/** 设置右上角的点击 */
@property (nonatomic,assign) NeighborhoodCircleType NeighborhoodType;

@end

@implementation NeighborhoodCircleViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"邻里圈";

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initializeComponent];
    
    // 初始化子控制器
    [self setupChildVces];

    // 底部的scrollView
    [self setupContentView];
    
    //右上角的
    [self setupRightBar];

}


- (void)setupRightBar
{
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] style:UIBarButtonItemStylePlain target:self action:@selector(actiondccd)];
}

- (void)actiondccd
{
    ICLog(@"803428y0235");
    UIView *NeighborhoodMainView = [[UIView alloc] initWithFrame:CGRectMake(200, 64, 200, 100)];
    NeighborhoodMainView.backgroundColor = [UIColor redColor];
    [self.view addSubview:NeighborhoodMainView];
    
    //设置子控件button
    
    NSArray *arr = @[@"消息",@"约活动",@"发动态",@"寻物招领"];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.mj_x = 0;
        button.mj_h = 30;
        button.mj_w = 90;
        button.mj_y = i * button.mj_h;
        
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [NeighborhoodMainView addSubview:button];
    }
    
    
    
    
    
}


- (void)setupChildVces
{
    NeighborhoodMainCommonTableVC *NeighborhoodVC = [[NeighborhoodMainCommonTableVC alloc] init];
    NeighborhoodVC.type = Neighborhood;//邻里
    [self addChildViewController:NeighborhoodVC];
    
    NeighborhoodMainCommonTableVC *NeighborhoodAppointmentVC = [[NeighborhoodMainCommonTableVC alloc] init];
    NeighborhoodAppointmentVC.type = NeighborhoodAppointment;//约
    [self addChildViewController:NeighborhoodAppointmentVC];
    
    NeighborhoodMainCommonTableVC *NeighborhoodShareLifeVC = [[NeighborhoodMainCommonTableVC alloc] init];
    NeighborhoodShareLifeVC.type = NeighborhoodShareLife;//生活分享
    [self addChildViewController:NeighborhoodShareLifeVC];
    
    NeighborhoodMainCommonTableVC *NeighborhoodLostFoundVC = [[NeighborhoodMainCommonTableVC alloc] init];
    NeighborhoodLostFoundVC.type = NeighborhoodLostFound;//失物招领
    [self addChildViewController:NeighborhoodLostFoundVC];

}



- (void)initializeComponent{

    
    NeighborhoodCircleHeaderView *headerView = [[NeighborhoodCircleHeaderView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 50) titles:@[@"邻里",@"约",@"生活分享",@"寻物招领"] clickBlick:^void(NSInteger index) {

        [self titleClick:(index - 1)];
        
        NSLog(@"%ld",index);
    }];
    
    
    self.headerView = headerView;
    [self.view addSubview:headerView];
}



- (void)titleClick:(NSInteger)index
{
    //设置顶部的标题改变
    self.headerView.defaultIndex = index + 1;
    self.NeighborhoodType = index + 1;


    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = index * self.contentView.mj_w;
    [self.contentView setContentOffset:offset animated:YES];
}


- (void)setupContentView
{
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
//    contentView.frame = self.view.bounds;
    contentView.mj_x = 0;
    contentView.mj_y = 64;
    contentView.mj_h = self.view.bounds.size.height - 64 - 44;
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
    vc.view.mj_h = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
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
