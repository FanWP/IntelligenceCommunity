//
//  ChangePWDVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ChangePWDVC.h"

@interface ChangePWDVC ()

@end

@implementation ChangePWDVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self leftItemCancleAndRightItemSave];
    
    [self initializeComponent];
}

- (void)leftItemCancleAndRightItemSave
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancleChangePWD)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveChangedPWD)];
}
- (void)cancleChangePWD
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)saveChangedPWD
{
    
}

- (void)initializeComponent
{
    _changedPWDLabel = [[UILabel alloc] init];
    _changedPWDLabel.text = @"新密码";
    _changedPWDLabel.font = UIFontLarge;
    [self.view addSubview:_changedPWDLabel];
    [_changedPWDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(22 + 64);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
    
    
    _changedPWDTF = [[UITextField alloc] init];
    _changedPWDTF.placeholder = @"请输入新密码";
    _changedPWDTF.font = UIFontNormal;
    _changedPWDTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_changedPWDTF];
    [_changedPWDTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_changedPWDLabel.mas_centerY);
        make.right.offset(-16);
        make.width.mas_offset(250);
        make.height.mas_offset(35);
    }];
    
    _okChangedLabel = [[UILabel alloc] init];
    _okChangedLabel.text = @"确认密码";
    _okChangedLabel.font = UIFontLarge;
    [self.view addSubview:_okChangedLabel];
    [_okChangedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_changedPWDLabel.mas_left);
        make.top.equalTo(_changedPWDLabel.mas_bottom).offset(22);
        make.width.height.equalTo(_changedPWDLabel);
    }];
    
    
    _okChangedTF = [[UITextField alloc] init];
    _okChangedTF.placeholder = @"请输入确认后的密码";
    _okChangedTF.font = UIFontNormal;
    _okChangedTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_okChangedTF];
    [_okChangedTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.height.equalTo(_changedPWDTF);
        make.centerY.equalTo(_okChangedLabel.mas_centerY);
    }];
    
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
