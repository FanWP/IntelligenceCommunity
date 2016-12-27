//
//  FreeArticleViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>


//闲置物品
@interface FreeArticleViewController : UIViewController

/** 请求网址 */
@property (nonatomic,copy) NSString *freeArticleURL;

/** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary *parmas;

@end
