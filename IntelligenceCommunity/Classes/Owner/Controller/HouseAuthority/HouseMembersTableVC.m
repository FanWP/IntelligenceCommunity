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


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
