//
//  DeterminePayBottomView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeterminePayBottomView : UIView

//全选
@property(nonatomic,strong) UIButton *selectAllCommodityButton;
@property(nonatomic,strong) UILabel *selectAllLabel;

//总价
@property(nonatomic,strong) UILabel *commodityTotalPriceLabel;
//去结算
@property(nonatomic,strong) UIButton *commitOrderButton;


@end
