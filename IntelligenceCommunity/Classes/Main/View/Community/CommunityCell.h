//
//  CommunityCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>


//闲置物品主界面cell

@class MaterialsAreadlySaleView;

@interface CommunityCell : UITableViewCell

//用户头像
@property(nonatomic,strong) UIImageView *userImageView;
//用户名
@property(nonatomic,strong) UILabel *userNameLabel;
//发布时间
@property(nonatomic,strong) UILabel *uploadTimeLabel;
//是否支持物物交换
@property(nonatomic,assign) BOOL isSupportBarter;
@property(nonatomic,strong) UIImageView *isSupportBarterImageView;
@property(nonatomic,strong) UILabel *isSupportBarterLabel;

//图片
@property(nonatomic,strong) UIImageView *communityImageView;
@property(nonatomic,strong) MaterialsAreadlySaleView *areadlySaleView;

//价格
@property(nonatomic,strong) UILabel *priceLabel;
//原价
@property(nonatomic,strong) UILabel *oldPriceLabel;
//点赞、数量
@property(nonatomic,strong) UIButton *thumbUpButton;
@property(nonatomic,strong) UILabel *thumbUpCountLabel;
//评论、数量
@property(nonatomic,strong) UIButton *commentsButton;
@property(nonatomic,strong) UILabel *commentCountLabel;

//物品信息
@property(nonatomic,strong) UILabel *communityContentLabel;

@end
