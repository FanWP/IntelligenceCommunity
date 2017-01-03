//
//  LoginViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "LoginViewController.h"
#import "MUButton.h"
#import "RootTabBarController.h"

#import "RegisterViewController.h"  //注册


@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];

    
    [self initializeComponent];
}

-(void)initializeComponent {
    self.title = @"登录";
    
    UIImageView *nameLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    nameLeftView.contentMode = UIViewContentModeCenter;
    nameLeftView.image = [UIImage imageNamed:@"account"];
    
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
        make.top.mas_equalTo(kGetVerticalDistance(220));
        make.left.mas_equalTo(kGetHorizontalDistance(78));
        make.right.mas_equalTo(-kGetHorizontalDistance(78));
        make.height.mas_equalTo(kGetVerticalDistance(90));
    }];
    
    UIImageView *passLeftView = [[UIImageView alloc] initWithFrame:nameLeftView.bounds];
    passLeftView.contentMode = UIViewContentModeCenter;
    passLeftView.image = [UIImage imageNamed:@"password"];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.placeholder = @"密码";
    _passwordTextField.textColor = HexColor(0x3d3c3c);
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.delegate = self;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    _passwordTextField.leftView = passLeftView;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.tintColor = ThemeColor;
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.layer.borderWidth = 1;
    _passwordTextField.layer.borderColor = HexColor(0xcccccc).CGColor;
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTextField.mas_bottom).offset(kGetVerticalDistance(32));
        make.left.equalTo(_nameTextField.mas_left);
        make.right.equalTo(_nameTextField.mas_right);
        make.height.equalTo(_nameTextField.mas_height);
    }];
    
    _loginButton = [[MUButton alloc] init];
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 5;
    _loginButton.enabled = NO;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[Common imageWithFrame:_loginButton.bounds color:HexColor(0x05c4a2)] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.mas_bottom).offset(kGetVerticalDistance(100));
        make.left.equalTo(_passwordTextField.mas_left);
        make.right.equalTo(_passwordTextField.mas_right);
        make.height.mas_equalTo(44);
    }];
    
    //注册
//    @property(nonatomic,strong,readonly) UIButton *registerButton;
    _registerButton = [[UIButton alloc] init];
    _registerButton.titleLabel.font = UIFontNormal;
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:HexColor(0x4fc6ec) forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginButton.mas_bottom).offset(kGetVerticalDistance(24));
        make.left.mas_offset(kGetHorizontalDistance(94));
    }];
    
     _forgetPasswordButton = [[UIButton alloc] init];
    _forgetPasswordButton.titleLabel.font = UIFontNormal;
    [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetPasswordButton setTitleColor:HexColor(0x4fc6ec) forState:UIControlStateNormal];
    [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetPasswordButton];
    [_forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_registerButton).offset(0);
        make.right.mas_offset(-kGetHorizontalDistance(94));
    }];
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    User *user = [User currentUser];
    if(user) {
        _nameTextField.text = user.name;
        _loginButton.enabled = YES;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HidenKeyboard;
}

//点击登录按钮

