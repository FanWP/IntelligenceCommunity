//
//  ShoppingCartBottomView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//
#import <Foundation/Foundation.h>

//购物车数据计算
@interface ShoppingCartModel : NSObject

/**
 *计算商品数量
 */
+(NSInteger)getShoppingCartCommodityCount:(NSMutableArray *)orderMArray;
/**
 * 计算商品价格
 */
+(double)getShoppingCartCommodityTotalPrice:(NSMutableArray *)orderMArray;
@end
