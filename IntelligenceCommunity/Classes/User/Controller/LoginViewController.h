//
//  LoginViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUButton;
@interface LoginViewController : UIViewController

@property(nonatomic,strong,readonly) UITextField *nameTextField;
@property(nonatomic,strong,readonly) UITextField *passwordTextField;
@property(nonatomic,strong,readonly) MUButton *loginButton;

//注册
@property(nonatomic,strong,readonly) UIButton *registerButton;
//忘记密码
@property(nonatomic,strong,readonly) UIButton *forgetPasswordButton;


@end
