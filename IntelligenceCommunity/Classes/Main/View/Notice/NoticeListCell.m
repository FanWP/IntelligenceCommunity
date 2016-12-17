//
//  NoticeListCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NoticeListCell.h"

@implementation NoticeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self initializeComponent];
    }
    
    return self;
}

- (void)initializeComponent
{
    // 标题
    _noticeListTitleLabel = [[UILabel alloc] init];
    _noticeListTitleLabel.font = UIFontNormal;
    _noticeListTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_noticeListTitleLabel];
    [_noticeListTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(5);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
    }];
    
    
    // 内容
    _noticeListContentLabel = [[UILabel alloc] init];
    _noticeListContentLabel.font = UIFontSmall;
    _noticeListContentLabel.textColor = [UIColor grayColor];
    _noticeListContentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_noticeListContentLabel];
    [_noticeListContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_noticeListTitleLabel.mas_left);
        make.top.equalTo(_noticeListTitleLabel.mas_bottom);
        make.right.equalTo(_noticeListTitleLabel.mas_right);
        make.height.equalTo(_noticeListTitleLabel.mas_height);
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
