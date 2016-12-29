//
//  RegisterViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RegisterViewController.h"
#import "MUButton.h"

NSString *const REGISTER_CODE_SEND_TIME_KEY = @"REGISTER_CODE_SEND_TIME_KEY";


@interface RegisterViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) NSTimeInterval maxTime;
@property(nonatomic,assign) NSTimeInterval currentTime;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    
    if (_registerOrForgetPassword == RegisterAccount) {
        self.navigationItem.title = @"注册";
    }else if (_registerOrForgetPassword == ForgetPassword){
        self.navigationItem.title = @"忘记密码";
    }
    
    
    [self initializeComponent];
}

-(void)initializeComponent {
    
    _maxTime = 60;

    
    //手机号
    UIImageView *nameLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    nameLeftView.contentMode = UIViewContentModeCenter;
    nameLeftView.image = [UIImage imageNamed:@"phone number"];
    
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.placeholder = @"请输入用户名";
    _nameTextField.textColor = HexColor(0x3d3c3c);
    _nameTextField.returnKeyType = UIReturnKeyNext;
    _nameTextField.delegate = self;
    _nameTextField.leftView = nameLeftView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    _nameTextField.tintColor = ThemeColor;
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.layer.cornerRadius = 5;
    _nameTextField.layer.masksToBounds = YES;
    _nameTextField.layer.borderWidth = 1;
    _nameTextField.layer.borderColor = HexColor(0xcccccc).CGColor;
    [self.view addSubview:_nameTextField];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kGetVerticalDistance(50));
        make.left.mas_equalTo(kGetHorizontalDistance(40));
        make.right.mas_equalTo(-kGetHorizontalDistance(40));
        make.height.mas_equalTo(kGetVerticalDistance(80));
    }];
    //验证码
//    @property(nonatomic,strong,readonly) UITextField *securityCodeTextField;
    UIImageView *securityCodeLeftView = [[UIImageView alloc] initWithFrame:nameLeftView.bounds];
    securityCodeLeftView.contentMode = UIViewContentModeCenter;
    securityCodeLeftView.image = [UIImage imageNamed:@"security code"];
    
    _securityCodeTextField = [[UITextField alloc] init];
    _securityCodeTextField.placeholder = @"请输入验证码";
    _securityCodeTextField.textColor = HexColor(0x3d3c3c);
    _securityCodeTextField.returnKeyType = UIReturnKeyNext;
    _securityCodeTextField.delegate = self;
    _securityCodeTextField.leftView = securityCodeLeftView;
    _securityCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    _securityCodeTextField.tintColor = ThemeColor;
    _securityCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _securityCodeTextField.layer.cornerRadius = 5;
    _securityCodeTextField.layer.masksToBounds = YES;
    _securityCodeTextField.layer.borderWidth = 1;
    _securityCodeTextField.layer.borderColor = HexColor(0xcccccc).CGColor;
    [self.view addSubview:_securityCodeTextField];
    [_securityCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTextField.mas_bottom).offset(kGetVerticalDistance(40));
        make.left.equalTo(_nameTextField.mas_left).offset(0);
        make.width.mas_offset(kGetHorizontalDistance(406));
        make.height.mas_equalTo(_nameTextField);
    }];
