//
//  CommodityListViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopTableViewCustom;
@class SettlementView;
@class ShoppingCartView;
@class ShoppingCartBottomView;

@interface CommodityListViewController : UIViewController


//tableView
@property(nonatomic,strong) PopTableViewCustom *popTableView;

//底部菜单
@property(nonatomic,strong) ShoppingCartBottomView *shoppingCartBottomView;

//购物弹出来的视图
@property (strong, nonatomic) ShoppingCartView *shoppingCartView;


@end
