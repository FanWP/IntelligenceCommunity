//
//  PayMentViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PayMentViewController.h"

typedef NS_ENUM(NSUInteger, PayMentType) {
    WeChatPay = 1,      //微信支付
    ALiPay = 2,         //支付宝支付
};

@interface PayMentViewController ()

//付款金额
@property(nonatomic,strong) UILabel *payMentTitleLabel;
@property(nonatomic,strong) UILabel *totalPriceLabel;

//付款方式
@property(nonatomic,strong) UILabel *payMentTypeLabel;

    //微信支付
@property(nonatomic,strong) UIButton *wechatPayButton;
@property(nonatomic,strong) UILabel *wechatPayLabel;

    //支付宝支付
@property(nonatomic,strong) UIButton *aliPayButton;
@property(nonatomic,strong) UILabel *aliPayLabel;

//付款按钮
@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UIImageView *commitOrderImageView;
@property(nonatomic,strong) UILabel *commitOrderLabel;

@end

@implementation PayMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    self.navigationItem.title = @"在线支付";
    ICLog_2(@"%@",_payMentTotalPriceString);
    double test =   [_payMentTotalPriceString doubleValue];
    ICLog_2(@"%.2f",test);
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    [self initializeComponent];
}
-(void)initializeComponent{
    
    //付款金额
//    @property(nonatomic,strong) UILabel *payMentTitleLabel;
    _payMentTitleLabel = [[UILabel alloc] init];
    _payMentTitleLabel.text = @"需付金额";
    _payMentTitleLabel.textColor = HexColor(0x353535);
    _payMentTitleLabel.textAlignment = NSTextAlignmentLeft;
    _payMentTitleLabel.font = UIFontLarge;
    [self.view addSubview:_payMentTitleLabel];
    [_payMentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kGetVerticalDistance(56));
        make.left.mas_offset(30);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
//    @property(nonatomic,strong) UILabel *totalPriceLabel;
    _totalPriceLabel = [[UILabel alloc] init];
    _totalPriceLabel.text = @"￥ 0.00 元";
    if (_payMentTotalPriceString && _payMentTotalPriceString.length) {
        
        _totalPriceLabel.text = [NSString stringWithFormat:@"￥ %@ 元",_payMentTotalPriceString];
    }
    _totalPriceLabel.textColor = HexColor(0xf94342);
    _totalPriceLabel.textAlignment = NSTextAlignmentLeft;
    _totalPriceLabel.font = UIFontLarge;
    [self.view addSubview:_totalPriceLabel];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_payMentTitleLabel.mas_centerY);
        make.left.equalTo(_payMentTitleLabel.mas_right).offset(10);
        make.right.mas_offset(-20);
        make.height.mas_offset(30);
    }];
    
//    //付款方式
//    @property(nonatomic,strong) UILabel *payMentTypeLabel;
    _payMentTypeLabel = [[UILabel alloc] init];
    _payMentTypeLabel.text = @"付款方式";
    _payMentTypeLabel.textColor = HexColor(0x353535);
    _payMentTypeLabel.textAlignment = NSTextAlignmentLeft;
    _payMentTypeLabel.font = UIFontLarge;
    [self.view addSubview:_payMentTypeLabel];
    [_payMentTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payMentTitleLabel.mas_bottom).offset(kGetVerticalDistance(72));
        make.left.equalTo(_payMentTitleLabel.mas_left).offset(0);
        make.width.mas_equalTo(_payMentTitleLabel);
        make.height.mas_offset(30);
    }];
//    //微信支付
//    @property(nonatomic,strong) UIButton *wechatPayButton;
//    @property(nonatomic,strong) UILabel *wechatPayLabel;
    _wechatPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechatPayButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
    _wechatPayButton.tag = 1;
    _wechatPayButton.selected = YES;
    [_wechatPayButton addTarget:self action:@selector(payMentTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wechatPayButton];
    [_wechatPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_payMentTypeLabel.mas_centerY);
        make.left.equalTo(_payMentTypeLabel.mas_right).offset(10);
        make.width.height.mas_offset(30);
    }];
    _wechatPayLabel = [[UILabel alloc] init];
    _wechatPayLabel.text = @"微信支付";
    _wechatPayLabel.textColor = HexColor(0x353535);
    _wechatPayLabel.textAlignment = NSTextAlignmentLeft;
    _wechatPayLabel.font = UIFontNormal;
    [self.view addSubview:_wechatPayLabel];
    [_wechatPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_wechatPayButton.mas_centerY);
        make.left.equalTo(_wechatPayButton.mas_right).offset(10);
        make.right.mas_offset(-20);
        make.height.mas_offset(30);
    }];
