//
//  MainViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MainViewController.h"
#import "HeaderView.h"
#import "NoticeCell.h"
#import "ServiceListCell.h"

#import "NoticeVC.h" // 公告
#import "CommunityViewController.h"  //社区服务
#import "FreeArticleViewController.h" //闲置物品
#import "RepairsViewController.h"     //报修
#import "PayMoneyViewController.h"    //缴费

#import "CommodityListViewController.h" //test
#import "PayMentViewController.h"

NSString *const NoticeViewCellIdentifier = @"noticeViewCellIdentifier";
NSString *const ServiceListCellIdentifier = @"ServiceListCellIdentifier";

//ServiceListCellDelegate   用来传递点击状态的协议
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,ServiceListCellDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"智慧社区";
    
    CommodityListViewController *vc = [[CommodityListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    
    
    [self initializeComponent];
    
    
}
-(void)initializeComponent{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_tableView];
    
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 270)];
    _tableView.tableHeaderView = headerView;
    
    [_tableView registerClass:[NoticeCell class] forCellReuseIdentifier:NoticeViewCellIdentifier];
    [_tableView registerClass:[ServiceListCell class] forCellReuseIdentifier:ServiceListCellIdentifier];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 60;
    }
    return 350;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        NoticeCell *cell =  [tableView dequeueReusableCellWithIdentifier:NoticeViewCellIdentifier forIndexPath:indexPath];
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = backView;

        return cell;
    }else{
        ServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:ServiceListCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = backView;
        
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
