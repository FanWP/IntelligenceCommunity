//
//  CommodityDetailViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProListModel;
@class PopTableViewCustom;
@class ShoppingCartView;
@class ShoppingCartBottomView;

//适用于普通商品类:商品、美食、娱乐等
@interface CommodityDetailViewController : UIViewController


@property(nonatomic,strong) ProListModel *model;
//tableView
@property(nonatomic,strong) PopTableViewCustom *popTableView;
//底部菜单
@property(nonatomic,strong) ShoppingCartBottomView *shoppingCartBottomView;
//购物弹出来的视图
@property (strong, nonatomic) ShoppingCartView *shoppingCartView;

//红点
@property(nonatomic,strong) UIImageView *redView;


@end
