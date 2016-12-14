//
//  PropertyFeeHistoryViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

//物业费缴费记录列表

@interface PropertyFeeHistoryViewCell : UITableViewCell

//缴费时间
@property(nonatomic,strong) UILabel *timeLabel;
//图标
@property(nonatomic,strong) UIImageView *historyImageView;
//钱数
@property(nonatomic,strong) UILabel *priceCountLabel;
//费用类型
@property(nonatomic,strong) UILabel *priceTypeLabel;

@end