//    
//    //支付宝支付
//    @property(nonatomic,strong) UIButton *aliPayButton;
//    @property(nonatomic,strong) UILabel *aliPayLabel;
    _aliPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_aliPayButton setImage:[UIImage imageNamed:@"No choice"] forState:UIControlStateNormal];
    _aliPayButton.tag = 2;
    [_aliPayButton addTarget:self action:@selector(payMentTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_aliPayButton];
    [_aliPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wechatPayButton.mas_bottom).offset(10);
        make.left.equalTo(_wechatPayButton.mas_left).offset(0);
        make.width.height.mas_equalTo(_wechatPayButton);
    }];
    _aliPayLabel = [[UILabel alloc] init];
    _aliPayLabel.text = @"支付宝支付";
    _aliPayLabel.textColor = HexColor(0x353535);
    _aliPayLabel.textAlignment = NSTextAlignmentLeft;
    _aliPayLabel.font = UIFontNormal;
    [self.view addSubview:_aliPayLabel];
    [_aliPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_aliPayButton.mas_centerY);
        make.left.equalTo(_wechatPayLabel.mas_left).offset(0);
        make.width.height.mas_equalTo(_wechatPayLabel);
    }];
    //付款按钮
//    @property(nonatomic,strong) UIButton *commitOrderButton;
    //付款按钮
