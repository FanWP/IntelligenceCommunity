//
//  UIViewController+Default.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "UIViewController+Default.h"

static BOOL canSetBackButtonTitle;

@implementation UIViewController (Default)

+(void)load {
    canSetBackButtonTitle = [self isVariableWithClass:[UINavigationItem class] varName:@"backButtonTitle"];
}

-(void)defaultViewStyle {
    self.view.backgroundColor = ThemeBackgroundColor;
    self.navigationController.navigationBar.translucent = NO;
    if(canSetBackButtonTitle) {
        if(self.tabBarController == nil) {
            [self.navigationItem setValue:@"" forKey:@"backButtonTitle"];
            
        } else {
            [self.tabBarController.navigationItem setValue:@"" forKey:@"backButtonTitle"];
        }
    }
    
}

+ (BOOL) isVariableWithClass:(Class) myClass varName:(NSString *)name{	unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

static char const userInfoKey = '\0';

-(void)setUserInfo:(NSObject*)userInfo {
    objc_setAssociatedObject(self, &userInfoKey, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject*)userInfo {
    return objc_getAssociatedObject(self, &userInfoKey);
}
#pragma mark--确定后取消
-(void)alertControllerWithMessage:(NSString *)message{
    
    if (!message.length) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"友情提示:" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}
#pragma mark--确定后返回上级界面
-(void)alertControllerWithTitle:(NSString *)title Message:(NSString *)message{
    
    if (!message.length) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end

