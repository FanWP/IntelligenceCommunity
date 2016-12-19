//
//  AlertView.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertView : NSObject

+ (AlertView *)sharedManager;


/**
 *  @param message 提示信息
 *  @param title   标题
 */
- (void)addAlertMessage:(NSString *)message title:(NSString *)title;




/**
 *  提示框延迟几秒消失
 *
 *  @param message 提示内容
 *  @param title   标题
 */
- (void)addAfterAlertMessage:(NSString *)message title:(NSString *)title;

- (void)addAlertMessage:(NSString *)message title:(NSString *)title okAction:(UIAlertAction *)okAction;


- (void)addAlertMessage:(NSString *)message title:(NSString *)title cancleAction:(UIAlertAction *)cancleAction okAction:(UIAlertAction *)okAction;

@end
