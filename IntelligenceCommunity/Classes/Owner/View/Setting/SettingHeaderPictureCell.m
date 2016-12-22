//
//  SettingHeaderPictureCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/22.
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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.offset(80);
        make.height.offset(30);
    }];
    
    
    _settingHeaderImageView = [[UIImageView alloc] init];
    _settingHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    _settingHeaderImageView.layer.cornerRadius = 60 / 2;
    _settingHeaderImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_settingHeaderImageView];
    [_settingHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_offset(60);
        make.height.mas_offset(60);
        make.centerY.equalTo(_settingHeaderLabel.mas_centerY);
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
