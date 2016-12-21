//
//  HouseAuthorityTelNumberVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseAuthorityTelNumberVC.h"

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
    _phoneNumberLabel.text = @"请输入业主手机号";
    _phoneNumberLabel.font = UIFontNormal;
    [self.view addSubview:_phoneNumberLabel];
    [_phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(64 + 15);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
    }];
    
    
    // 输入手机号
    _phoneNumberTF = [[UITextField alloc] init];
    _phoneNumberTF.placeholder = @"请输入手机号码:";
    _phoneNumberTF.font = UIFontSmall;
    _phoneNumberTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_phoneNumberTF];
    [_phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumberLabel.mas_left);
        make.top.equalTo(_phoneNumberLabel.mas_bottom).offset(10);
        make.right.equalTo(_phoneNumberLabel.mas_right);
        make.height.equalTo(_phoneNumberLabel.mas_height);
    }];
    
    
    // 已更换手机号
    _changedPhoneNumButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _changedPhoneNumButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_changedPhoneNumButton setTitle:@"若业主已更换手机号，请点击联系我们" forState:(UIControlStateNormal)];
    [_changedPhoneNumButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [_changedPhoneNumButton.titleLabel setFont:UIFontSmall];
    [self.view addSubview:_changedPhoneNumButton];
    [_changedPhoneNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumberLabel.mas_left);
        make.top.equalTo(_phoneNumberTF.mas_bottom).offset(20);
        make.right.equalTo(_phoneNumberLabel.mas_right);
        make.height.equalTo(_phoneNumberLabel.mas_height);
    }];
    
    
    // 下一步
    _nextStepButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _nextStepButton.backgroundColor = HexColor(0x04c5a1);
    [_nextStepButton setTitle:@"下一步" forState:(UIControlStateNormal)];
    _nextStepButton.layer.cornerRadius = 5.0;
    [_nextStepButton.titleLabel setFont:UIFontNormal];
    [self.view addSubview:_nextStepButton];
    [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(40);
        make.top.equalTo(_changedPhoneNumButton.mas_bottom).offset(40);
        make.right.mas_offset(-40);
        make.height.mas_offset(44);
    }];
    
    // 添加已更换手机号的点击事件
    [_changedPhoneNumButton addTarget:self action:@selector(changedPhoneNumAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 添加下一步的点击事件
    [_nextStepButton addTarget:self action:@selector(nextStepAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

// 已更换手机号的点击事件
- (void)changedPhoneNumAction
{
}

// 下一步的点击事件
- (void)nextStepAction
{
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