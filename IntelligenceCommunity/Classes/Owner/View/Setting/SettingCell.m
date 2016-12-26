//
//  SettingCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/20.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

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
    _settingTitleLabel = [[UILabel alloc] init];
    _settingTitleLabel.textColor = [UIColor blackColor];
    _settingTitleLabel.textAlignment = NSTextAlignmentLeft;
    _settingTitleLabel.font = UIFontNormal;
    [self.contentView addSubview:_settingTitleLabel];
    [_settingTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.offset(80);
        make.height.offset(30);
    }];
    
    
    _settingContentTF = [[UITextField alloc] init];
//    _settingContentTF.textColor = [UIColor grayColor];
//    _settingContentTF.borderStyle = UITextBorderStyleRoundedRect;
//    _settingContentTF.backgroundColor = [UIColor grayColor];
    _settingContentTF.textAlignment = NSTextAlignmentRight;
    _settingContentTF.font = UIFontNormal;
    [self.contentView addSubview:_settingContentTF];
    [_settingContentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_settingTitleLabel.mas_right);
        make.right.mas_offset(-15);
        make.centerY.equalTo(_settingTitleLabel.mas_centerY);
        make.height.equalTo(_settingTitleLabel.mas_height);
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
