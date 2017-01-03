//
//  AllOrdersTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/27.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "AllOrdersTableVC.h"

#import "AppraiseVC.h"// 评价
#import "OrderDetailTableVC.h"// 订单详情

#import "MyOrdersStoreTitleCell.h"
#import "MyOrdersProductsCell.h"
#import "MyOrdersDealCell.h"


@interface AllOrdersTableVC ()

@end

@implementation AllOrdersTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.backgroundColor = [UIColor orangeColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self dataAllOrdersList];
}

- (void)dataAllOrdersList
{
    //    find/salelist/bystatus
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"userId"] = UserID;
    parameters[@"salestatus"] = @"1";//客户版: 1 全部查 2待付款 3待收货  //商户版: 4新订单 5催单 6退单  7进行中 8已完成  9已取消
    parameters[@"pageNum"] = @"1";
    parameters[@"pageSize"] = @"50";
    parameters[@"sessionId"] = SessionID;
    //    parameters[@"vendorid"] = @"";// 门店id（需要 查单个店面再订单传这个参数）
    //    parameters[@"saleid"] = @"";// 订单id（当需要查询单个订单详细时，只传一个id，其他参数不传就行）
    
    ICLog_2(@"所有订单列表参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/salelist/bystatus",URL_4_mall_api];
    
    ICLog_2(@"所有订单列表接口：%@",urlString);
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         ICLog_2(@"所有订单列表返回：%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         ICLog_2(@"所有订单错误：%@",error);
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 44;
    }
    else if (indexPath.row == 1)
    {
        return 110;
    }
    else
    {
        return 38;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    
    footerView.backgroundColor = HexColor(0xeeeeee);
    
    return footerView;
}

// 店铺名称cell
- (MyOrdersStoreTitleCell *)tableView:(UITableView *)tableView storeTitleCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    MyOrdersStoreTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[MyOrdersStoreTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    [cell.storeNameButton setTitle:@"米奇小妹妹的店" forState:(UIControlStateNormal)];
    [cell.statusButton setTitle:@"待付款" forState:(UIControlStateNormal)];
    return cell;
}

// 店铺里商品信息的cell
- (MyOrdersProductsCell *)tableView:(UITableView *)tableView productsCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"cell1";
    
    MyOrdersProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    
    if (cell == nil)
    {
        cell = [[MyOrdersProductsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
    }
    cell.titleLabel.text = @"红玫瑰";
    cell.detailLabel.text = @"季度利润比偶结构和宽容是";
    cell.priceLabel.text = @"$_$ 30";
    cell.countLabel.text = @"x2";
    return cell;
}

// 处理订单的cell
- (MyOrdersDealCell *)tableView:(UITableView *)tableView dealCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier2 = @"cell2";
    
    MyOrdersDealCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    
    if (cell == nil)
    {
        cell = [[MyOrdersDealCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier2];
    }
    cell.timeLabel.text = @"2016.12.23";
    [cell.firstButton setTitle:@"取消订单" forState:(UIControlStateNormal)];
    
    cell.secondButton.layer.borderColor = HexColor(0xf18f52).CGColor;
    [cell.secondButton setTitleColor:HexColor(0xf18f52) forState:(UIControlStateNormal)];
    [cell.secondButton setTitle:@"付款" forState:(UIControlStateNormal)];
    
    [cell.firstButton addTarget:self action:@selector(cancleOrderAction) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.secondButton addTarget:self action:@selector(payMentAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [self tableView:tableView storeTitleCellWithIndexPath:indexPath];
    }
    else if (indexPath.row == 1)
    {
        return [self tableView:tableView productsCellWithIndexPath:indexPath];
    }
    else
    {
        return [self tableView:tableView dealCellWithIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        AppraiseVC *appraiseVC = [[AppraiseVC alloc] init];
        [self.navigationController pushViewController:appraiseVC animated:YES];
    }
    else if (indexPath.section == 1)
    {
        OrderDetailTableVC *orderDetailTableVC = [[OrderDetailTableVC alloc] init];
        [self.navigationController pushViewController:orderDetailTableVC animated:YES];
    }
}


#pragma mark - 取消订单
- (void)cancleOrderAction
{
    //    cancel/salerecord
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消订单?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        _saleid = @"1";
        parameters[@"saleid"] = _saleid;
        parameters[@"userid"] = UserID;
        parameters[@"sessionId"] = SessionID;
        
        NSString *urlString = [NSString stringWithFormat:@"%@cancel/salerecord",URL_17_mall_api];
        
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             ICLog_2(@"取消订单返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 [HUD showSuccessMessage:@"取消成功"];
             }
             else
             {
                 [HUD showErrorMessage:@"取消失败"];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [HUD showErrorMessage:@"取消失败"];
             ICLog_2(@"取消订单错误：%@",error);
         }];
    }];
    
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 付款
- (void)payMentAction
{
    
}

@end
