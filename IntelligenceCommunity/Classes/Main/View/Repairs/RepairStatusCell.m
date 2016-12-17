//
//  RepairStatusCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/16.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RepairStatusCell.h"

@implementation RepairStatusCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self initializeComponent];
    }
    
    return self;
}



// 初始化
- (void)initializeComponent
{
    // 报修的状态
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = UIFontNormal;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(5);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
    }];
    
    
    
    // 报修的时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = UIFontSmall;
    _timeLabel.textColor = HexColor(0x626262);
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-5);
        make.left.mas_offset(15);
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
