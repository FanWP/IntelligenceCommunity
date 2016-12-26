//
//  MyOrdersDealCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/26.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MyOrdersDealCell.h"

@implementation MyOrdersDealCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)initializeComponent
{
    // 时间 timeLabel;
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = UIFontSmall;
    _timeLabel.textColor = HexColor(0x8a8a8a);
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_offset(150);
        make.height.mas_offset(30);
    }];
    
    // firstButton;
    _firstButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_firstButton.titleLabel setFont:UIFont13];
    _firstButton.layer.borderWidth = 1;
    _firstButton.layer.borderColor = [UIColor blackColor].CGColor;
    _firstButton.layer.cornerRadius = 5.0;
    [_firstButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_firstButton];
    [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.mas_offset(-12 - 60 - 16);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
    }];
    
    
    // secondButton;
    _secondButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_secondButton.titleLabel setFont:UIFont13];
    _secondButton.layer.borderWidth = 1;
    _secondButton.layer.borderColor = HexColor(0x05c4a2).CGColor;
    _secondButton.layer.cornerRadius = 5.0;
    [_secondButton setTitleColor:HexColor(0x05c4a2) forState:(UIControlStateNormal)];
    [self.contentView addSubview:_secondButton];
    [_secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(12);
        make.width.mas_offset(60);
        make.height.equalTo(_firstButton.mas_height);
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
