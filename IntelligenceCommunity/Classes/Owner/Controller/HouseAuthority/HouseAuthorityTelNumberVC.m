//
//  HouseAuthorityTelNumberVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseAuthorityTelNumberVC.h"

#import "BindHouseVC.h"// 绑定房屋

@interface HouseAuthorityTelNumberVC ()

@property (nonatomic,strong) UILabel *phoneNumberLabel;// 手机号
@property (nonatomic,strong) UITextField *phoneNumberTF;// 输入手机号
@property (nonatomic,strong) UIButton *changedPhoneNumButton;// 已更换手机号
@property (nonatomic,strong) UIButton *nextStepButton;// 下一步
@end

@implementation HouseAuthorityTelNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加房屋";
    
    [self initializeComponent];
}

- (void)initializeComponent
{
    // 请输入业主手机号
    _phoneNumberLabel = [[UILabel alloc] init];
    _phoneNumberLabel.text = @"请输入业主手机号后4位：";
    _phoneNumberLabel.font = UIFont15;
    [self.view addSubview:_phoneNumberLabel];
    [_phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.top.mas_offset(64 + 41);
        make.right.mas_offset(-35);
        make.height.mas_offset(30);
    }];
    
    
    // 输入手机号
    _phoneNumberTF = [[UITextField alloc] init];
    _phoneNumberTF.placeholder = @"请输入手机号后4位";
    _phoneNumberTF.font = UIFontSmall;
    _phoneNumberTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_phoneNumberTF];
    [_phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumberLabel.mas_left);
        make.top.equalTo(_phoneNumberLabel.mas_bottom).offset(16);
        make.right.equalTo(_phoneNumberLabel.mas_right);
        make.height.mas_offset(35);
    }];
    
    
    // 已更换手机号
    _changedPhoneNumButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _changedPhoneNumButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_changedPhoneNumButton setTitle:@"若业主已更换手机号，请点击联系我们" forState:(UIControlStateNormal)];
    [_changedPhoneNumButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [_changedPhoneNumButton.titleLabel setFont:UIFont13];
    [self.view addSubview:_changedPhoneNumButton];
    [_changedPhoneNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumberLabel.mas_left);
        make.top.equalTo(_phoneNumberTF.mas_bottom).offset(42);
        make.right.equalTo(_phoneNumberLabel.mas_right);
        make.height.equalTo(_phoneNumberLabel.mas_height);
    }];
    
    
    // 下一步
    _nextStepButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _nextStepButton.backgroundColor = HexColor(0x04c5a1);
    [_nextStepButton setTitle:@"下一步" forState:(UIControlStateNormal)];
    _nextStepButton.layer.cornerRadius = 5.0;
    [_nextStepButton.titleLabel setFont:UIFontLarge];
    [self.view addSubview:_nextStepButton];
    [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-44 + 21);
        make.height.mas_offset(49);
    }];
    
    // 添加已更换手机号的点击事件
    [_changedPhoneNumButton addTarget:self action:@selector(changedPhoneNumAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 添加下一步的点击事件
    [_nextStepButton addTarget:self action:@selector(nextStepAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

// 已更换手机号的点击事件
- (void)changedPhoneNumAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否拨打18092456642？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18092456642"]];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

// 下一步的点击事件
- (void)nextStepAction
{
    BindHouseVC *bindHouseVC = [[BindHouseVC alloc] init];
    [self.navigationController pushViewController:bindHouseVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
