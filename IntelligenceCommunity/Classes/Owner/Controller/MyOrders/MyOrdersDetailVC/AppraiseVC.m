//
//  AppraiseVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/27.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "AppraiseVC.h"

@interface AppraiseVC ()

@property (nonatomic,strong) UIView *storeNameView;// 店铺名称view
@property (nonatomic,strong) UILabel *storeNameLabel;// 店铺名称
@property (nonatomic,strong) UIView *appraiseView;// 评价view
@property (nonatomic,strong) UILabel *appraiselabel;// 评价
@property (nonatomic,strong) UIButton *firstStarButton;
@property (nonatomic,strong) UIButton *secondStarButton;
@property (nonatomic,strong) UIButton *thirdStarButton;
@property (nonatomic,strong) UIButton *fourStarButton;
@property (nonatomic,strong) UIButton *fiveStarButton;
@property (nonatomic,strong) UIView *lineView;// 分割线
@property (nonatomic,strong) YYPlaceholderTextView *appraiseTextView;// 输入评价内容
@property (nonatomic,strong) UIView *anonymatView;// 匿名view
@property (nonatomic,strong) UILabel *anonymatLabel;// 匿名评论
@property (nonatomic,strong) UIButton *anonymatButton;// 是否匿名的button
@property (nonatomic,strong) UIButton *handAppraiseButton;// 提交评价

@end

@implementation AppraiseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0xeeeeee);
    
    [self initializeComponent];
}

