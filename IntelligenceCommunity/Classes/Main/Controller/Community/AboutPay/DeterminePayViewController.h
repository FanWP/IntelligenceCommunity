//
//  DeterminePayViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeterminePayBottomView;

//确认支付界面
@interface DeterminePayViewController : UIViewController

@property(nonatomic,strong) DeterminePayBottomView *bottomView;
//记录购物车数据的数组
@property(nonatomic,strong) NSMutableArray *orderMArray;


@end
