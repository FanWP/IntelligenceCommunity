//
//  HelpCenterViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/1.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HelpCenterViewCell.h"

@implementation HelpCenterViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"帮助中心";
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = UIFontNormal;
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-20);
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
