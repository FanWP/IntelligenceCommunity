//
//  AddReceiveAddressVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "AddReceiveAddressVC.h"

#import "AddressPickView.h"

@interface AddReceiveAddressVC ()

@property (nonatomic,strong) UITextField *nameTextField;// 姓名
@property (nonatomic,strong) UITextField *phoneNumberTF;// 手机号
@property (nonatomic,strong) UILabel *areaLabel;// 地区
@property (nonatomic,strong) YYPlaceholderTextView *detailAddressTextView;// 具体地址

@end

@implementation AddReceiveAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    parameters[@"address"] = _detailAddressTextView.text;
    parameters[@"type"] = @"1";
    parameters[@"person"] = _nameTextField.text;
    parameters[@"telephone"] = _phoneNumberTF.text;
    parameters[@"area"] = _areaLabel.text;
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
             _areaLabel.text = @"";
             _detailAddressTextView.text = @"";
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
    
    
    
    _areaLabel = [[UILabel alloc] init];
    _areaLabel.text = @"请选择地区";
    _areaLabel.tag = 150;
    _areaLabel.font = UIFont13;
    _areaLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAddressPickView)];
    [_areaLabel addGestureRecognizer:tap];
    [self.view addSubview:_areaLabel];
    [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_nameTextField);
        make.top.equalTo(_phoneNumberTF.mas_bottom).offset(12);
    }];
    
    
    
    _detailAddressTextView = [[YYPlaceholderTextView alloc] init];
    _detailAddressTextView.placeholder = @"具体地址";
    _detailAddressTextView.font = UIFont13;
    _detailAddressTextView.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    _detailAddressTextView.layer.borderWidth = 1.0;
    _detailAddressTextView.layer.cornerRadius = 5.0;
    [self.view addSubview:_detailAddressTextView];
    [_detailAddressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_nameTextField);
        make.top.equalTo(_areaLabel.mas_bottom).offset(12);
        make.height.mas_offset(80);
    }];
}

- (void)showAddressPickView
{
    [self.view endEditing:YES];
    
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town)
    {
        _areaLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town];
    };
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
