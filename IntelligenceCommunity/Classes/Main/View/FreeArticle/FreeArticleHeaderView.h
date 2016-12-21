//
//  FreeArticleHeaderView.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//  闲置物品的用户发布的headerView

#import <UIKit/UIKit.h>


@class FreeArticleModel;
@interface FreeArticleHeaderView : UIView



/** 传入的模型 */
@property (nonatomic,strong) FreeArticleModel *freeArticleModel;

/** 传入导航控制器 */
@property (nonatomic,strong) UINavigationController *nav;

@property(nonatomic,strong) UIButton *commentsButton;

@end
