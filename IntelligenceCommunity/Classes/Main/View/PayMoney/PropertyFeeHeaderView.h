//
//  PropertyFeeHeaderView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PropertyFeeHeaderView;

@protocol  PropertyFeeHeaderViewDelegate <NSObject>

@optional
-(void)headerView:(PropertyFeeHeaderView*)headerView didSelectAtSection:(NSInteger)section;


@end

//物业费  缴费明细
@interface PropertyFeeHeaderView : UITableViewHeaderFooterView

//标题:缴费明细
@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UILabel *totalTitleLabel;     //@"明细单"

//是否展开分区图标
@property(nonatomic,strong,readonly) UIImageView *arrowImageView;

#pragma mark--分区展开/闭合的相关处理
@property(nonatomic,assign) NSInteger section;
@property(nonatomic,weak) id<PropertyFeeHeaderViewDelegate>delegate;

//分区是否展开
-(void)refreshArrowStatusWithExpand:(BOOL)isExpand;

@end
