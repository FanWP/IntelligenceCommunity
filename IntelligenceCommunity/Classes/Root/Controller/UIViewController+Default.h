//
//  UIViewController+Default.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@interface UIViewController (Default)

/**
 *  设置默认样式
 */
-(void)defaultViewStyle;

@property(nonatomic,strong) NSObject *userInfo;

#pragma mark--确定后取消
-(void)alertControllerWithMessage:(NSString *)message;

#pragma mark--确定后返回上级界面
-(void)alertControllerWithTitle:(NSString *)title Message:(NSString *)message;

@end

