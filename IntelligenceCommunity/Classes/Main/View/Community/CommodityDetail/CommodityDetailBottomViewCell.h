//
//  CommodityDetailBottomViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityDetailBottomViewCell : UITableViewCell


//商品简介
@property(nonatomic,strong) UILabel *titleLabel;
//图片
@property(nonatomic,strong) UIImageView *advertiseImageView;
//商品详情
@property(nonatomic,strong) UILabel *commodityDetailLabel;


@end
