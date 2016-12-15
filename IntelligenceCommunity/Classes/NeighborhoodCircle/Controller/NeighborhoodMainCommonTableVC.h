//
//  NeighborhoodMainCommonTableVC.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//  公共的tableVC邻里圈根据不同的type显示不同的内容

#import <UIKit/UIKit.h>

@interface NeighborhoodMainCommonTableVC : UITableViewController


/** 设置邻里圈的单元格的枚举类型--- 邻里 约 生活分享  失物招领 */
@property (nonatomic,assign) NeighborhoodCircleType type;

@end