//    //发送验证码
//    @property(nonatomic,strong,readonly) MUButton *sendSecurityCodeButton;
    _sendSecurityCodeButton = [[MUButton alloc] init];
    _sendSecurityCodeButton.layer.cornerRadius = 5;
    _sendSecurityCodeButton.layer.masksToBounds = YES;
    _sendSecurityCodeButton.enabled = NO;
    _sendSecurityCodeButton.titleLabel.font = UIFontSmall;
    [_sendSecurityCodeButton setBackgroundImage:[Common imageWithFrame:_sendSecurityCodeButton.bounds color:HexColor(0x05c4a2)] forState:UIControlStateNormal];
    [_sendSecurityCodeButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [_sendSecurityCodeButton setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
    [_sendSecurityCodeButton addTarget:self action:@selector(sendSecurityCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendSecurityCodeButton];
    [_sendSecurityCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_securityCodeTextField.mas_centerY);
        make.left.equalTo(_securityCodeTextField.mas_right).offset(kGetHorizontalDistance(24));
        make.right.mas_offset(-kGetHorizontalDistance(40));
        make.height.mas_equalTo(_securityCodeTextField);
    }];
    
//    //密码
//    @property(nonatomic,strong,readonly) UITextField *passwordTextField;
    UIImageView *passwordLeftView = [[UIImageView alloc] initWithFrame:nameLeftView.bounds];
    passwordLeftView.contentMode = UIViewContentModeCenter;
    passwordLeftView.image = [UIImage imageNamed:@"password"];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.textColor = HexColor(0x3d3c3c);
    _passwordTextField.returnKeyType = UIReturnKeyNext;
    _passwordTextField.delegate = self;
    _passwordTextField.leftView = passwordLeftView;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.tintColor = ThemeColor;
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.layer.borderWidth = 1;
    _passwordTextField.layer.borderColor = HexColor(0xcccccc).CGColor;
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_securityCodeTextField.mas_bottom).offset(kGetVerticalDistance(40));
        make.left.right.height.mas_equalTo(_nameTextField);
    }];
//    //重复密码
//    @property(nonatomic,strong,readonly) UITextField *repeatTextField;
    UIImageView *repeatPasswordLeftView = [[UIImageView alloc] initWithFrame:nameLeftView.bounds];
    repeatPasswordLeftView.contentMode = UIViewContentModeCenter;
    repeatPasswordLeftView.image = [UIImage imageNamed:@"password"];
    
    _repeatTextField = [[UITextField alloc] init];
    _repeatTextField.placeholder = @"请再次输入密码";
    _repeatTextField.textColor = HexColor(0x3d3c3c);
    _repeatTextField.returnKeyType = UIReturnKeyNext;
    _repeatTextField.delegate = self;
    _repeatTextField.leftView = repeatPasswordLeftView;
    _repeatTextField.leftViewMode = UITextFieldViewModeAlways;
    _repeatTextField.tintColor = ThemeColor;
    _repeatTextField.borderStyle = UITextBorderStyleRoundedRect;
    _repeatTextField.layer.cornerRadius = 5;
    _repeatTextField.layer.masksToBounds = YES;
    _repeatTextField.layer.borderWidth = 1;
    _repeatTextField.layer.borderColor = HexColor(0xcccccc).CGColor;
    [self.view addSubview:_repeatTextField];
    [_repeatTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.mas_bottom).offset(kGetVerticalDistance(40));
        make.left.right.height.mas_equalTo(_nameTextField);
    }];
    
    //提交注册
