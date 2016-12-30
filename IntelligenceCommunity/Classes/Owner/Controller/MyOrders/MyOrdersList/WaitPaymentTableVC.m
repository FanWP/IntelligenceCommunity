//
//  WaitPaymentTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/27.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "WaitPaymentTableVC.h"

#import "AppraiseVC.h"

#import "MyOrdersStoreTitleCell.h"
#import "MyOrdersProductsCell.h"
#import "MyOrdersDealCell.h"

@interface WaitPaymentTableVC ()

@end

@implementation WaitPaymentTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.backgroundColor = [UIColor redColor];
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
    AppraiseVC *appraiseVC = [[AppraiseVC alloc] init];
    [self.navigationController pushViewController:appraiseVC animated:YES];
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
