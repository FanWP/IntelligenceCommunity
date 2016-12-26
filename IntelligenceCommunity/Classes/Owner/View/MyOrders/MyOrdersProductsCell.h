//
//  MyOrdersProductsCell.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/26.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrdersProductsCell : UITableViewCell

@property (nonatomic,strong) UIImageView *productImageView;// 商品图片
@property (nonatomic,strong) UILabel *titleLabel;// 标题
@property (nonatomic,strong) UILabel *detailLabel;// 详情
@property (nonatomic,strong) UILabel *priceLabel;// 价格
@property (nonatomic,strong) UILabel *countLabel;// 数量

@end
