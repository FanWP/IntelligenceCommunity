//
//  WaitPaymentTableVC.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/27.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

// 待付款
@interface WaitPaymentTableVC : UITableViewController

@property (nonatomic,assign) MyOrdersType waitPaymentType;

@property (nonatomic,copy) NSString *saleid;// 订单id号

@end
