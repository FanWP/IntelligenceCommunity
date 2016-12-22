//
//  AddReceiveAddressVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "AddReceiveAddressVC.h"

@interface AddReceiveAddressVC ()

@property (nonatomic,strong) UITextField *nameTextField;// 姓名
@property (nonatomic,strong) UITextField *phoneNumberTF;// 手机号
@property (nonatomic,strong) UILabel *label;// 暂时占位
@property (nonatomic,strong) UITextField *detailAddressTF;// 具体地址

@end

@implementation AddReceiveAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"添加地址";
    
    [self initializeComponent];

    [self rightItemSaveAddress];
}

- (void)rightItemSaveAddress
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAddressAction)];
}
- (void)saveAddressAction
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"userId"] = UserID;
    parameters[@"address"] = _detailAddressTF.text;
    parameters[@"type"] = @"1";
    parameters[@"person"] = _nameTextField.text;
    parameters[@"telephone"] = _phoneNumberTF.text;
    parameters[@"area"] = _label.text;
//    parameters[@"id"] = @"";
    
    ICLog_2(@"添加地址参数:%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@save/update/address",URL_17_mall_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"添加地址返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            [HUD showSuccessMessage:@"添加成功"];
            
            _nameTextField.text = @"";
            _phoneNumberTF.text = @"";
            _label.text = @"";
            _detailAddressTF.text = @"";
        }
        else
        {
            [HUD showErrorMessage:@"添加失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [HUD showErrorMessage:@"添加失败"];
        
        ICLog_2(@"添加地址返回错误：%@",error);
        
    }];
}


- (void)initializeComponent
{
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.layer.cornerRadius = 5.0;
    _nameTextField.font = UIFont13;
    [self.view addSubview:_nameTextField];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(64 + 12);
        make.right.mas_offset(-16);
        make.height.mas_offset(35);
    }];
    
    
    
    _phoneNumberTF = [[UITextField alloc] init];
    _phoneNumberTF.placeholder = @"请输入手机号";
    _phoneNumberTF.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumberTF.layer.cornerRadius = 5.0;
    _phoneNumberTF.font = UIFont13;
    [self.view addSubview:_phoneNumberTF];
    [_phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_nameTextField);
        make.top.equalTo(_nameTextField.mas_bottom).mas_offset(12);
    }];
    
    
    
    _label = [[UILabel alloc] init];
    _label.text = @"陕西省西安市高新区";
    _label.font = UIFont13;
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_nameTextField);
        make.top.equalTo(_phoneNumberTF.mas_bottom).offset(12);
    }];
    
    
    
    _detailAddressTF = [[UITextField alloc] init];
    _detailAddressTF.placeholder = @"具体地址";
    _detailAddressTF.font = UIFont13;
    _detailAddressTF.borderStyle = UITextBorderStyleRoundedRect;
    _detailAddressTF.layer.cornerRadius = 5.0;
    [self.view addSubview:_detailAddressTF];
    [_detailAddressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_nameTextField);
        make.top.equalTo(_label.mas_bottom).offset(12);
        make.height.mas_offset(80);
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
