//
//  ShoppingCartBottomView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//
#import "ShoppingCartModel.h"

#import "ProListModel.h"

@implementation ShoppingCartModel

/**
 * 计算商品数量
 */
+(NSInteger)getShoppingCartCommodityCount:(NSMutableArray *)orderMArray{
    __block  NSInteger num =0;
    
    [orderMArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ProListModel *model = (ProListModel *)obj;
        
        num = num + [model.orderCount integerValue];
    }];
    return num;
}





/**
 * 计算商品价格
 */
+(double)getShoppingCartCommodityTotalPrice:(NSMutableArray *)orderMArray{
    __block double money = 0;
    
    [orderMArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ProListModel *model = (ProListModel *)obj;
        money = money + [model.orderCount doubleValue] * [model.price doubleValue];
        
    }];
    
    return money;
}

@end
