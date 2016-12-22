//
//  NeiborhoodHeaderView.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeighborhoodModel;
@interface NeiborhoodHeaderView : UITableViewHeaderFooterView

/** 传入的模型 */
@property (nonatomic,strong) NeighborhoodModel *neiborhoodModel;

+(instancetype)headerWithTableView:(UITableView *)tableView;


@end
