//
//  MyOrdersStoreTitleCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/26.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MyOrdersStoreTitleCell.h"

@implementation MyOrdersStoreTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self initializeComponent];
    }
    
    return self;
}


- (void)initializeComponent
{
    // 店铺名称 storeNameButton;
    _storeNameButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_storeNameButton.titleLabel setFont:UIFont15];
    [self.contentView addSubview:_storeNameButton];
    [_storeNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
    
    
    // 箭头 arrowImageView;
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [[UIImage imageNamed:@"arrow"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [self.contentView addSubview:_arrowImageView];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_storeNameButton.mas_right);
        make.centerY.equalTo(_storeNameButton.mas_centerY);
        make.width.height.mas_offset(30);
    }];
    
    
    // 交易状态 statusButton;
    _statusButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_statusButton.titleLabel setFont:UIFont13];
    [_statusButton setTitleColor:HexColor(0xd41b38) forState:(UIControlStateNormal)];
    [self.contentView addSubview:_statusButton];
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.centerY.equalTo(_storeNameButton.mas_centerY);
        make.width.mas_offset(100);
        make.height.equalTo(_storeNameButton.mas_height);
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