//    @property(nonatomic,strong) UIView *bottomView;
//    @property(nonatomic,strong) UIImageView *commitOrderImageView;
//    @property(nonatomic,strong) UILabel *commitOrderLabel;
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = HexColor(0x04c5a1);
    _bottomView.layer.borderWidth = 1;
    _bottomView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _bottomView.layer.cornerRadius = 10;
    _bottomView.layer.masksToBounds = YES;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.mas_offset(0);
        make.left.mas_offset(kGetHorizontalDistance(30));
        make.right.mas_offset(-kGetHorizontalDistance(30));
        make.bottom.mas_offset(-kGetHorizontalDistance(42));
        make.height.mas_offset(kGetVerticalDistance(98));
    }];
    _commitOrderLabel = [[UILabel alloc] init];
    _commitOrderLabel.text = @"确认付款";
    _commitOrderLabel.textColor = HexColor(0xffffff);
    _commitOrderLabel.textAlignment = NSTextAlignmentCenter;
    _commitOrderLabel.font = UIFontLargest;
    [_bottomView addSubview:_commitOrderLabel];
    [_commitOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_bottomView.centerX);
        make.centerY.mas_equalTo(_bottomView.centerY);
        make.width.mas_offset(80);
    }];
    _commitOrderImageView = [[UIImageView alloc] init];
    _commitOrderImageView.image = [UIImage imageNamed:@"choice"];
    _commitOrderImageView.contentMode = UIViewContentModeCenter;
    [_bottomView addSubview:_commitOrderImageView];
    [_commitOrderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_bottomView.centerY);
        make.right.equalTo(_commitOrderLabel.mas_left).offset(0);
        make.width.height.mas_offset(30);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commitOrderAction:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [_bottomView addGestureRecognizer:tap];
    
}
-(void)payMentTypeButtonAction:(UIButton *)button{
    if (button.tag == 1) {
        ICLog_2(@"微信支付");
        if (_wechatPayButton.selected) {
            return;
        }
        if (_wechatPayButton.selected) {    //默认微信支付
            
            [_wechatPayButton setImage:[UIImage imageNamed:@"No choice"] forState:UIControlStateNormal];
        }else{
            [_wechatPayButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        }
        _wechatPayButton.selected = !_wechatPayButton.selected;
        
        //同步支付宝
        _aliPayButton.selected = NO;
        [_aliPayButton setImage:[UIImage imageNamed:@"No choice"] forState:UIControlStateNormal];
    }else if (button.tag == 2){
        ICLog_2(@"支付宝支付");
        if (_aliPayButton.selected) {
            return;
        }
        if (_aliPayButton.selected) {
            [_aliPayButton setImage:[UIImage imageNamed:@"No choice"] forState:UIControlStateNormal];
        }else{
            [_aliPayButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        }
        _aliPayButton.selected = !_aliPayButton.selected;
        //同步微信
        _wechatPayButton.selected = NO;
        [_wechatPayButton setImage:[UIImage imageNamed:@"No choice"] forState:UIControlStateNormal];
    }
}
-(void)commitOrderAction:(UITapGestureRecognizer *)sender{
    ICLog_2(@"确认付款");
    
//    [self requestOrderSign];
    [self AliPay];
}
-(void)requestOrderSign{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    [dic setValue:@"subject" forKey:@"subject"];
    [dic setValue:@"body" forKey:@"body"];
    [dic setValue:@"0.01" forKey:@"totalFee"];
    
    //&subject=testSubject&body=testBody&totalFee=testTotalFee
    NSData *imageData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *JSONString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    [dic setValue:JSONString forKey:@"test"];
    
    [[RequestManager manager] JSONRequestWithType:Mall_api urlString:@"signature?partner=2088421934186781&service=mobile.securitypay.pay&biz_content=1" method:RequestMethodGet timeout:10 parameters:nil success:^(id  _Nullable responseObject) {
        
        NSLog(@"------------%@",responseObject);
        
    } faile:^(NSError * _Nullable error) {
        NSLog(@"----------%@",error);
        
    }];
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [parametersDic setValue:@"2088421934186781" forKey:@"partner"];
    [parametersDic setValue:@"mobile.securitypay.pay" forKey:@"service"];
    [parametersDic setValue:JSONString forKey:@"biz_content"];
    [[RequestManager manager] requestWithURLString:@"signature" requestType:RequestMethodPost requestParameters:parametersDic success:^(id  _Nullable responseObject) {
        
        NSLog(@"------------%@",responseObject);
        
        
    } faile:^(NSError * _Nullable error) {
        
    }];
    
}
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)AliPay{
    
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    //    Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088421934186781";
    NSString *seller = @"yoyosiji@163.com";     //3455287891@qq.com     //yoyosiji@163.com
    NSString *privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKtlsUPly6KAvkQbjzFNWjX0jpssmdXhDC3V+j7jMvCcQEjwRL2DHNwqfgveo34Y84Oa5LJ6foPz4qvUIcRuQtymEAlZQwPoF70gzxb7vWSp6I91uqwrQtgFowm6gg4JfE/V3UaiIosdtTQKI3oEScXXAGU4daiASYP4dMXuxOpXAgMBAAECgYABh6naak20CKQqJXjUvtUEUEeJmQ9SemzKZ/OQ5iRJQ4vLWuGyM15plLOFVZpuALkDvrk14qQId3/Zes5GW5mbLN6YbGDqp2i63xAv2tkqQZ58nDYD4ZfGtGN1sXjLAcwhI72ubFtrgue+ygekPb/dzmMm93HwltRYiKNgSuh2eQJBANdViIRSoEC8d3aFMChtlDYlP/BB/gI661LDa02cfpSBknEkiXpJb1Z1Qy8hjN3HxLc398CZM6qY/zyhXggFnt0CQQDLxACf1v5sjJlWriZDVJUIOV04Lc8m/irETkwva0IuBwU3ufrXZaNLS3PMYMS4Lw20Jluz2rDjSKWPqr0cPgjDAkB4z7s9CiJwz4xyyXzgYcJSsolx4YSCec4HbC5qp894wE2J/wbGviaiKj4cVkVzNJ5QcS0mOI39O8OPn7Vi6MxdAkAjEX2GBMtOxTfSqjAdoF3xx2WauI+RR2b21/7WnmAKadzlBVX9YhmjaL3qK7FPfZGfMobPwlB1HViZDCp1xNtfAkAiSZkBlnFZbCnE4faqphj/GQRj7tTbkjmGmrp+XW9c83yhI2YKySwbLF6r2u+q6PIiExpzakm7tRjRDoe0pHpE";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = [self generateTradeNO];  //订单ID（由商家自行制定）
    order.subject = @"这是商品标题";                    //商品标题
    order.body = @"亲,包邮哦!";                        //商品描述
    order.totalFee = @"0.01";                   //价格
    order.notifyURL =  @"http://www.yoyosiji.com:32106/AlipayInterface/alipay/notify"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"IntelligenceCommunity";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"-------------------reslut = %@",resultDic);
            NSInteger backCode = [resultDic[@"resultStatus"] integerValue];
            NSLog(@"-----------------------%ld",backCode);
            switch (backCode) {
                case 9000:
                    NSLog(@"支付成功");
                    
                    break;
                case 8000:
                    NSLog(@"正在处理中");
                    break;
                case 4000:
                    NSLog(@"订单支付失败");
                    break;
                case 6001:
                    NSLog(@"用户中途取消");
                    break;
                case 6002:
                    NSLog(@"网络连接出错");
                    break;
                default:
                    break;
            }
            
        }];
    }
}
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
