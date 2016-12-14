//
//  CommodityDetailTopViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommodityDetailTopViewCell;

@protocol CommodityDetailTopViewCellDelegate <NSObject>

-(void)commodityDetailTopViewCell:(CommodityDetailTopViewCell *)cell buttonWithTag:(NSInteger)tag;

@end

@interface CommodityDetailTopViewCell : UITableViewCell

//展示图
@property(nonatomic,strong) UIImageView *advertiseImageView;
//名称
@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UILabel *commodityNameLabel;
//价格
@property(nonatomic,strong) UILabel *commodityPriceLabel;

@property(nonatomic,strong) UIImageView *bottomImageView;
//➕
@property(nonatomic,strong) UIButton *addCommodityButton;
//商品数量
@property(nonatomic,strong) UILabel *commodityCountLabel;
//减
@property(nonatomic,strong) UIButton *deleteCommodityButton;

@property(nonatomic,weak) id<CommodityDetailTopViewCellDelegate> delegate;

@end
