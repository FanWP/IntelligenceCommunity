//
//  RightTableViewCell.h
//  CommodityListTableView
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RightTableViewCell;
@protocol RightTableViewCellDelegate <NSObject>

-(void)tableViewCell:(RightTableViewCell *)rightTableViewCell buttonWithTag:(NSInteger)tag;

@end


@interface RightTableViewCell : UITableViewCell

//商品图片
@property(nonatomic,strong) UIImageView *commodityImageView;
//商品名字
@property(nonatomic,strong) UILabel *commodityNameLabel;
//商品价格
@property(nonatomic,strong) UILabel *commodityPriceLabel;

@property(nonatomic,strong) UIImageView *bottomImageView;
//➕
@property(nonatomic,strong) UIButton *addCommodityButton;
//商品数量
@property(nonatomic,strong) UILabel *commodityCountLabel;
//减
@property(nonatomic,strong) UIButton *deleteCommodityButton;

@property(nonatomic,weak) id<RightTableViewCellDelegate>delegate;
@end