//    @property(nonatomic,strong,readonly) UIButton *registerButton;
    _registerButton = [[MUButton alloc] init];
    _registerButton.layer.cornerRadius = 5;
    _registerButton.layer.masksToBounds = YES;
    _registerButton.enabled = NO;
    _registerButton.titleLabel.font = UIFontLarge;
    [_registerButton setBackgroundImage:[Common imageWithFrame:_registerButton.bounds color:HexColor(0x05c4a2)] forState:UIControlStateNormal];
    if (_registerOrForgetPassword == RegisterAccount) {
        
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }else if (_registerOrForgetPassword == ForgetPassword){
        [_registerButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    [_registerButton setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_repeatTextField.mas_bottom).offset(kGetVerticalDistance(100));
        make.left.right.height.mas_equalTo(_nameTextField);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *dateValue = [userDefaults objectForKey:REGISTER_CODE_SEND_TIME_KEY];
    if(dateValue && ![dateValue isEqual:[NSNull null]]) {
        NSTimeInterval date = [dateValue integerValue];
        NSTimeInterval tis = [[NSDate date] timeIntervalSince1970];
        if(tis - date < _maxTime) {
            _currentTime = tis - date;
            [self runTimer];
        }
    }
    
}
#pragma mark--发送验证码
-(void)sendSecurityCodeButtonAction:(UIButton *)button{
    
    ICLog_2(@"发送验证码");
    
    //获取验证码并发送成功，记录发送时间
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *date = [NSDate date];
    NSTimeInterval currentDate = [date timeIntervalSince1970];
    [userDefaults setObject:@(currentDate) forKey:REGISTER_CODE_SEND_TIME_KEY];
    [userDefaults synchronize];
    [self runTimer];
    
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [parametersDic setValue:@"18220868151" forKey:@"userPhone"];
    
    [[RequestManager manager] SessionRequestWithType:Smart_community requestWithURLString:@"unlogin/send/check/code" requestType:RequestMethodPost requestParameters:parametersDic success:^(id  _Nullable responseObject) {
        
        ICLog_2(@"%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([responseObject[@"resultCode"] integerValue] == 1000) {
                [self alertControllerWithMessage:@"发送验证码成功"];
            }else{
                [self alertControllerWithMessage:@"发送验证码失败,请检查手机号是否正确"];
            }
        });
        
    } faile:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark--注册/忘记密码
-(void)registerButtonAction:(UIButton *)button{
    
    _registerButton.enabled = NO;
    [_registerButton startAnimation];
    if (_registerOrForgetPassword == RegisterAccount) {
        ICLog_2(@"注册");
        
        [self getPublicKey];
        
    }else if (_registerOrForgetPassword == ForgetPassword){
        ICLog_2(@"忘记密码");
        
    }
}
#pragma mark--获取公钥
-(void)getPublicKey{
    
    //获取公钥
    [[RequestManager manager] JSONRequestWithType:Smart_community urlString:@"unlogin/sendpubkeyservlet" method:RequestMethodPost timeout:20 parameters:nil success:^(id  _Nullable responseObject) {
        
        
        if ([responseObject[@"resultCode"] integerValue] == 1000) {
            
            [self registerAccountWithPublicyKey:responseObject[@"pubKey"]];
        }else{
            [self alertControllerWithMessage:@"获取公钥失败"];
        }
    } faile:^(NSError * _Nullable error) {
        ICLog_2(@"%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.registerButton.enabled = YES;
            [self.registerButton stopAnimation];
        });
    }];
    
}
#pragma mark--注册
-(void)registerAccountWithPublicyKey:(NSString *)pubkey{
    
    NSString *passwordString = _passwordTextField.text;
    NSString *finishRSAString = [RSAEncryptor encryptString:passwordString publicKey:pubkey];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [parametersDic setValue:_nameTextField.text forKey:@"userPhone"];
    [parametersDic setValue:finishRSAString forKey:@"passWord"];
    [parametersDic setValue:_securityCodeTextField.text forKey:@"checkCode"];
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@smart_community/unlogin/register",Smart_community_URL];

    [[AFHTTPSessionManager manager] POST:serviceURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ICLog_2(@"%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            _registerButton.enabled = YES;
            [_registerButton stopAnimation];
            if ([responseObject[@"resultCode"] integerValue] == 1000) {
                [self alertControllerWithMessage:@"注册成功!"];
            }else{
                [self alertControllerWithMessage:@"注册失败,当前服务器繁忙!"];
            }
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ICLog_2(@"%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            _registerButton.enabled = YES;
            [_registerButton stopAnimation];
        });
        
    }];
    
    return;
    
//    [[RequestManager manager] SessionRequestWithType:Smart_community requestWithURLString:@"unlogin/register" requestType:RequestMethodPost requestParameters:parametersDic success:^(id  _Nullable responseObject) {
//        
//        ICLog_2(@"%@",responseObject);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if ([responseObject[@"resultCode"] integerValue] == 1000) {
//                [self alertControllerWithMessage:@"注册成功!"];
//            }else{
//                [self alertControllerWithMessage:@"注册失败,当前服务器繁忙!"];
//            }
//        });
//
//    } faile:^(NSError * _Nullable error) {
//        ICLog_2(@"%@",error);
//    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HidenKeyboard;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textFieldTextDidChangeNotification:(NSNotification*)notification {
    if(_nameTextField.text.length && !_timer) {
        _sendSecurityCodeButton.enabled = YES;
    } else {
        _sendSecurityCodeButton.enabled = NO;
    }
    
    if(_nameTextField.text.length && _securityCodeTextField.text.length && _passwordTextField.text.length && _repeatTextField.text.length) {
        _registerButton.enabled = YES;
    } else {
        _registerButton.enabled = NO;
    }
}



