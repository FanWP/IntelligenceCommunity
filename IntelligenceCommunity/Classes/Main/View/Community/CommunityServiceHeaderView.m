//
//  CommunityServiceHeaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommunityServiceHeaderView.h"

@interface CommunityServiceHeaderView ()

//商品
@property(nonatomic,strong) UIButton *commodityButton;
//便民
@property(nonatomic,strong) UIButton *convenientButton;
//美食
@property(nonatomic,strong) UIButton *delicacyButton;
//娱乐
@property(nonatomic,strong) UIButton *entertainmentButton;

@end

@implementation CommunityServiceHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    self.contentView.backgroundColor = [UIColor whiteColor];
    //商品
//    @property(nonatomic,strong) UIImageView *commodityImageView;
//    @property(nonatomic,strong) UILabel *commodityLabel;
    _commodityImageView = [[UIImageView alloc] init];
    _commodityImageView.contentMode = UIViewContentModeCenter;
    _commodityImageView.image = [UIImage imageNamed:@"shop"];
    [self.contentView addSubview:_commodityImageView];
    [_commodityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth/4);
    }];
    _commodityLabel = [[UILabel alloc] init];
//    _commodityLabel.text = @"商品";
    _commodityLabel.textAlignment = NSTextAlignmentCenter;
    _commodityLabel.textColor = [UIColor grayColor];
    _commodityLabel.font = UIFontNormal;
    [self.contentView addSubview:_commodityLabel];
    [_commodityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commodityImageView.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.equalTo(_commodityImageView.mas_width);
        make.height.mas_equalTo(30);
    }];
    _commodityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commodityButton.tag = 1;
    [_commodityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_commodityButton];
    [_commodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.width.mas_equalTo(_commodityImageView);
        make.bottom.equalTo(_commodityLabel.mas_bottom);
    }];
    
//    //便民
//    @property(nonatomic,strong) UIImageView *convenientImageView;
//    @property(nonatomic,strong) UILabel *convenientLabel;
    _convenientImageView = [[UIImageView alloc] init];
    _convenientImageView.contentMode = UIViewContentModeCenter;
    _convenientImageView.image = [UIImage imageNamed:@"Convenience"];
    [self.contentView addSubview:_convenientImageView];
    [_convenientImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_commodityImageView);
        make.left.equalTo(_commodityImageView.mas_right).offset(0);
    }];
    _convenientLabel = [[UILabel alloc] init];
//    _convenientLabel.text = @"便民";
    _convenientLabel.textColor = [UIColor grayColor];
    _convenientLabel.textAlignment = NSTextAlignmentCenter;
    _convenientLabel.font = UIFontNormal;
    [self.contentView addSubview:_convenientLabel];
    [_convenientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_commodityLabel);
        make.left.equalTo(_commodityLabel.mas_right).offset(0);
    }];
    _convenientButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _convenientButton.tag = 2;
    [_convenientButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_convenientButton];
    [_convenientButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_commodityButton);
        make.left.equalTo(_commodityButton.mas_right).offset(0);
    }];
    
//    //美食
//    @property(nonatomic,strong) UIImageView *delicacyImageView;
//    @property(nonatomic,strong) UILabel *delicacyLabel;
    _delicacyImageView = [[UIImageView alloc] init];
    _delicacyImageView.contentMode = UIViewContentModeCenter;
    _delicacyImageView.image = [UIImage imageNamed:@"Food"];
    [self.contentView addSubview:_delicacyImageView];
    [_delicacyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_commodityImageView);
        make.left.equalTo(_convenientImageView.mas_right).offset(0);
    }];
    _delicacyLabel = [[UILabel alloc] init];
//    _delicacyLabel.text = @"美食";
    _delicacyLabel.textColor = [UIColor grayColor];
    _delicacyLabel.textAlignment = NSTextAlignmentCenter;
    _delicacyLabel.font = UIFontNormal;
    [self.contentView addSubview:_delicacyLabel];
    [_delicacyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_convenientLabel);
        make.left.equalTo(_convenientLabel.mas_right).offset(0);
    }];
    _delicacyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _delicacyButton.tag = 3;
    [_delicacyButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_delicacyButton];
    [_delicacyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_commodityButton);
        make.left.equalTo(_convenientButton.mas_right).offset(0);
    }];
//    //娱乐
//    @property(nonatomic,strong) UIImageView *entertainmentImageView;
//    @property(nonatomic,strong) UILabel *entertainmentLabel;
    _entertainmentImageView = [[UIImageView alloc] init];
    _entertainmentImageView.contentMode = UIViewContentModeCenter;
    _entertainmentImageView.image = [UIImage imageNamed:@"entertainment"];
    [self.contentView addSubview:_entertainmentImageView];
    [_entertainmentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_commodityImageView);
        make.left.equalTo(_delicacyImageView.mas_right).offset(0);
    }];
    _entertainmentLabel = [[UILabel alloc] init];
//    _entertainmentLabel.text = @"娱乐";
    _entertainmentLabel.textColor = [UIColor grayColor];
    _entertainmentLabel.textAlignment = NSTextAlignmentCenter;
    _entertainmentLabel.font = UIFontNormal;
    [self.contentView addSubview:_entertainmentLabel];
    [_entertainmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_delicacyLabel);
        make.left.equalTo(_delicacyLabel.mas_right).offset(0);
    }];
    _entertainmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _entertainmentButton.tag = 4;
    [_entertainmentButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_entertainmentButton];
    [_entertainmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_commodityButton);
        make.left.equalTo(_delicacyButton.mas_right).offset(0);
    }];
    
    
}

-(void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(headerView:buttonWithTag:)]) {
        [_delegate headerView:self buttonWithTag:button.tag];
    }
}













@end
