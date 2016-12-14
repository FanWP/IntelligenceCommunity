//
//  ShoppingCartViewCell.h
//  CommodityListTableView
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCartViewCell;
@protocol ShoppingCartViewCellDelegate <NSObject>

-(void)shoppingCartViewCell:(ShoppingCartViewCell *)shoppingCartViewCell buttonWithTag:(NSInteger)tag;

@end

@interface ShoppingCartViewCell : UITableViewCell

//商品名字
@property(nonatomic,strong) UILabel *commodityNameLabel;
//商品价格
@property(nonatomic,strong) UILabel *commodityPriceLabel;
//商品单位:  /件   /个
@property(nonatomic,strong) UILabel *commodityTypeLabel;

@property(nonatomic,strong) UIImageView *bottomImageView;
//➕
@property(nonatomic,strong) UIButton *addCommodityButton;
//商品数量
@property(nonatomic,strong) UILabel *commodityCountLabel;
//减
@property(nonatomic,strong) UIButton *deleteCommodityButton;

@property(nonatomic,weak) id<ShoppingCartViewCellDelegate> delegate;

@end