#pragma mark--发送验证码
-(void)runTimer {
    if(!_timer) {
        _sendSecurityCodeButton.enabled = NO;
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    }
}
-(void)timerHandler:(NSTimer*)timer {
    _currentTime++;
    if(_currentTime >= _maxTime) {
        [_timer invalidate];
        _timer = nil;
        _currentTime = 0;
        [_sendSecurityCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendSecurityCodeButton setTitle:@"发送验证码" forState:UIControlStateDisabled];
        if(_nameTextField.text.length > 0) {
            _sendSecurityCodeButton.enabled = YES;
        }
        
    } else {
        NSString *title = [NSString stringWithFormat:@"发送验证码(%d)",(int)(_maxTime - _currentTime)];
        [_sendSecurityCodeButton setTitle:title forState:UIControlStateDisabled];
    }
}

-(void)test{
    
    
    switch (1) {
        case 1001:  //YYLog(@"reultCode=1001,数据库没有这条数据");
        {
            
            break;
        }
        case 1002:{
//            YYLog(@"reultCode=1002,系统错误");
            break;
        }
        case 1003:
        {
//            YYLog(@"reultCode=1003,密码错误");
            break;
        }
        case -1004:
        {
//            YYLog(@"reultCode=1004,sql语句执行错误");
            break;
        }
        case 1005:
        {
//            YYLog(@"reultCode=1005,未知错误");
            break;
        }
        case 1006:
        {
//            YYLog(@"reultCode=1006,参数中有空");
            break;
        }
        case 1007:
        {
        }
        case 1008:
        {
//            YYLog(@"reultCode=1008,验证码错误");
            break;
        }
        case 1009:
        {
//            YYLog(@"reultCode=1009,登录IP不符");
            break;
        }
        case 1011:
        {
//            YYLog(@"reultCode=1011,用户登录macid和本次请求macid不符");
            break;
        }
        case 1012:
        {
//            YYLog(@"reultCode=1012,误差值过大");
            break;
        }
            //        case 1013:
            // [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
        case 1014:
        {
//            YYLog(@"reultCode=1014,数据库中已存在数据");
            break;
        }
        
case 1015:
    {
//        YYLog(@"reultCode=1015,验证码不匹配");
        break;
    }
case 1016:
    {
//        YYLog(@"reultCode=1016,用户没有权限");
        break;
    }
case 1017:
    {
//        YYLog(@"reultCode=1017,图片符合格式");
        break;
    }
case 1018:
    {
//        [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
//        YYLog(@"reultCode=1018,操作没有成功");
        break;
    }
case 1019:
    {
//        YYLog(@"reultCode=1019,删除没有成功");
        break;
    }
case 1020:
    {
//        YYLog(@"reultCode=1020,修改操作没有成功");
        break;
    }
case 1021:
    {
//        YYLog(@"reultCode=1021,用户名在数据库中不存存在");
        break;
    }
case 1022:
    {
        //                [SVProgressHUD showErrorWithStatus:@"操作没有成功"];
//        YYLog(@"reultCode=1022,请核对金额");
        break;
    }
case 1023:
    {
//        YYLog(@"reultCode=1022,用户名不存在");
        break;
    }
case 1024:
    {
//        [SVProgressHUD showErrorWithStatus:@"余额不足"];
//        YYLog(@"reultCode=1022,用户名不存在");
        break;
    }
default:
    //                [SVProgressHUD showErrorWithStatus:@"服务繁忙，请稍后再试"];
    break;
}

}
-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
