//
//  HouseMembersTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseMembersTableVC.h"

#import "HouseMembersCell.h"

#import "HouseAuthorityModel.h"
#import "HouseModel.h"

@interface HouseMembersTableVC ()

@property (nonatomic,strong) NSArray *houseMembersArray;
@property (nonatomic,strong) HouseAuthorityModel *houseAuthorityModel;
@property (nonatomic,strong) NSArray *houseArray;
@property (nonatomic,strong) HouseModel *houseModel;
@property (nonatomic,strong) NSDictionary *houseDic;

@end

@implementation HouseMembersTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = HexColor(0xeeeeee);
    
    _houseMembersArray = [NSArray array];
    
    _houseArray = [NSArray array];
    
    [self dataMemberList];
}

- (void)dataMemberList
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"userId"] = UserID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/member/house",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         ICLog_2(@"家庭成员列表返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             _houseMembersArray = [HouseAuthorityModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
             
             _houseDic = [NSDictionary dictionary];
             
             for (NSDictionary *dic in responseObject[@"body"])
             {
                 _houseDic = [dic objectForKey:@"house"];
             }
             
             [self.tableView reloadData];
         }
         else
         {
             [HUD showErrorMessage:@"数据加载失败"];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [HUD showErrorMessage:@"数据加载失败"];
         ICLog_2(@"家庭成员返回错误：%@",error);
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
    return _houseMembersArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    footerView.backgroundColor = HexColor(0xeeeeee);
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headeraView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 35)];
    
    headeraView.backgroundColor = HexColor(0xeeeeee);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, headeraView.width - 30, 35)];
    
    titleLabel.font = UIFontNormal;
    
    titleLabel.text = _roomNumber;
    
    [headeraView addSubview:titleLabel];
    
    return headeraView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    HouseMembersCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[HouseMembersCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    _houseAuthorityModel = _houseMembersArray[indexPath.row];
    
    if ([_houseAuthorityModel.house_role isEqualToString:@"0"])
    {
        cell.identifierLabel.text = @"身份：业主";
    }
    else if ([_houseAuthorityModel.house_role isEqualToString:@"1"])
    {
        cell.identifierLabel.text = @"身份：家庭成员";
    }
    else 
    {
        cell.identifierLabel.text = @"身份：租户";
    }
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",_houseDic[@"masterName"]];
    cell.phoneNumberLabel.text = [NSString stringWithFormat:@"手机号：%@",_houseDic[@"masterPhone"]];
    
    return cell;
}

#pragma mark - 删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        _houseAuthorityModel = _houseMembersArray[indexPath.row];
        
        
        parameters[@"sessionId"] = SessionID;
        parameters[@"userId"] = UserID;
        
        ICLog_2(@"删除参数：%@",parameters);
        
        NSString *urlString = [NSString stringWithFormat:@"%@delete/member/house",URL_17_pro_api];
        
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
        {
            ICLog_2(@"删除返回：%@",responseObject);
            
            NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
            
            if (resultCode == 1000)
            {
                [HUD showSuccessMessage:@"删除成功"];
                
                [self dataMemberList];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
        {
            ICLog_2(@"删除失败：%@",error);
        }];
    }
}


- (HouseAuthorityModel *)houseAuthorityModel
{
    if (!_houseAuthorityModel)
    {
        _houseAuthorityModel = [[HouseAuthorityModel alloc] init];
    }
    
    return _houseAuthorityModel;
}

- (HouseModel *)houseModel
{
    if (!_houseModel)
    {
        _houseModel = [[HouseModel alloc] init];
    }
    
    return _houseModel;
}



@end








