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

@end

@implementation RepairStatusTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"报修状态";
    
    self.tableView.backgroundColor = HexColor(0xeeeeee);
    
    [self dataFindRepairStatus];
}



- (void)dataFindRepairStatus
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"sessionId"] = @"sessionId";
    parameters[@"pageNum"] = @"1";
    parameters[@"pageSize"] = @"10";
    parameters[@"userId"] = @"1";
    
    NSString *urlString = [NSString stringWithFormat:@"%@pro_api/find/repairRef/list",Smart_community_URL];

//    ICLog_2(@"-------:%@",parameters);
//    
//    NSString *urlString = @"find/repairRef/list";
//    
//    [[RequestManager manager] JSONRequestWithType:Pro_api urlString:urlString method:RequestMethodPost timeout:50 parameters:parameters success:^(id  _Nullable responseObject)
//    {
//        ICLog_2(@"报修状态返回：%@",responseObject);
//        
//        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
//        
//        if (resultCode == 1000)
//        {
//            
//            self.repairStatusMArray = [RepairModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
//            
//            [self.tableView reloadData];
//        }
//        else
//        {
//            ICLog_2(@"不是1000");
//        }
//        
//    } faile:^(NSError * _Nullable error)
//    {
//        ICLog_2(@"报修状态返回错误：%@",error);
//        
//    }];
    
    ICLog_2(@"接口：：%@",urlString);
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"报修状态返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            
            self.repairStatusMArray = [RepairModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            
            [self.tableView reloadData];
        }
        else
        {
            ICLog_2(@"不是1000");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        ICLog_2(@"报修状态返回错误：%@",error);
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
    

//    cell.contentLabel.text = @"您好，您提交的报修正在抢救中";
//    cell.timeLabel.text = @"2016.10.30";
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






















