//
//  CommodityListHeaderView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

//列表头视图
@interface CommodityListHeaderView : UIView

//背景高斯模糊图片
@property(nonatomic,strong) UIImageView *bottomImageView;
//店铺展示图片
@property(nonatomic,strong) UIImageView *storeAdvertiseImageView;
//店铺名称
@property(nonatomic,strong) UILabel *storeNameLabel;
//店铺签名
@property(nonatomic,strong) UILabel *storeRemarkLabel;
//营业时间
@property(nonatomic,strong) UILabel *storeWorkTimeLabel;


@end
