//
//  NeighborhoodMainCommonTableVC.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//  公共的tableVC邻里圈根据不同的type显示不同的内容

#import <UIKit/UIKit.h>

@interface NeighborhoodMainCommonTableVC : UIViewController

/** 请求网址 */
@property (nonatomic,copy) NSString *neiborhoodURL;

/** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary *parmas;

@end
