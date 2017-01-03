//
//  AppointmentServiceViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/30.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "AppointmentServiceViewController.h"

@interface AppointmentServiceViewController ()

//图片
@property(nonatomic,strong) UIImageView *advertiseImageView;
//提示文字
@property(nonatomic,strong) UILabel *topLabel;
@property(nonatomic,strong) UILabel *bottomLabel;
//查看订单按钮
@property(nonatomic,strong) UIButton *chackOrderButton;


@end

@implementation AppointmentServiceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"预约结果";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    
    
    [self initializeComponent];
}
-(void)initializeComponent{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //图片
//    @property(nonatomic,strong) UIImageView *advertiseImageView;
    _advertiseImageView = [[UIImageView alloc] init];
    _advertiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    _advertiseImageView.clipsToBounds = YES;
    _advertiseImageView.image = [UIImage imageNamed:@"Result"];
    [self.view addSubview:_advertiseImageView];
    [_advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kGetVerticalDistance(118));
        make.centerX.mas_equalTo(ScreenWidth/2).offset(0);
//        make.left.mas_offset(kGetHorizontalDistance(218));
//        make.right.mas_offset(kGetHorizontalDistance(-218));
        
    }];
//    //提示文字
//    @property(nonatomic,strong) UILabel *topLabel;
    _topLabel = [[UILabel alloc] init];
    _topLabel.text = @"账单已提交";
    _topLabel.textColor = HexColor(0x302f2f);
    _topLabel.font = UIFontLargest;
    _topLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_topLabel];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_advertiseImageView.mas_bottom).offset(kGetVerticalDistance(78));
        make.left.right.mas_offset(0);
    }];
//    @property(nonatomic,strong) UILabel *bottomLabel;
    _bottomLabel = [[UILabel alloc] init];
    _bottomLabel.text = @"正在安排保洁师傅,稍后会与您联系";
    _bottomLabel.textColor = [UIColor grayColor];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.font = UIFontLarge;
    [self.view addSubview:_bottomLabel];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLabel.mas_bottom).offset(kGetVerticalDistance(54));
        make.left.right.mas_offset(0);
        
    }];
//    //查看订单按钮
//    @property(nonatomic,strong) UIButton *chackOrderButton;
    _chackOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_chackOrderButton setTitle:@"查看账单" forState:UIControlStateNormal];
    [_chackOrderButton setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
    [_chackOrderButton setBackgroundImage:[Common imageWithFrame:_chackOrderButton.bounds color:HexColor(0x04c5a1)] forState:UIControlStateNormal];
    _chackOrderButton.layer.cornerRadius = kGetVerticalDistance(48);
    _chackOrderButton.layer.masksToBounds = YES;
    [_chackOrderButton addTarget:self action:@selector(chackOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_chackOrderButton];
    [_chackOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kGetHorizontalDistance(40));
        make.right.mas_offset(-kGetHorizontalDistance(40));
        make.bottom.mas_offset(-kGetVerticalDistance(154));
        make.height.mas_offset(kGetVerticalDistance(96));
    }];
    
    
}
-(void)chackOrderButtonAction:(UIButton *)button{
    ICLog_2(@"查看账单");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
