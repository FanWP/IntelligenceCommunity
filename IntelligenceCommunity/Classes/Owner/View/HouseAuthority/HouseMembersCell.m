//
//  HouseMembersCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseMembersCell.h"

@implementation HouseMembersCell

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
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.backgroundColor = [UIColor orangeColor];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageView.layer.cornerRadius = 47 / 2;
    _headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_offset(47);
    }];
    
    
    
    _identifierLabel = [[UILabel alloc] init];
    _identifierLabel.font = UIFont13;
    [self.contentView addSubview:_identifierLabel];
    [_identifierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageView.mas_right).offset(8);
        make.top.mas_offset(8);
        make.right.mas_offset(15);
        make.height.mas_offset(30);
    }];
    
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = UIFont13;
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_identifierLabel);
        make.top.equalTo(_identifierLabel.mas_bottom);
    }];
    
    
    
    _phoneNumberLabel = [[UILabel alloc] init];
    _phoneNumberLabel.font = UIFont13;
    [self.contentView addSubview:_phoneNumberLabel];
    [_phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom);
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
