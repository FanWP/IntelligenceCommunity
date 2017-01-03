//
//  WaitReceiveTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/27.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "WaitReceiveTableVC.h"

#import "MyOrdersStoreTitleCell.h"
#import "MyOrdersProductsCell.h"
#import "MyOrdersDealCell.h"

@interface WaitReceiveTableVC ()

@end

@implementation WaitReceiveTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self dataWaitReceiveList];
}

- (void)dataWaitReceiveList
{
    //    find/salelist/bystatus
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"userId"] = UserID;
    parameters[@"salestatus"] = @"3";//客户版: 1 全部查 2待付款 3待收货  //商户版: 4新订单 5催单 6退单  7进行中 8已完成  9已取消
    parameters[@"pageNum"] = @"1";
    parameters[@"pageSize"] = @"10";
    parameters[@"sessionId"] = SessionID;
    //    parameters[@"vendorid"] = @"";// 门店id（需要 查单个店面再订单传这个参数）
    //    parameters[@"saleid"] = @"";// 订单id（当需要查询单个订单详细时，只传一个id，其他参数不传就行）
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/salelist/bystatus",URL_17_mall_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         ICLog_2(@"待收货列表返回：%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         ICLog_2(@"待收货错误：%@",error);
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
    
    cell.statusButton.layer.borderWidth = 1.0;
    cell.statusButton.layer.borderColor = [UIColor blackColor].CGColor;
    cell.statusButton.layer.cornerRadius = 5.0;
    [cell.statusButton setTitle:@"催单" forState:(UIControlStateNormal)];
    [cell.statusButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [cell.statusButton addTarget:self action:@selector(remindAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}
- (void)remindAction
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    _saleid = @"1";
    
    parameters[@"saleid"] = _saleid;
    parameters[@"express"] = @"1";
    parameters[@"sessionId"] = SessionID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@express/status/salerecord",URL_17_mall_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"催单返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            [HUD showSuccessMessage:@"催单成功"];
        }
        else
        {
            [HUD showErrorMessage:@"催单失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [HUD showErrorMessage:@"催单失败"];
        ICLog_2(@"催单错误：%@",error);
    }];
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
    [cell.firstButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
    cell.secondButton.layer.borderColor = HexColor(0x05c4a2).CGColor;
    [cell.secondButton setTitleColor:HexColor(0x05c4a2) forState:(UIControlStateNormal)];
    [cell.secondButton setTitle:@"确认收货" forState:(UIControlStateNormal)];
    
    [cell.secondButton addTarget:self action:@selector(confirmReceiveAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}
- (void)confirmReceiveAction
{
//    confrim/salestatus/salerecord
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认收货?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        _saleid = @"1";
        
        parameters[@"saleid"] = _saleid;
        parameters[@"salestatus"] = @"3";
        parameters[@"buytype"] = @"1";// 1商品 2服务
        parameters[@"sessionId"] = SessionID;
        
        NSString *urlString = [NSString stringWithFormat:@"%@confrim/salestatus/salerecord",URL_17_mall_api];
        
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             ICLog_2(@"确认收货返回：%@",responseObject);
             
             NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
             
             if (resultCode == 1000)
             {
                 [HUD showSuccessMessage:@"确认成功"];
                 
                 [self dataWaitReceiveList];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             ICLog_2(@"确认收货错误：%@",error);
         }];
    }];
    
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
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
