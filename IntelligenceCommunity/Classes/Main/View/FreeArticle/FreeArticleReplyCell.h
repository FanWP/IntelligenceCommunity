//
//  FreeArticleReplyCell.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//  闲置物品评论及回复

#import <UIKit/UIKit.h>


@class FreeArticleReplyModel;
@interface FreeArticleReplyCell : UITableViewCell

/** 接受到的评论数组 */
@property (nonatomic,strong) FreeArticleReplyModel *replyModel;


/** 快速创建cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
