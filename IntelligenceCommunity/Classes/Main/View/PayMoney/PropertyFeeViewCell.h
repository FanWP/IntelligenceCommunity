//
//  PropertyFeeViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

//缴费明细
@interface PropertyFeeViewCell : UITableViewCell

//费用名称
@property(nonatomic,strong) UILabel *propertyFeeTitleLabel;

//钱数
@property(nonatomic,strong) UILabel *feeMoneyCountLabel;

@end
