//
//  ShoppingCartBottomView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

//购物车栏
@interface ShoppingCartBottomView : UIView

//购物车按钮
@property(nonatomic,strong) UIButton *shoppingCartButton;
//商品数量
@property(nonatomic,strong) UILabel *commodityCountLabel;
//总价
@property(nonatomic,strong) UILabel *commodityTotalPriceLabel;
//去结算
@property(nonatomic,strong) UIButton *goSettlementButton;

@end
