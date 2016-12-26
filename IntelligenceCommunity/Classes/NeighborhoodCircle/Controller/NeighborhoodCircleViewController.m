//
//  NeighborhoodCircleViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//
#import "NeighborhoodCircleHeaderView.h"
#import "NeighborhoodCircleCell.h"

#import "NeighborhoodCircleViewController.h"
#import "NeighborhoodMainCommonTableVC.h" //公共的控制器
#import "NeighborhoodMessageTableVC.h"  //邻里圈消息的控制器
#import "neighborhoodSendMessageVC.h"  //邻里圈发活动  动态
#import "neiborhoodSendAppointVC.h"    //邻里圈约活动的发布
#import "NeiborhoodLookingForThingsVC.h"    //邻里圈寻物招领的发布


@interface NeighborhoodCircleViewController ()<UIScrollViewDelegate>


/** 中间的容器 */
@property (nonatomic,weak) UIScrollView *contentView;

/** 中间的容器 */
@property (nonatomic,weak) NeighborhoodCircleHeaderView *headerView;

/** 设置右上角的点击 */
@property (nonatomic,assign) NeighborhoodCircleType NeighborhoodType;

/** 设置右上角的按钮 */
@property (nonatomic,weak) UIButton *rightBtn;

/** 设置蒙版 */
@property (nonatomic,weak) UIView *coverView;


/** 设置右上角的图片 */
@property (nonatomic,weak) UIImage *rightBarImg;


/** 右上角的消息弹出框 */
@property (nonatomic,weak) UIImageView *NeighborhoodMainView;

@end

@implementation NeighborhoodCircleViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //右上角的
    [self setupRightBar];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initializeComponent];
    
    // 初始化子控制器
    [self setupChildVces];

    // 底部的scrollView
    [self setupContentView];
    self.tabBarController.navigationItem.title = @"邻里圈";
}

/** 右上角按钮 */
- (void)setupRightBar
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 40, 30)];
    if (  _NeighborhoodType && _NeighborhoodType != 1) {//已经创建过，图标可能要换
        [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(actiondccd) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = button;
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)actiondccd
{

    if ( _NeighborhoodType && _NeighborhoodType != 1) {//点击的是约 生活分享 寻物招领
        UIButton *button = [[UIButton alloc] init];
        button.tag = _NeighborhoodType;
        [self rightBarClick:button];
        return;
    }
    
    if (_coverView) return;
    UIView *coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    coverView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [coverView addGestureRecognizer:tap];
    self.coverView = coverView;
    [self.view addSubview:coverView];

    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop-down"]];
    imgView.x = KWidth - imgView.width - 5;
    imgView.y = 64;
    imgView.userInteractionEnabled  = YES;
    self.NeighborhoodMainView = imgView;
    [self.coverView addSubview:imgView];

    
    //设置子控件button
    NSArray *arr = @[@"消息",@"约活动",@"发动态",@"寻物招领"];
    NSArray *imgArr = @[@"information",@"activity",@"friend",@"goods"];

    for (NSInteger i = 0; i < arr.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.mj_x = 15;
        button.mj_h = 44;
        button.mj_w = 130;
        button.mj_y = i * button.mj_h + 10;
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

        button.tag = i + 1;
        [button addTarget:self action:@selector(rightBarClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font = UIFontLarge;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [imgView addSubview:button];
    }
}

-(void)rightBarClick:(UIButton *)button
{
    switch (button.tag) {
        case 1://消息
        {
            NeighborhoodMessageTableVC *vc = [[NeighborhoodMessageTableVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            MJRefreshLog(@"消息");
            break;
        }
        case 2://约活动
        {
            neiborhoodSendAppointVC * vc = [[neiborhoodSendAppointVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3://发动态
        {
            neighborhoodSendMessageVC *vc = [[neighborhoodSendMessageVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
        case 4://寻物招领
        {
            NeiborhoodLookingForThingsVC *vc = [[NeiborhoodLookingForThingsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
    
    //移除
    [self.coverView removeFromSuperview];
    
}


-(void)tap
{
    //移除
    [self.coverView removeFromSuperview];
}

- (void)setupChildVces
{
    NeighborhoodMainCommonTableVC *NeighborhoodVC = [[NeighborhoodMainCommonTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    NeighborhoodVC.NeighborhoodType = Neighborhood;//邻里
    [self addChildViewController:NeighborhoodVC];
    
    NeighborhoodMainCommonTableVC *NeighborhoodAppointmentVC = [[NeighborhoodMainCommonTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    NeighborhoodAppointmentVC.NeighborhoodType = NeighborhoodAppointment;//约
    [self addChildViewController:NeighborhoodAppointmentVC];
    
    NeighborhoodMainCommonTableVC *NeighborhoodShareLifeVC = [[NeighborhoodMainCommonTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    NeighborhoodShareLifeVC.NeighborhoodType = NeighborhoodShareLife;//生活分享
    [self addChildViewController:NeighborhoodShareLifeVC];
    
    NeighborhoodMainCommonTableVC *NeighborhoodLostFoundVC = [[NeighborhoodMainCommonTableVC alloc] initWithStyle:UITableViewStyleGrouped];
    NeighborhoodLostFoundVC.NeighborhoodType = NeighborhoodLostFound;//失物招领
    [self addChildViewController:NeighborhoodLostFoundVC];

}



- (void)initializeComponent{
    
    [self.headerView removeFromSuperview];
    
    NeighborhoodCircleHeaderView *headerView = [[NeighborhoodCircleHeaderView alloc] initWithFrame:CGRectMake(0, 64, KWidth, 43) titles:@[@"邻里",@"约",@"生活分享",@"寻物招领"] clickBlick:^void(NSInteger index) {

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
    _NeighborhoodType = index + 1;
    

    if (index != 0) {//邻里
        [self.rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    }else
    {
        [self.rightBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    }
    
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
    contentView.mj_y = 44;
    contentView.mj_h = self.view.bounds.size.height - 44 - 44;
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
