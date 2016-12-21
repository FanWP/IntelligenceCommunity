//
//  SettingHeaderPictureCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/20.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SettingHeaderPictureCell.h"


@implementation SettingHeaderPictureCell


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
    _settingHeaderLabel = [[UILabel alloc] init];
    _settingHeaderLabel.textColor = [UIColor blackColor];
    _settingHeaderLabel.textAlignment = NSTextAlignmentLeft;
    _settingHeaderLabel.font = UIFontNormal;
    [self.contentView addSubview:_settingHeaderLabel];
    [_settingHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(5);
        make.width.offset(80);
        make.height.offset(30);
    }];
    
    
    _settingHeaderImageView = [[UIImageView alloc] init];
    _settingHeaderImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_settingHeaderImageView];
    [_settingHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_settingHeaderLabel.mas_right);
        make.right.mas_offset(-15);
        make.top.equalTo(_settingHeaderLabel.mas_top);
        make.centerY.equalTo(_settingHeaderLabel.mas_centerY);
        make.height.equalTo(_settingHeaderLabel.mas_height);
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
