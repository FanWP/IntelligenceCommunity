//
//  MainViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MainViewController.h"
#import "HeaderView.h"          //轮播图
#import "NoticeCell.h"          //公告
#import "ServiceListCell.h"     //四大服务入口
#import "MainCommodityAdvertiseViewCell.h"  //首页商品


#import "NoticeVC.h" // 公告
#import "CommunityViewController.h"  //社区服务
#import "FreeArticleViewController.h" //闲置物品
#import "RepairsViewController.h"     //报修
#import "PayMoneyViewController.h"    //缴费

#import <SDCycleScrollView/SDCycleScrollView.h>     //轮播图

#import "CommodityListViewController.h" //test
#import "PayMentViewController.h"
#import "DeterminePayViewController.h"
#import "AppointmentServiceViewController.h"
#import "FeeHistoryListViewController.h"


NSString *const NoticeViewCellIdentifier = @"noticeViewCellIdentifier";
NSString *const ServiceListCellIdentifier = @"ServiceListCellIdentifier";
NSString *const MainCommodityAdvertiseViewCellIdentifier = @"mainCommodityAdvertiseViewCellIdentifier";
//ServiceListCellDelegate   用来传递点击状态的协议
//SDCycleScrollViewDelegate  轮播图代理方法
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,ServiceListCellDelegate,SDCycleScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) SDCycleScrollView *cycleScrollView; //轮播图

@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"智慧社区";
    
    /** 解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
    [_cycleScrollView adjustWhenControllerViewWillAppera];
    
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"News"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(action:)];

    
    FeeHistoryListViewController *vc = [[FeeHistoryListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    
    
    [self initializeComponent];
    
}
-(void)action:(UIBarButtonItem *)item{
    ICLog_2(@"jkhkjh");
}
-(void)initializeComponent{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_tableView];
    
//    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kGetVerticalDistance(254))];
//    _tableView.tableHeaderView = headerView;

    NSArray * imagesArray = @[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"]];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, kGetVerticalDistance(254)) shouldInfiniteLoop:YES imageNamesGroup:imagesArray];
    _cycleScrollView.delegate = self;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.currentPageDotColor = HexColor(0x0dceac);
    _cycleScrollView.pageDotColor = HexColor(0xeeeeee);
    
    _tableView.tableHeaderView = _cycleScrollView;

    [_tableView registerClass:[NoticeCell class] forCellReuseIdentifier:NoticeViewCellIdentifier];
    [_tableView registerClass:[ServiceListCell class] forCellReuseIdentifier:ServiceListCellIdentifier];
    [_tableView registerClass:[MainCommodityAdvertiseViewCell class] forCellReuseIdentifier:MainCommodityAdvertiseViewCellIdentifier];
    
}
#pragma mark--SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ICLog_2(@"点击了第%ld张图片",index);
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
//    ICLog_2(@"当前滚动到第%ld几个图片",index);
}
#pragma mark--delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {       //公告
        return 60;
    }else if (indexPath.row == 1){  //服务列表
        return kGetVerticalDistance(144);
    }else{
        
        return kGetVerticalDistance(300);
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        NoticeCell *cell =  [tableView dequeueReusableCellWithIdentifier:NoticeViewCellIdentifier forIndexPath:indexPath];
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = backView;

        return cell;
    }else if (indexPath.row == 1){
        ServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:ServiceListCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = backView;
        
        return cell;
    }else{
        MainCommodityAdvertiseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCommodityAdvertiseViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        NoticeVC *noticeVC = [[NoticeVC alloc] init];
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
}
-(void)serviceListCell:(ServiceListCell *)serviceListCell buttonWithTag:(NSInteger)tag{
    if (tag == 1) {
        FreeArticleViewController *VC = [[FreeArticleViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (tag == 2){
        CommunityViewController *VC = [[CommunityViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        NSLog(@"社区服务");
    }else if (tag == 3){
        PayMoneyViewController *VC = [[PayMoneyViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (tag == 4){
        RepairsViewController *repairsViewController = [[RepairsViewController alloc] init];
        [self.navigationController pushViewController:repairsViewController animated:YES];
        NSLog(@"报修");
    }
    self.hidesBottomBarWhenPushed = YES;
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
