//
//  PropertyFeeOtherInfoHeaderView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyFeeOtherInfoHeaderView : UITableViewHeaderFooterView

//缴费账期、应缴金额、缴费账号、户名、住户信息
@property(nonatomic,strong) UILabel *titleLabel;
//对应详情
@property(nonatomic,strong) UILabel *detailLabel;

@end
