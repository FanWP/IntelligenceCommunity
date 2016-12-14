//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^keywordSearchBlock)(NSString *keywordString);

//房源搜索界面
@interface SearchViewController : UIViewController

//关键字筛选
@property(nonatomic,copy) keywordSearchBlock searchBlock;

@end
