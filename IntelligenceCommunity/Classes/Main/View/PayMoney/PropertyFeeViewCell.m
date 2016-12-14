//
//  PropertyFeeViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeViewCell.h"

@implementation PropertyFeeViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return  self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    
    //费用名称
//    @property(nonatomic,strong) UILabel *propertyFeeTitleLabel;
    _propertyFeeTitleLabel = [[UILabel alloc] init];
    _propertyFeeTitleLabel.text = @"费用名称";
    _propertyFeeTitleLabel.textColor = [UIColor grayColor];
    _propertyFeeTitleLabel.textAlignment = NSTextAlignmentLeft;
    _propertyFeeTitleLabel.font = UIFontNormal;
    [self addSubview:_propertyFeeTitleLabel];
    [_propertyFeeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY).offset(0);
        make.left.mas_offset(150);
        make.width.mas_offset(150);
        make.height.mas_offset(30);
    }];
    
    //钱数
//    @property(nonatomic,strong) UILabel *feeMoneyCountLabel;
    _feeMoneyCountLabel = [[UILabel alloc] init];
    _feeMoneyCountLabel.text = @"￥30.00";
    _feeMoneyCountLabel.textColor = [UIColor grayColor];
    _feeMoneyCountLabel.textAlignment = NSTextAlignmentRight;
    _feeMoneyCountLabel.font = UIFontNormal;
    [self addSubview:_feeMoneyCountLabel];
    [_feeMoneyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_propertyFeeTitleLabel.mas_centerY);
        make.right.mas_equalTo(-30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];


}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
