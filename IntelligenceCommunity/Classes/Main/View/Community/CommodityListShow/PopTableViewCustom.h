//
//  PopTableViewCustom.h
//  DoubleTableView
//
//  Created by apple on 16/12/3.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PopTableViewCustom;

@protocol PopTableViewCustomDelegate <NSObject>

//查看某件商品的详情
-(void)didSelectTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

//更新购物车
typedef void(^orderShopping)(NSArray *datasArray);

@interface PopTableViewCustom : UIView<UITableViewDataSource,UITableViewDelegate>


-(id)initWithFrame:(CGRect)frame leftArray:(NSArray *)leftArray rightArray:(NSArray *)rightArray;

@property(nonatomic,strong) UITableView *leftTableView;

@property(nonatomic,strong) UITableView *rightTableView;

@property(nonatomic,strong) UIViewController *ViewController;

@property(nonatomic,strong) NSMutableArray *leftMArray;

@property(nonatomic,strong) NSArray *rightArray;

//当前点击的cell
@property(nonatomic,assign) NSInteger selectIndex;

//红点
@property(nonatomic,strong) UIImageView *redView;

//记录购物车数据的数组
@property(nonatomic,strong) NSMutableArray *orderMArray;

@property(nonatomic,strong) id<PopTableViewCustomDelegate> delegate;

@end
