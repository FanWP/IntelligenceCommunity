//
//  OrderDetailTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 17/1/3.
//  Copyright © 2017年 mumu. All rights reserved.
//

#import "OrderDetailTableVC.h"

#import "MyOrdersProductsCell.h"
#import "OrderDetailAddressCell.h"

@interface OrderDetailTableVC ()

@end

@implementation OrderDetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 74;
    }
    else if (indexPath.section == 1)
    {
        return 110;
    }
    else
    {
        return 74;
    }
}

- (OrderDetailAddressCell *)tableView:(UITableView *)tableView addressCellWithIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    OrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[OrderDetailAddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    cell.receiverLabel.text = @"收货人：蓓蓓";
    cell.phoneNumLabel.text = @"18789897876";
    cell.addressLabel.text = @"陕西省西安市雁塔区科技三路";

    return cell;
}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [self tableView:tableView addressCellWithIndexPath:indexPath];
    }
    else if (indexPath.section == 1)
    {
        return [self tableView:tableView productsCellWithIndexPath:indexPath];
    }
    else
    {
        return [self tableView:tableView addressCellWithIndexPath:indexPath];
    }
}



@end
