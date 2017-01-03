//
//  OrderDetailAddressCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 17/1/3.
//  Copyright © 2017年 mumu. All rights reserved.
//

#import "OrderDetailAddressCell.h"

@implementation OrderDetailAddressCell

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
    _receiverLabel = [[UILabel alloc] init];
    _receiverLabel.font = UIFont13;
    [self.contentView addSubview:_receiverLabel];
    CGFloat receiverLabelWidth = 0.7 * KWidth;
    [_receiverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.top.mas_offset(12);
        make.width.mas_offset(receiverLabelWidth);
        make.height.mas_offset(30);
    }];
    
    
    _phoneNumLabel = [[UILabel alloc] init];
    _phoneNumLabel.font = UIFont13;
//    _phoneNumLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneNumLabel];
    CGFloat phoneNumLabelWidth = KWidth - receiverLabelWidth;
    [_phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.width.mas_offset(phoneNumLabelWidth);
        make.height.mas_offset(30);
        make.centerY.equalTo(_receiverLabel.mas_centerY);
    }];
    
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.font = UIFont13;
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_receiverLabel.mas_left);
        make.top.equalTo(_receiverLabel.mas_bottom);
        make.right.mas_offset(0);
        make.height.equalTo(_receiverLabel.mas_height);
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
