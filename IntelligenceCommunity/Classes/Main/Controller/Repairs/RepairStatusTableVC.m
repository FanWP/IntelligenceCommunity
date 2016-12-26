//
//  RepairStatusTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/16.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RepairStatusTableVC.h"

#import "RepairStatusCell.h"// 报修状态的cell

#import "RepairModel.h"

@interface RepairStatusTableVC ()

@property (nonatomic,strong) NSMutableArray *repairStatusMArray;// 报修状态个数数组
@property (nonatomic,strong) RepairModel *repairModel;

@property (nonatomic,assign) NSInteger pageNum;

@end

@implementation RepairStatusTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"报修状态";
    
    self.tableView.backgroundColor = HexColor(0xeeeeee);
    
    [self dataFindRepairStatus];// 请求报修状态列表的数据
    
    [self dropdownRefresh];// 下拉刷新
    
    [self pullOnLoading];// 上拉加载
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [HUD dismiss];
}



- (void)dataFindRepairStatus
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"sessionId"] = SessionID;
    self.pageNum = 1;// 页数初始值为1
    parameters[@"pageNum"] = @(_pageNum);
    parameters[@"pageSize"] = @"10";
    parameters[@"userId"] = UserID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/repairRef/list",URL_17_pro_api];

    ICLog_2(@"接口：：%@",urlString);
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"报修状态返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            _pageNum++;
            
            _repairStatusMArray = [RepairModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            
            [self.tableView reloadData];
        }
        else
        {
            ICLog_2(@"不是1000");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        ICLog_2(@"报修状态返回错误：%@",error);
        
        [HUD showErrorMessage:@"数据加载失败"];
    }];
}

// 下拉刷新
- (void)dropdownRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_repairStatusMArray removeAllObjects];
        
        [self dataFindRepairStatus];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    }];
}

// 上拉加载
- (void)pullOnLoading
{
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"sessionId"] = @"sessionId";
        parameters[@"pageNum"] = @(_pageNum);
        parameters[@"pageSize"] = @"10";
        parameters[@"userId"] = @"1";
        
        NSString *urlString = [NSString stringWithFormat:@"%@pro_api/find/repairRef/list",Smart_community_URL];
        
        ICLog_2(@"接口：：%@",urlString);
        
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             ICLog_2(@"报修状态返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 _pageNum++;
                 
                 NSArray *moreArray = [RepairModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
                 
                 if (moreArray.count == 0)
                 {
                     [HUD showMessage:@"没有更多数据了"];
                 }
                 else
                 {
                     [_repairStatusMArray addObjectsFromArray:moreArray];
                     
                     [self.tableView reloadData];
                 }
             }
             else
             {
                 [HUD showErrorMessage:@"数据加载失败"];
                 
                 ICLog_2(@"没有更多数据了");
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             ICLog_2(@"报修状态返回错误：%@",error);
             
             [HUD showErrorMessage:@"数据加载失败"];
         }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _repairStatusMArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    RepairStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[RepairStatusCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    _repairModel = _repairStatusMArray[indexPath.row];
    
    cell.contentLabel.text = _repairModel.content;
    cell.timeLabel.text = _repairModel.createTime;
    
    return cell;
}



- (NSMutableArray *)repairStatusMArray
{
    if (!_repairStatusMArray)
    {
        _repairStatusMArray = [NSMutableArray array];
    }
    
    return _repairStatusMArray;
}

- (RepairModel *)repairModel
{
    if (!_repairModel)
    {
        _repairModel = [[RepairModel alloc] init];
    }
    
    return _repairModel;
}


@end






















