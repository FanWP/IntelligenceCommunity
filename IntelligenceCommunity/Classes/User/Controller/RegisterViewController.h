//
//  RegisterViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUButton;

@interface RegisterViewController : UIViewController

//登录或者忘记密码
@property(nonatomic,assign) RegisterOrForgetPassword registerOrForgetPassword;


//手机号
@property(nonatomic,strong,readonly) UITextField *nameTextField;
//验证码
@property(nonatomic,strong,readonly) UITextField *securityCodeTextField;
//发送验证码
@property(nonatomic,strong,readonly) MUButton *sendSecurityCodeButton;
//密码
@property(nonatomic,strong,readonly) UITextField *passwordTextField;
//重复密码
@property(nonatomic,strong,readonly) UITextField *repeatTextField;
//提交注册
@property(nonatomic,strong,readonly) MUButton *registerButton;

@end
