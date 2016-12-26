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
//    _totalPriceLabel.text = @"￥0.00元";
    if (_payMentTotalPriceString && _payMentTotalPriceString.length) {
        
        _totalPriceLabel.text = [NSString stringWithFormat:@"￥ %@ 元",_payMentTotalPriceString];
    }
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
    //付款按钮
//    @property(nonatomic,strong) UIView *bottomView;
//    @property(nonatomic,strong) UIImageView *commitOrderImageView;
//    @property(nonatomic,strong) UILabel *commitOrderLabel;
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor orangeColor];
    _bottomView.layer.borderWidth = 1;
    _bottomView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(49);
    }];
    _commitOrderLabel = [[UILabel alloc] init];
    _commitOrderLabel.text = @"确认付款";
    _commitOrderLabel.textColor = [UIColor whiteColor];
    _commitOrderLabel.textAlignment = NSTextAlignmentCenter;
    _commitOrderLabel.font = UIFontLarge;
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
