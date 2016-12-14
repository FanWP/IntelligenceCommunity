//
//  CommodityInfoViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommodityInfoViewCell;
@protocol CommodityInfoViewCellDelegate <NSObject>

-(void)commodityInfoViewCell:(CommodityInfoViewCell *)commodityInfoViewCell withButton:(UIButton *)button;

@end


@interface CommodityInfoViewCell : UITableViewCell


@property(nonatomic,strong) UIButton *selectButton;
//商品图片
@property(nonatomic,strong) UIImageView *commodityImageView;
//商品名称
@property(nonatomic,strong) UILabel *commodityNameLabel;
//商品价格
@property(nonatomic,strong) UILabel *commodityPriceLabel;
//商品描述
@property(nonatomic,strong) UILabel *commodityDescriptionLabel;
//商品数量
@property(nonatomic,strong) UILabel *commodityCountLabel;

@property(nonatomic,strong) id<CommodityInfoViewCellDelegate> delegate;

@end
