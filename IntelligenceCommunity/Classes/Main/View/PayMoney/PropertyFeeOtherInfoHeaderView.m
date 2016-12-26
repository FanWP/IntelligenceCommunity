//
//  PropertyFeeOtherInfoHeaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeOtherInfoHeaderView.h"

@implementation PropertyFeeOtherInfoHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    self.contentView.backgroundColor = HexColor(0xffffff);
    __weak typeof(self) weakSelf = self;
    
    //缴费账期、应缴金额、缴费账号、户名、住户信息
//    @property(nonatomic,strong) UILabel *titleLabel;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = UIFontNormal;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.centerY);
        make.left.mas_equalTo(kGetHorizontalDistance(30));
        make.width.mas_equalTo(100);
    }];
    //对应详情
//    @property(nonatomic,strong) UILabel *detailLabel;
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.textColor = [UIColor grayColor];
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.font = UIFontSmall;
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleLabel.mas_centerY);
        make.left.equalTo(_titleLabel.mas_right).offset(kGetHorizontalDistance(66));
        make.right.mas_equalTo(0);
    }];
}

@end
