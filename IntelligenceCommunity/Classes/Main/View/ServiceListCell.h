//
//  ServiceListCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ServiceListCell;

@protocol ServiceListCellDelegate <NSObject>

-(void)serviceListCell:(ServiceListCell *)serviceListCell buttonWithTag:(NSInteger)tag;

@end


@interface ServiceListCell : UITableViewCell

//闲置物品
@property(nonatomic,strong) UIImageView *freeArticleImageView;
@property(nonatomic,strong) UILabel *freeArticleLabel;

//社区服务
@property(nonatomic,strong) UIImageView *communityImageView;
@property(nonatomic,strong) UILabel *communityLabel;

//缴费
@property(nonatomic,strong) UIImageView *payMoneyImageView;
@property(nonatomic,strong) UILabel *payMoneyLabel;

//报修
@property(nonatomic,strong) UIImageView *repairsImageView;
@property(nonatomic,strong) UILabel *repairsLabel;

//地图宣传图
@property(nonatomic,strong) UIImageView *advertiseImageView;
@property(nonatomic,strong) UILabel *advertiseContentLabel;
@property(nonatomic,strong) UILabel *timeLabel;

//协议传递点击状态
@property(nonatomic,strong) id<ServiceListCellDelegate>delegate;

@end
