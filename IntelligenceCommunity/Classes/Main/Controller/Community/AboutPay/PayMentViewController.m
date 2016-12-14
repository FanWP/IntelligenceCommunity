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
@property(nonatomic,strong) UIButton *commitOrderButton;

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
    _payMentTitleLabel.textColor = [UIColor blackColor];
    _payMentTitleLabel.textAlignment = NSTextAlignmentLeft;
    _payMentTitleLabel.font = UIFontLarge;
    [self.view addSubview:_payMentTitleLabel];
    [_payMentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.left.mas_offset(100);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
//    @property(nonatomic,strong) UILabel *totalPriceLabel;
    _totalPriceLabel = [[UILabel alloc] init];
    _totalPriceLabel.text = @"￥0.00元";
    _totalPriceLabel.textColor = [UIColor redColor];
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
    _payMentTypeLabel.textColor = [UIColor blackColor];
    _payMentTypeLabel.textAlignment = NSTextAlignmentLeft;
    _payMentTypeLabel.font = UIFontLarge;
    [self.view addSubview:_payMentTypeLabel];
    [_payMentTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payMentTitleLabel.mas_bottom).offset(50);
        make.left.equalTo(_payMentTitleLabel.mas_left).offset(0);
        make.width.mas_equalTo(_payMentTitleLabel);
        make.height.mas_offset(30);
    }];
//    //微信支付
//    @property(nonatomic,strong) UIButton *wechatPayButton;
//    @property(nonatomic,strong) UILabel *wechatPayLabel;
    _wechatPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechatPayButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
    _wechatPayButton.tag = 1;
    [_wechatPayButton addTarget:self action:@selector(payMentTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wechatPayButton];
    [_wechatPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_payMentTypeLabel.mas_centerY);
        make.left.equalTo(_payMentTypeLabel.mas_right).offset(10);
        make.width.height.mas_offset(30);
    }];
    _wechatPayLabel = [[UILabel alloc] init];
    _wechatPayLabel.text = @"微信支付";
    _wechatPayLabel.textColor = [UIColor grayColor];
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
    [_aliPayButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
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
    _aliPayLabel.textColor = [UIColor grayColor];
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
    _commitOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commitOrderButton setTitle:@"确认付款" forState:UIControlStateNormal];
    [_commitOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitOrderButton addTarget:self action:@selector(payMentTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _commitOrderButton.backgroundColor = [UIColor orangeColor];
    _commitOrderButton.tag = 3;
    _commitOrderButton.layer.cornerRadius = 5;
    _commitOrderButton.layer.masksToBounds = YES;
    _commitOrderButton.layer.borderWidth = 1;
    _commitOrderButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_commitOrderButton];
    [_commitOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(49);
    }];
    
}
-(void)payMentTypeButtonAction:(UIButton *)button{
    if (button.tag == 1) {
        ICLog_2(@"微信支付");
    }else if (button.tag == 2){
        ICLog_2(@"支付宝支付");
    }else{
        ICLog_2(@"确认付款");
    }
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
