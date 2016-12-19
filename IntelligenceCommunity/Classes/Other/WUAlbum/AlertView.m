//
//  AlertView.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "AlertView.h"

@interface AlertView ()

/** 当前界面的控制器 */
@property (nonatomic,strong) UIViewController *rootVC;


@property (nonatomic,strong) UIAlertController *alert;

@end

@implementation AlertView

+ (AlertView *)sharedManager
{
    static AlertView *handle = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        handle = [[AlertView alloc] init];
        
    });
    
    return handle;
}


- (UIViewController *)rootVC
{
    if (!_rootVC)
    {
        _rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _rootVC;
}


-(void)addAlertMessage:(NSString *)message title:(NSString *)title
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self.alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }]];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:^ {  }];
}



/**
 *  提示框延迟几秒消失
 *
 *  @param message 提示内容
 *  @param title   标题
 */
- (void)addAfterAlertMessage:(NSString *)message title:(NSString *)title
{
    
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self.rootVC presentViewController:self.alert animated:YES completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}


/**
 *  确定的提示框
 *
 *  @param message      提示的内容
 *  @param title        标题
 *  @param okAction     确定事件(事件在外部自定义)
 */
- (void)addAlertMessage:(NSString *)message title:(NSString *)title okAction:(UIAlertAction *)okAction
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}



- (void)addAlertMessage:(NSString *)message title:(NSString *)title cancleAction:(UIAlertAction *)cancleAction okAction:(UIAlertAction *)okAction
{
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self.alert addAction:cancleAction];
    [self.alert addAction:okAction];
    [self.rootVC presentViewController:self.alert animated:YES completion:nil];
}


@end
