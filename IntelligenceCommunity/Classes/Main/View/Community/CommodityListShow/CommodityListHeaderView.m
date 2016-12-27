//
//  CommodityListHeaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommodityListHeaderView.h"

@implementation CommodityListHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(CGSizeEqualToSize(CGSizeZero, frame.size)) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        frame.size = CGSizeMake(size.width, 30);
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeComponent];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)initializeComponent{
    
    
    
    //背景高斯模糊图片
//    @property(nonatomic,strong) UIImageView *bottomImageView;
    _bottomImageView = [[UIImageView alloc] init];
    _bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bottomImageView.clipsToBounds = YES;
    _bottomImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_bottomImageView];
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffect.frame = CGRectMake(0, 0, self.width, self.height);
    visualEffect.alpha = 0.9;
    [_bottomImageView addSubview:visualEffect];
    
    
    
    //店铺展示图片
//    @property(nonatomic,strong) UIImageView *storeAdvertiseImageView;
    _storeAdvertiseImageView = [[UIImageView alloc] init];
    _storeAdvertiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    _storeAdvertiseImageView.clipsToBounds = YES;
    _storeAdvertiseImageView.image = [UIImage imageNamed:@"2.jpg"];
    _storeAdvertiseImageView.layer.cornerRadius = kGetHorizontalDistance(77);
    _storeAdvertiseImageView.layer.masksToBounds = YES;
    [self addSubview:_storeAdvertiseImageView];
    [_storeAdvertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kGetVerticalDistance(26));
        make.bottom.mas_offset(-kGetVerticalDistance(26));
        make.left.mas_offset(kGetHorizontalDistance(50));
        make.width.height.mas_offset(kGetHorizontalDistance(144));
        
    }];
//    //店铺名称
//    @property(nonatomic,strong) UILabel *storeNameLabel;
    _storeNameLabel = [[UILabel alloc] init];
    _storeNameLabel.text = @"店铺名称";
    _storeNameLabel.textColor = HexColor(0xffffff);
    _storeNameLabel.textAlignment = NSTextAlignmentLeft;
    _storeNameLabel.font = UIFontLargest;
    [self addSubview:_storeNameLabel];
    [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_storeAdvertiseImageView.mas_top).offset(-5);
        make.left.equalTo(_storeAdvertiseImageView.mas_right).offset(kGetHorizontalDistance(60));
        make.right.mas_offset(0);
        make.height.mas_offset(30);
    }];
    
    //    //营业时间
    //    @property(nonatomic,strong) UILabel *storeWorkTimeLabel;
    _storeWorkTimeLabel = [[UILabel alloc] init];
    _storeWorkTimeLabel.text = @"营业时间: 00:00~00:00";
    _storeWorkTimeLabel.textColor = HexColor(0xffffff);
    _storeWorkTimeLabel.textAlignment = NSTextAlignmentLeft;
    _storeWorkTimeLabel.font = UIFontSmall;
    [self addSubview:_storeWorkTimeLabel];
    [_storeWorkTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_storeAdvertiseImageView.mas_centerY);
        make.left.equalTo(_storeNameLabel.mas_left).offset(0);
        make.height.mas_equalTo(20);
    }];

//    //店铺签名
//    @property(nonatomic,strong) UILabel *storeRemarkLabel;
    _storeRemarkLabel = [[UILabel alloc] init];
    _storeRemarkLabel.text = @"签名:薄利多销 实惠方便";
    _storeRemarkLabel.textColor = HexColor(0xffffff);
    _storeRemarkLabel.textAlignment = NSTextAlignmentLeft;
    _storeRemarkLabel.font = UIFontNormal;
    [self addSubview:_storeRemarkLabel];
    [_storeRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_storeNameLabel.mas_left);
        make.bottom.mas_equalTo(_storeAdvertiseImageView.mas_bottom).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        
        
    }];
    
    
}

@end
