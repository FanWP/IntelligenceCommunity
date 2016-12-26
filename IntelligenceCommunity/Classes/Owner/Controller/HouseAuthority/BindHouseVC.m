//
//  BindHouseVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/20.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "BindHouseVC.h"

#import "HouseMembersTableVC.h"

@interface BindHouseVC ()

@property (nonatomic,strong) UILabel *roomNumberLabel;// 几栋几单元几号房
@property (nonatomic,strong) UILabel *phoneNumberLabel;// 手机号码
@property (nonatomic,strong) UIImageView *phoneNumOkImageView;// 确认手机号正确的图片
@property (nonatomic,strong) UILabel *identifierLabel;// 身份
@property (nonatomic,strong) UIButton *ownerButton;// 业主
@property (nonatomic,strong) UIButton *familyMemberButton;// 家庭成员
@property (nonatomic,strong) UITextField *captchaTF;// 输入验证码
@property (nonatomic,strong) UIButton *captchaButton;// 获取验证码
@property (nonatomic,strong) UIButton *finishButton;// 完成

@end

@implementation BindHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"绑定房屋";

    [self initializeComponent];

}

- (void)dataGetCaptchaBindHouse
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"buildNumber"] = @"1";
    parameters[@"unitNumber"] = @"2";
    parameters[@"roomNumber"] = @"3";
    parameters[@"phoneLast4Bit"] = @"4202";
    parameters[@"sessionId"] = SessionID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@send/bunding/code",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"验证码返回：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        ICLog_2(@"验证码错误：%@",error);
    }];
    
}

- (void)initializeComponent
{
    // 几栋几单元几号房 roomNumberLabel;
    _roomNumberLabel = [[UILabel alloc] init];
    _roomNumberLabel.text = @"一栋一单元";
//    _roomNumberLabel.text = [NSString stringWithFormat:@"%@",]
    _roomNumberLabel.font = UIFontLarge;
    [self.view addSubview:_roomNumberLabel];
    [_roomNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(64 + 21);
        make.right.mas_offset(-16);
        make.height.mas_offset(30);
    }];
    
    // 手机号码 phoneNumberLabel;
    _phoneNumberLabel = [[UILabel alloc] init];
    _phoneNumberLabel.text = @"18789494202";
