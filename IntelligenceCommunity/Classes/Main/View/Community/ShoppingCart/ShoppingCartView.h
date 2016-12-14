//
//  ShoppingCartBottomView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartViewCell.h"

@class ProListModel;

//购物车商品列表
typedef void(^orderBlock)(NSMutableArray *datasArr,ProListModel *model);

//ShoppingCartViewCellDelegate
@interface ShoppingCartView : UIView<UITableViewDataSource,UITableViewDelegate,ShoppingCartViewCellDelegate>

@property(strong , nonatomic) NSMutableArray *shoppingCartMArray;
@property(strong , nonatomic) UITableView *tableView;
@property(strong , nonatomic) UIViewController *viewController;

@property (strong, nonatomic) orderBlock block;


@property (strong, nonatomic) UILabel *lableText;
// 添加
- (void)addShoppingCartView:(UIViewController *)vc;
//删除
- (void)removeSubView:(UIViewController *)vc;


@end
