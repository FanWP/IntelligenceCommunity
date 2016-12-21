//
//  ReceiveAddressCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ReceiveAddressCell.h"

@implementation ReceiveAddressCell

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
   // 收货人 receiverLabel;
    _receiverLabel = [[UILabel alloc] init];
    _receiverLabel.font = UIFont13;
    _receiverLabel.text = @"收货人：张三";
    [self.contentView addSubview:_receiverLabel];
    [_receiverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.top.mas_offset(8);
        make.width.mas_offset(200);
        make.height.mas_offset(30);
    }];
    
   // 收货人手机号 receiverPhoneNumLabel;
    _receiverPhoneNumLabel = [[UILabel alloc] init];
    _receiverPhoneNumLabel.font = UIFont13;
    _receiverPhoneNumLabel.text = @"18789494949";
    _receiverPhoneNumLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_receiverPhoneNumLabel];
    [_receiverPhoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.width.mas_offset(100);
        make.top.height.equalTo(_receiverLabel);
    }];
    
    
   // 收货地址 receiveAddressLabel;
    _receiveAddressLabel = [[UILabel alloc] init];
    _receiveAddressLabel.font = UIFont13;
    _receiveAddressLabel.text = @"陕西省西安市雁塔区高新三路财富中心";
    [self.contentView addSubview:_receiveAddressLabel];
    [_receiveAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.top.equalTo(_receiverLabel.mas_bottom);
        make.right.mas_offset(-12);
        make.height.mas_offset(30);
    }];
    
    
   //  lineView;
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = HexColor(0xe5e5e5);
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.equalTo(_receiveAddressLabel.mas_bottom).offset(5);
        make.height.mas_offset(0.5);
    }];
    
    
   // 设为默认地址按钮 defaultAddressButton;
    _defaultAddressButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _deleteAddressButton.backgroundColor = [UIColor redColor];
    [_defaultAddressButton setImage:[[UIImage imageNamed:@"unselected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [_defaultAddressButton setImage:[[UIImage imageNamed:@"selected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateSelected)];
    [_defaultAddressButton.titleLabel setFont:UIFont13];
    [self.contentView addSubview:_defaultAddressButton];
    [_defaultAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.equalTo(_lineView.mas_bottom).offset(0);
        make.width.height.mas_offset(40);
    }];
    
    
    
   // 设为默认地址 defaultAddressLabel;
    _defaultAddressLabel = [[UILabel alloc] init];
    _defaultAddressLabel.text = @"设为默认地址";
    _defaultAddressLabel.font = UIFont13;
    [self.contentView addSubview:_defaultAddressLabel];
    [_defaultAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_defaultAddressButton.mas_right).offset(5);
        make.centerY.equalTo(_defaultAddressButton.mas_centerY);
        make.width.mas_offset(120);
        make.height.mas_offset(30);
    }];
    
    
    
   // 编辑地址 editAddressButton;
    _editAddressButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_editAddressButton setTitle:@"编辑" forState:(UIControlStateNormal)];
    [_editAddressButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_editAddressButton.titleLabel setFont:UIFont13];
    [self.contentView addSubview:_editAddressButton];
    [_editAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_defaultAddressButton.mas_centerY);
        make.right.mas_offset(-(12 + 60 + 16));
        make.width.mas_offset(60);
        make.height.mas_offset(25);
    }];
    
    
    
   // 删除地址 deleteAddressButton;
    _deleteAddressButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_deleteAddressButton setTitle:@"删除" forState:(UIControlStateNormal)];
    [_deleteAddressButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_deleteAddressButton.titleLabel setFont:UIFont13];
    [self.contentView addSubview:_deleteAddressButton];
    [_deleteAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_defaultAddressButton.mas_centerY);
        make.right.mas_offset(-12);
        make.width.mas_offset(60);
        make.height.mas_offset(25);
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