//    _phoneNumberLabel.text = [NSString stringWithFormat:@"%@",];
    _phoneNumberLabel.font = UIFontLarge;
    [self.view addSubview:_phoneNumberLabel];
    [_phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_roomNumberLabel.mas_left);
        make.top.equalTo(_roomNumberLabel.mas_bottom).offset(38);
        make.width.mas_offset(120);
        make.height.equalTo(_roomNumberLabel.mas_height);
    }];
    
    
    
    // 确认手机号正确的图片 phoneNumOkImageView
    _phoneNumOkImageView = [[UIImageView alloc] init];
    _phoneNumOkImageView.image = [UIImage imageNamed:@"Binding_03"];
    [self.view addSubview:_phoneNumOkImageView];
    [_phoneNumOkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumberLabel.mas_right).offset(9);
        make.centerY.equalTo(_phoneNumberLabel.mas_centerY);
        make.width.height.offset(18.5);
    }];
    
    
    
    // 身份 identifierLabel;
    _identifierLabel = [[UILabel alloc] init];
    _identifierLabel.text = @"我是该屋的:";
    _identifierLabel.font = UIFontLarge;
    [self.view addSubview:_identifierLabel];
    [_identifierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_roomNumberLabel.mas_left);
        make.top.equalTo(_phoneNumberLabel.mas_bottom).offset(38);
        make.width.mas_offset(105);
        make.height.equalTo(_roomNumberLabel.mas_height);
    }];
    
    
    
    // 业主 ownerButton;
    _ownerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_ownerButton setTitle:@"业主" forState:(UIControlStateNormal)];
    [_ownerButton.titleLabel setFont:UIFontNormal];
    [_ownerButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_ownerButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [_ownerButton setBackgroundImage:[UIImage imageNamed:@"owner_normal"] forState:(UIControlStateNormal)];
    [_ownerButton setBackgroundImage:[UIImage imageNamed:@"owner_selected"] forState:(UIControlStateSelected)];
    [self.view addSubview:_ownerButton];
    [_ownerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_identifierLabel.mas_right).offset(8);
        make.centerY.equalTo(_identifierLabel.mas_centerY);
        make.width.mas_offset(94);
        make.height.mas_offset(33);
    }];
    
    
    // 家庭成员 familyMemberButton;
    _familyMemberButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_familyMemberButton setTitle:@"家庭成员" forState:(UIControlStateNormal)];
    [_familyMemberButton.titleLabel setFont:UIFontNormal];
    [_familyMemberButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_familyMemberButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [_familyMemberButton setBackgroundImage:[UIImage imageNamed:@"familyMember_normal"] forState:(UIControlStateNormal)];
    [_familyMemberButton setBackgroundImage:[UIImage imageNamed:@"familyMember_selected"] forState:(UIControlStateSelected)];
    [self.view addSubview:_familyMemberButton];
    [_familyMemberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ownerButton.mas_right);
        make.centerY.equalTo(_ownerButton.mas_centerY);
        make.width.height.equalTo(_ownerButton);
    }];
    
    
    
    // 输入验证码 captchaTF;
    _captchaTF = [[UITextField alloc] init];
    _captchaTF.placeholder = @"请输入收到的验证码";
    _captchaTF.font = UIFont13;
    _captchaTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_captchaTF];
    [_captchaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_roomNumberLabel.mas_left);
        make.top.equalTo(_identifierLabel.mas_bottom).offset(38);
        make.width.mas_offset(190);
        make.height.mas_offset(36);
    }];
    
    
    
    // 获取验证码 captchaButton;
    _captchaButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _captchaButton.backgroundColor = HexColor(0x04c5a1);
    [_captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [_captchaButton.titleLabel setFont:UIFont13];
    _captchaButton.layer.cornerRadius = 5.0;
    [self.view addSubview:_captchaButton];
    [_captchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_captchaTF.mas_right).offset(12);
        make.top.equalTo(_captchaTF.mas_top);
        make.width.mas_offset(111.5);
        make.height.equalTo(_captchaTF.mas_height);
    }];
    
    
    
    // 完成 finishButton;
    _finishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _finishButton.backgroundColor = HexColor(0x04c5a1);
    [_finishButton setTitle:@"完成" forState:(UIControlStateNormal)];
    [_finishButton.titleLabel setFont:UIFontLarge];
    _finishButton.layer.cornerRadius = 5.0;
    [self.view addSubview:_finishButton];
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.right.mas_offset(-16);
        make.bottom.mas_offset(-79);
        make.height.mas_offset(49);
    }];
    
    
    [_ownerButton addTarget:self action:@selector(ownerAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_familyMemberButton addTarget:self action:@selector(familyMemberActon:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_captchaButton addTarget:self action:@selector(getCaptchaAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_finishButton addTarget:self action:@selector(finishBindHouseAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)getCaptchaAction
{
    [self dataGetCaptchaBindHouse];
}

- (void)finishBindHouseAction
{
//    check/bunding/code
    
    HouseMembersTableVC *houseMembersTableVC = [[HouseMembersTableVC alloc] init];
    [self.navigationController pushViewController:houseMembersTableVC animated:YES];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"buildNumber"] = @"";
    parameters[@"unitNumber"] = @"";
    parameters[@"roomNumber"] = @"";
    parameters[@"checkCode"] = _captchaTF.text;
    parameters[@"sessionId"] = SessionID;
    parameters[@"userId"] = UserID;
    
    ICLog_2(@"绑定房屋参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@check/bunding/code",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"绑定房屋返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            [HUD showSuccessMessage:@"绑定成功"];
        }
        else
        {
            [HUD showErrorMessage:@"绑定失败"];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [HUD showErrorMessage:@"绑定失败"];
        ICLog_2(@"绑定房屋错误：%@",error);
    }];
}

- (void)ownerAction:(UIButton *)button
{
    button.selected = !button.selected;
    
}

- (void)familyMemberActon:(UIButton *)button
{
    button.selected = !button.selected;
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
