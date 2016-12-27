//
//  ReceiveAddressTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ReceiveAddressTableVC.h"

#import "AddReceiveAddressVC.h"// 添加地址
#import "EditReceiveAddressVC.h"// 编辑地址

#import "ReceiveAddressCell.h"// 收货地址列表cell

#import "ReceiveAddressModel.h"

@interface ReceiveAddressTableVC ()

@property (nonatomic,strong) UIView *addReceiveAddressView;
@property (nonatomic,strong) UIButton *addReceiveAddressButton;// 添加地址

@property (nonatomic,strong) ReceiveAddressModel *receiveAddressModel;
@property (nonatomic,strong) NSMutableArray *receiveAddressArray;// 接收收货地址数据的数组

@end

@implementation ReceiveAddressTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收货地址";
    
    self.tableView.backgroundColor = HexColor(0xeeeeee);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self rightItemAddAddress];
}


- (void)rightItemAddAddress
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"➕" style:(UIBarButtonItemStylePlain) target:self action:@selector(addReceiveAddressAction)];
}

- (void)addReceiveAddressAction
{
    AddReceiveAddressVC *addReceiveAddressVC = [[AddReceiveAddressVC alloc] init];
    [self.navigationController pushViewController:addReceiveAddressVC animated:YES];
}

- (void)dataReceiveAddressList
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"userId"] = UserID;
    parameters[@"sessionId"] = SessionID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/address/list",URL_17_mall_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         ICLog_2(@"收货列表返回：%@",responseObject[@"body"]);
         
         if (resultCode == 1000)
         {
             _receiveAddressArray = [ReceiveAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
             
             [self.tableView reloadData];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         ICLog_2(@"收货列表错误：：%@",error);
     }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self dataReceiveAddressList];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [HUD dismiss];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _receiveAddressArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    
    headerView.backgroundColor = HexColor(0xeeeeee);
    
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    ReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[ReceiveAddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    _receiveAddressModel = _receiveAddressArray[indexPath.section];
    
    cell.defaultAddressButton.tag = indexPath.section;
    cell.editAddressButton.tag = indexPath.section;
    
    if ([_receiveAddressModel.type isEqual:@"1"])
    {
        cell.defaultAddressButton.selected = YES;
    }
    else
    {
        cell.defaultAddressButton.selected = NO;
    }
    
    cell.receiverLabel.text = [NSString stringWithFormat:@"收货人：%@",_receiveAddressModel.person];
    cell.receiverPhoneNumLabel.text = _receiveAddressModel.telephone;
    cell.receiveAddressLabel.text = [NSString stringWithFormat:@"%@%@",_receiveAddressModel.area,_receiveAddressModel.address];
    
    [cell.defaultAddressButton addTarget:self action:@selector(changeDefautAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [cell.editAddressButton addTarget:self action:@selector(editAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [cell.deleteAddressButton addTarget:self action:@selector(deleteAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}

- (void)changeDefautAddressAction:(UIButton *)button
{
    [self.tableView reloadData];
    
    button.selected = !button.selected;
    
    _receiveAddressModel = _receiveAddressArray[button.tag];
    
    if (button.selected == NO)
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        parameters[@"userId"] = UserID;
        parameters[@"type"] = @"0";
        parameters[@"id"] = _receiveAddressModel.ID;
        
        ICLog_2(@"编辑备用地址参数:%@",parameters);
        
        NSString *urlString = [NSString stringWithFormat:@"%@save/update/address",URL_17_mall_api];
        
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             ICLog_2(@"编辑备用地址返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 [HUD showSuccessMessage:@"设置成功"];
                 
                 _receiveAddressModel = nil;
                 
                 [self dataReceiveAddressList];
             }
             else
             {
                 [HUD showErrorMessage:@"编辑失败"];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [HUD showErrorMessage:@"编辑失败"];
             
             ICLog_2(@"编辑备用地址返回错误：%@",error);
             
         }];
    }
    else
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        parameters[@"userId"] = UserID;
        parameters[@"type"] = @"1";
        parameters[@"id"] = _receiveAddressModel.ID;
        
        ICLog_2(@"编辑默认地址参数:%@",parameters);
        
        NSString *urlString = [NSString stringWithFormat:@"%@save/update/address",URL_17_mall_api];
        
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             ICLog_2(@"编辑默认地址返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 [HUD showSuccessMessage:@"默认地址设置成功"];
                 
                 _receiveAddressModel = nil;
                 
                 [self dataReceiveAddressList];
             }
             else
             {
                 [HUD showErrorMessage:@"默认地址设置失败"];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [HUD showErrorMessage:@"编辑失败"];
             
             ICLog_2(@"编辑默认地址返回错误：%@",error);
             
         }];
    }
}

- (void)editAddressAction:(UIButton *)button
{
    EditReceiveAddressVC *editReceiveAddressVC = [[EditReceiveAddressVC alloc] init];
    editReceiveAddressVC.receiveAddressModel = _receiveAddressArray[button.tag];
    [self.navigationController pushViewController:editReceiveAddressVC animated:YES];
}

- (void)deleteAddressAction:(UIButton *)button
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    _receiveAddressModel = _receiveAddressArray[button.tag];
    
    parameters[@"ids"] = _receiveAddressModel.ID;
    parameters[@"userId"] = UserID;
    parameters[@"sessionId"] = SessionID;
    
    ICLog_2(@"删除地址参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@delete/address",URL_17_mall_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             [HUD showSuccessMessage:@"删除成功"];
             
             [self dataReceiveAddressList];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         ICLog_2(@"删除错误：%@",error);
     }];
}


@end



























