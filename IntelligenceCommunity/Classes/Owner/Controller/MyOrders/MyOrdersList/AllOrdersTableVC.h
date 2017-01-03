//
//  AllOrdersTableVC.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/27.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

// 全部订单
@interface AllOrdersTableVC : UITableViewController

@property (nonatomic,assign) MyOrdersType allOrderType;

@property (nonatomic,copy) NSString *saleid;// 订单id号

@end