- (void)initializeComponent
{
    _storeNameView = [[UIView alloc] init];
    _storeNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_storeNameView];
    [_storeNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(8);
        make.right.mas_offset(0);
        make.height.mas_offset(44);
    }];
    
    
    _storeNameLabel = [[UILabel alloc] init];
    _storeNameLabel.backgroundColor = [UIColor whiteColor];
    _storeNameLabel.text = @"店铺：米奇小妹妹的店";
    _storeNameLabel.font = UIFontLarge;
    [_storeNameView addSubview:_storeNameLabel];
    [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(7);
        make.height.mas_offset(30);
        make.right.mas_offset(-16);
    }];
    
    
    _appraiseView = [[UIView alloc] init];
    _appraiseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_appraiseView];
    [_appraiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(_storeNameView.mas_bottom).mas_offset(8);
        make.right.mas_offset(0);
        make.height.mas_offset(200);
    }];
    
    
    _appraiselabel = [[UILabel alloc] init];
    _appraiselabel.font = UIFontLarge;
    _appraiselabel.text = @"评价:";
    [_appraiseView addSubview:_appraiselabel];
    [_appraiselabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(7);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
    }];
    
    
    _firstStarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_firstStarButton setImage:[[UIImage imageNamed:@"_star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [_firstStarButton setImage:[[UIImage imageNamed:@"star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
    [_appraiseView addSubview:_firstStarButton];
    [_firstStarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_appraiselabel.mas_right);
        make.width.height.mas_offset(30);
        make.centerY.equalTo(_appraiselabel.mas_centerY);
    }];
    
    
    _secondStarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_secondStarButton setImage:[[UIImage imageNamed:@"_star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [_secondStarButton setImage:[[UIImage imageNamed:@"star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
    [_appraiseView addSubview:_secondStarButton];
    [_secondStarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_firstStarButton.mas_right);
        make.width.height.equalTo(_firstStarButton);
        make.centerY.equalTo(_firstStarButton.mas_centerY);
    }];
    
    
    _thirdStarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_thirdStarButton setImage:[[UIImage imageNamed:@"_star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [_thirdStarButton setImage:[[UIImage imageNamed:@"star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
    [_appraiseView addSubview:_thirdStarButton];
    [_thirdStarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_secondStarButton.mas_right);
        make.width.height.equalTo(_firstStarButton);
        make.centerY.equalTo(_firstStarButton.mas_centerY);
    }];
    
    
    _fourStarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_fourStarButton setImage:[[UIImage imageNamed:@"_star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [_fourStarButton setImage:[[UIImage imageNamed:@"star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
    [_appraiseView addSubview:_fourStarButton];
    [_fourStarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_thirdStarButton.mas_right);
        make.width.height.equalTo(_firstStarButton);
        make.centerY.equalTo(_firstStarButton.mas_centerY);
    }];
    
    
    _fiveStarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_fiveStarButton setImage:[[UIImage imageNamed:@"_star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [_fiveStarButton setImage:[[UIImage imageNamed:@"star"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
    [_appraiseView addSubview:_fiveStarButton];
    [_fiveStarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_fourStarButton.mas_right);
        make.width.height.equalTo(_firstStarButton);
        make.centerY.equalTo(_firstStarButton.mas_centerY);
    }];
    
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = HexColor(0xe5e5e5);
    [_appraiseView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(_appraiselabel.mas_bottom).offset(7);
        make.width.mas_offset(self.view.width - 20);
        make.height.mas_offset(1);
    }];
    
    _appraiseTextView = [[YYPlaceholderTextView alloc] init];
    _appraiseTextView.font = UIFontSmall;
    _appraiseTextView.placeholder = @"  请输入文字描述...";
    _appraiseTextView.layer.cornerRadius = 5.0;
    _appraiseTextView.layer.borderWidth = 1.0;
    _appraiseTextView.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    [_appraiseView addSubview:_appraiseTextView];
    [_appraiseTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_appraiselabel.mas_left);
        make.top.equalTo(_lineView.mas_bottom).offset(12);
        make.width.mas_offset(self.view.width - 32);
        make.height.mas_offset(130);
    }];
    
    
    _anonymatView = [[UIView alloc] init];
    _anonymatView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_anonymatView];
    [_anonymatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(_appraiseView.mas_bottom).offset(8);
        make.right.mas_offset(0);
        make.height.mas_offset(44);
    }];
    
    
    _anonymatLabel = [[UILabel alloc] init];
    _anonymatLabel.text = @"匿名评论";
    _anonymatLabel.font = UIFontLarge;
    [_anonymatView addSubview:_anonymatLabel];
    [_anonymatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_storeNameLabel.mas_left);
        make.centerY.equalTo(_anonymatView.mas_centerY);
        make.width.mas_offset(75);
        make.height.equalTo(_storeNameLabel.mas_height);
    }];
    
    
    _anonymatButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _anonymatButton.selected = YES;
    [_anonymatButton setImage:[UIImage imageNamed:@"unselected"] forState:(UIControlStateNormal)];
    [_anonymatButton setImage:[UIImage imageNamed:@"selected"] forState:(UIControlStateSelected)];
    [_anonymatView addSubview:_anonymatButton];
    [_anonymatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_anonymatLabel.mas_right);
        make.width.height.mas_offset(40);
        make.centerY.equalTo(_anonymatView.mas_centerY);
    }];
    
    
    _handAppraiseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _handAppraiseButton.backgroundColor = HexColor(0x05c4a2);
    [_handAppraiseButton setTitle:@"提交" forState:(UIControlStateNormal)];
    [_handAppraiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.equalTo(_anonymatView.mas_bottom).offset(60);
        make.right.mas_offset(-20);
        make.height.mas_offset(49);
    }];
    
    [_firstStarButton addTarget:self action:@selector(firstStarClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_secondStarButton addTarget:self action:@selector(secondStarClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_thirdStarButton addTarget:self action:@selector(thirdStarClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_fourStarButton addTarget:self action:@selector(fourStarClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_fiveStarButton addTarget:self action:@selector(fiveStarClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_anonymatButton addTarget:self action:@selector(anonymatAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_handAppraiseButton addTarget:self action:@selector(handAppraiseClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)firstStarClickAction:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)secondStarClickAction:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)thirdStarClickAction:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)fourStarClickAction:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)fiveStarClickAction:(UIButton *)button
{
    button.selected = !button.selected;
}


- (void)anonymatAction:(UIButton *)button
{
    button.selected = !button.selected;
}



- (void)handAppraiseClickAction:(UIButton *)button
{
    
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
