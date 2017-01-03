//
//  ServiceTimeSelectViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ServiceTimeSelectViewCell.h"

@implementation ServiceTimeSelectViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initializeComponent];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
-(void)initializeComponent{
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"上门服务时间";
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = UIFontNormal;
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.left.mas_offset(20);
    }];
    _selectResultTimeLabel = [[UILabel alloc] init];
    _selectResultTimeLabel.text = @"请选择服务时间";
    _selectResultTimeLabel.textColor = [UIColor grayColor];
    _selectResultTimeLabel.textAlignment = NSTextAlignmentRight;
    _selectResultTimeLabel.font = UIFontNormal;
    [self.contentView addSubview:_selectResultTimeLabel];
    [_selectResultTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.centerY.mas_equalTo(_timeLabel.centerY).offset(0);
        
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
