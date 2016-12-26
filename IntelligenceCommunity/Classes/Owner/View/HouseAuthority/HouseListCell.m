//
//  HouseListCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseListCell.h"

@implementation HouseListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self initializeComponent];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}

- (void)initializeComponent
{
    _houseNumberLabel = [[UILabel alloc] init];
    _houseNumberLabel.font = UIFontNormal;
    [self.contentView addSubview:_houseNumberLabel];
    [_houseNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_offset(16);
        make.height.mas_offset(30);
    }];
    
    
    _identifierLabel = [[UILabel alloc] init];
    _identifierLabel.font = UIFontNormal;
    [self.contentView addSubview:_identifierLabel];
    [_identifierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_houseNumberLabel);
        make.top.equalTo(_houseNumberLabel.mas_bottom);
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