-(void)loginButtonTouchUpInside:(MUButton *)sender {
    HidenKeyboard;
        
    ICLog_2(@"登录");
    _loginButton.enabled = NO;
    [_loginButton startAnimation];
    
    [self getPublicKey];
}
#pragma mark--获取公钥
-(void)getPublicKey{
    
    //获取公钥
        [[RequestManager manager] JSONRequestWithType:Smart_community urlString:@"unlogin/sendpubkeyservlet" method:RequestMethodPost timeout:20 parameters:nil success:^(id  _Nullable responseObject) {
    
            if ([responseObject[@"resultCode"] integerValue] == 1000) {
                [self loginCheckWithPublicKey:responseObject[@"pubKey"]];
            }else{
                [self alertControllerWithMessage:@"获取公钥失败"];
            }
        } faile:^(NSError * _Nullable error) {
            ICLog_2(@"%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                _nameTextField.text = @"";
                _passwordTextField.text = @"";
                self.loginButton.enabled = YES;
                [self.loginButton stopAnimation];
            });
        }];
        
}
#pragma mark--登录验证
-(void)loginCheckWithPublicKey:(NSString *)pubkey{
    
//18092456642   qqq111
    
//    NSString *pubKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDoKNwoOrJQguazWyH+apdVlq6zJDx7bVDV5Fq2pxs9uPuGCeTH803TSA+pOguNCZ1Og6+XuP/FkqyN3etdu9qFQqkSsNDZzPBWhwG9bnNLLpnO/hDS4PVLg0pLNZFl1Pbi/TYhFxg2w+YQU1FW4P/9pWHbgE2YG+gWO+MC9ee2LwIDAQAB";
    NSString *passwordString = _passwordTextField.text;
    NSString *finishRSAString = [RSAEncryptor encryptString:passwordString publicKey:pubkey];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [parametersDic setValue:_nameTextField.text forKey:@"userPhone"];
    [parametersDic setValue:finishRSAString forKey:@"passWord"];
    
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@smart_community/unlogin/userlogin",Smart_community_URL];
    [[AFHTTPSessionManager manager] POST:serviceURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ICLog_2(@"%@",responseObject);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.loginButton.enabled = YES;
            [self.loginButton stopAnimation];
            
            if ([responseObject[@"resultCode"] integerValue] == 1000) {
//                [self alertControllerWithMessage:@"登录成功"];
                [self saveUserBaseInfoWithDictionary:responseObject pubkey:pubkey];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    RootTabBarController *tabBarController = [[RootTabBarController alloc] init];
                    tabBarController.skipAuthOnce = YES;
                    [self.navigationController setViewControllers:@[tabBarController]];
                    
                });
                
            }else{
                _nameTextField.text = @"";
                [self alertControllerWithMessage:@"登录失败,请检查手机号、密码是否正确"];
            }
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ICLog_2(@"%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.loginButton.enabled = YES;
            [self.loginButton stopAnimation];
        });
    }];
    
}
#pragma mark--注册
-(void)registerAction:(UIButton *)button{
    ICLog_2(@"注册");
    
    RegisterViewController *VC = [[RegisterViewController alloc] init];
    VC.registerOrForgetPassword = RegisterAccount;  //注册
    [self.navigationController pushViewController:VC animated:YES];
    
}
#pragma mark--忘记密码
-(void)forgetPasswordButtonAction:(UIButton *)button{
    ICLog_2(@"忘记密码");
    
    RegisterViewController *VC = [[RegisterViewController alloc] init];
    VC.registerOrForgetPassword = ForgetPassword;  //注册
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@"\n"]) {
        if([textField isEqual:_nameTextField]) {
            [_passwordTextField becomeFirstResponder];
        } else {
            [_passwordTextField resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

-(void)textFieldTextDidChangeNotification:(NSNotification*)notification {
    
    if(_nameTextField.text && _nameTextField.text.length && _passwordTextField.text && _passwordTextField.text.length) {
        _loginButton.enabled = YES;
    } else {
        _loginButton.enabled = NO;
    }
}
#pragma mark--保存用户基本信息
-(void)saveUserBaseInfoWithDictionary:(NSDictionary *)dic pubkey:(NSString *)pubkey{
    
    NSString *name = _nameTextField.text;
    NSString *password = _passwordTextField.text;
    
    NSMutableDictionary *dictionary = dic[@"user"];
    
    User *user;
    RLMResults *results = [CacheData search:[User class] predicate:[NSString stringWithFormat:@"name='%@'",name]];
    if(results && results.count > 0) {
        user = results.firstObject;
        [CacheData write:^{
            user.password = password;
            user.localUpdateAt = [NSDate date];
            user.isLogout = NO;
            
            //用户基本信息
            if (dictionary[@"account"]) {
                user.account = [NSString stringWithFormat:@"%@",dictionary[@"account"]];
            }
            if (dictionary[@"headimage"]) {
                
                user.headimage =  [NSString stringWithFormat:@"%@",dictionary[@"headimage"]];
            }
            if (dictionary[@"birthday"]) {
                
                user.birthday = [NSString stringWithFormat:@"%@",dictionary[@"birthday"]];
            }
            if (dictionary[@"houseid"]) {
                
                user.houseid = [NSString stringWithFormat:@"%@",dictionary[@"houseid"]];
            }
            if (dictionary[@"username"]) {
                
                user.username = [NSString stringWithFormat:@"%@",dictionary[@"username"]];
            }
            if (dictionary[@"referee"]) {
                
                user.referee = [NSString stringWithFormat:@"%@",dictionary[@"referee"]];
            }
            if (dictionary[@"communityId"]) {
                
                user.communityId = [NSString stringWithFormat:@"%@",dictionary[@"communityId"]];
            }
            if (dictionary[@"telephone"]) {
                
                user.telephone = [NSString stringWithFormat:@"%@",dictionary[@"telephone"]];
            }
            if (dictionary[@"communityName"]) {
                
                user.communityName = [NSString stringWithFormat:@"%@",dictionary[@"communityName"]];
            }
            if (dictionary[@"nickname"]) {
                
                user.nickname = [NSString stringWithFormat:@"%@",dictionary[@"nickname"]];
            }
            if (dictionary[@"sex"]) {
                
                user.sex = [NSString stringWithFormat:@"%@",dictionary[@"sex"]];
            }
            if (dictionary[@"lasttime"]) {
                
                user.lasttime = [NSString stringWithFormat:@"%@",dictionary[@"lasttime"]];
            }
            if (dictionary[@"type"]) {
                
                user.type = [NSString stringWithFormat:@"%@",dictionary[@"type"]];
            }
            if (dictionary[@"id"]) {
                
                user.userID = [NSString stringWithFormat:@"%@",dictionary[@"id"]];
            }
            
            if (dictionary[@"email"]) {
                
                user.email = [NSString stringWithFormat:@"%@",dictionary[@"email"]];
            }
            if (dictionary[@"houseRole"]) {
                
                user.houseRole = [NSString stringWithFormat:@"%@",dictionary[@"houseRole"]];
            }
            if (dictionary[@"viplevel"]) {
                
                user.viplevel = [NSString stringWithFormat:@"%@",dictionary[@"viplevel"]];
            }
            if (dictionary[@"identity"]) {
                
                user.identity = [NSString stringWithFormat:@"%@",dictionary[@"identity"]];
            }
            if (dictionary[@"passwd"]) {
                
                user.password = [NSString stringWithFormat:@"%@",dictionary[@"passwd"]];
            }
            if (dictionary[@"createtime"]) {
                
                user.createtime = [NSString stringWithFormat:@"%@",dictionary[@"createtime"]];
            }
            if (dictionary[@"address"]) {
                
                user.address = [NSString stringWithFormat:@"%@",dictionary[@"address"]];
            }
            if (dictionary[@"description"]) {
                
                user.userDescription = [NSString stringWithFormat:@"%@",dictionary[@"description"]];
            }
            if (dic[@"sessionId"]) {
                
             NSString *finshRSASessionID =  [RSAEncryptor encryptString:[NSString stringWithFormat:@"%@",dic[@"sessionId"]] publicKey:pubkey];
                
                user.sessionId = finshRSASessionID;
            }
            
            
            user.sessionId = dic[@"sessionId"];
        }];
    } else {
        user = [[User alloc] init];
        user.name = name;
        user.password = password;
        user.localUpdateAt = [NSDate date];
        
        //用户基本信息
        if (dictionary[@"account"]) {
            user.account = [NSString stringWithFormat:@"%@",dictionary[@"account"]];
        }
        if (dictionary[@"headimage"]) {
            
            user.headimage =  [NSString stringWithFormat:@"%@",dictionary[@"headimage"]];
        }
        if (dictionary[@"birthday"]) {
            
            user.birthday = [NSString stringWithFormat:@"%@",dictionary[@"birthday"]];
        }
        if (dictionary[@"houseid"]) {
            
            user.houseid = [NSString stringWithFormat:@"%@",dictionary[@"houseid"]];
        }
        if (dictionary[@"username"]) {
            
            user.username = [NSString stringWithFormat:@"%@",dictionary[@"username"]];
        }
        if (dictionary[@"referee"]) {
            
            user.referee = [NSString stringWithFormat:@"%@",dictionary[@"referee"]];
        }
        if (dictionary[@"communityId"]) {
            
            user.communityId = [NSString stringWithFormat:@"%@",dictionary[@"communityId"]];
        }
        if (dictionary[@"telephone"]) {
            
            user.telephone = [NSString stringWithFormat:@"%@",dictionary[@"telephone"]];
        }
        if (dictionary[@"communityName"]) {
            
            user.communityName = [NSString stringWithFormat:@"%@",dictionary[@"communityName"]];
        }
        if (dictionary[@"nickname"]) {
            
            user.nickname = [NSString stringWithFormat:@"%@",dictionary[@"nickname"]];
        }
        if (dictionary[@"sex"]) {
            
            user.sex = [NSString stringWithFormat:@"%@",dictionary[@"sex"]];
        }
        if (dictionary[@"lasttime"]) {
            
            user.lasttime = [NSString stringWithFormat:@"%@",dictionary[@"lasttime"]];
        }
        if (dictionary[@"type"]) {
            
            user.type = [NSString stringWithFormat:@"%@",dictionary[@"type"]];
        }
        if (dictionary[@"id"]) {
            
            user.userID = [NSString stringWithFormat:@"%@",dictionary[@"id"]];
        }
        if (dictionary[@"email"]) {
            
            user.email = [NSString stringWithFormat:@"%@",dictionary[@"email"]];
        }
        user.houseRole = dictionary[@"houseRole"];
        if (dictionary[@"houseRole"]) {
            
            user.houseRole = [NSString stringWithFormat:@"%@",dictionary[@"houseRole"]];
        }
        if (dictionary[@"viplevel"]) {
            
            user.viplevel = [NSString stringWithFormat:@"%@",dictionary[@"viplevel"]];
        }
        if (dictionary[@"identity"]) {
            
            user.identity = [NSString stringWithFormat:@"%@",dictionary[@"identity"]];
        }
        if (dictionary[@"passwd"]) {
            
            user.password = [NSString stringWithFormat:@"%@",dictionary[@"passwd"]];
        }
        if (dictionary[@"createtime"]) {
            
            user.createtime = [NSString stringWithFormat:@"%@",dictionary[@"createtime"]];
        }
        if (dictionary[@"address"]) {
            
            user.address = [NSString stringWithFormat:@"%@",dictionary[@"address"]];
        }
        if (dictionary[@"description"]) {
            
            user.userDescription = [NSString stringWithFormat:@"%@",dictionary[@"description"]];
        }
        if (dic[@"sessionId"]) {
            
            NSString *finshRSASessionID =  [RSAEncryptor encryptString:[NSString stringWithFormat:@"%@",dic[@"sessionId"]] publicKey:pubkey];
            user.sessionId = finshRSASessionID;
        }
        [CacheData addObject:user];
    }
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
