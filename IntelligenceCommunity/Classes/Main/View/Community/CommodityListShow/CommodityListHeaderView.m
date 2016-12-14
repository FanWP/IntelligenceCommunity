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
    
    //店铺展示图片
//    @property(nonatomic,strong) UIImageView *storeAdvertiseImageView;
    _storeAdvertiseImageView = [[UIImageView alloc] init];
    _storeAdvertiseImageView.contentMode = UIViewContentModeCenter;
    _storeAdvertiseImageView.clipsToBounds = YES;
    _storeAdvertiseImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_storeAdvertiseImageView];
    [_storeAdvertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_offset(0);
        make.width.mas_offset(ScreenWidth/4);
        
    }];
//    //店铺名称
//    @property(nonatomic,strong) UILabel *storeNameLabel;
    _storeNameLabel = [[UILabel alloc] init];
    _storeNameLabel.text = @"店铺名称";
    _storeNameLabel.textColor = [UIColor grayColor];
    _storeNameLabel.textAlignment = NSTextAlignmentLeft;
    _storeNameLabel.font = UIFontNormal;
    [self addSubview:_storeNameLabel];
    [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(_storeAdvertiseImageView.mas_right).offset(10);
        make.right.mas_offset(0);
        make.height.mas_offset(30);
    }];
//    //店铺签名
//    @property(nonatomic,strong) UILabel *storeRemarkLabel;
    _storeRemarkLabel = [[UILabel alloc] init];
    _storeRemarkLabel.text = @"签名:薄利多销 实惠方便";
    _storeRemarkLabel.textColor = [UIColor grayColor];
    _storeRemarkLabel.textAlignment = NSTextAlignmentLeft;
    _storeRemarkLabel.font = UIFontSmall;
    [self addSubview:_storeRemarkLabel];
    [_storeRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_storeAdvertiseImageView.mas_centerY);
        make.left.equalTo(_storeAdvertiseImageView.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
//    //营业时间
//    @property(nonatomic,strong) UILabel *storeWorkTimeLabel;
    _storeWorkTimeLabel = [[UILabel alloc] init];
    _storeWorkTimeLabel.text = @"营业时间: 00:00~00:00";
    _storeWorkTimeLabel.textColor = [UIColor grayColor];
    _storeWorkTimeLabel.textAlignment = NSTextAlignmentLeft;
    _storeWorkTimeLabel.font = UIFontSmall;
    [self addSubview:_storeWorkTimeLabel];
    [_storeWorkTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_storeNameLabel.mas_left);
        make.bottom.mas_equalTo(_storeAdvertiseImageView.mas_bottom);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    
}

@end
