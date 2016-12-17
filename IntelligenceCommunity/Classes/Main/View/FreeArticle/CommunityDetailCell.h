//
//  CommunityDetailCell.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/16.
//  Copyright © 2016年 mumu. All rights reserved.
//  闲置物品详情的单元格

#import <UIKit/UIKit.h>

@class FreeArticleModel;
@interface CommunityDetailCell : UITableViewCell

/** 传入的闲置物品详情的model */
@property (nonatomic,strong) FreeArticleModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
