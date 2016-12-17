//
//  FreeArticleDetailTableVC.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/16.
//  Copyright © 2016年 mumu. All rights reserved.
//  闲置物品详情

#import <UIKit/UIKit.h>



@class FreeArticleModel;
@interface FreeArticleDetailTableVC : UIViewController

/** 传入的闲置物品详情 */
@property (nonatomic,strong) FreeArticleModel *model;

@end
