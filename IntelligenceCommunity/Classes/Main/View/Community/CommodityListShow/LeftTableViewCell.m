//
//  LeftTableViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "LeftTableViewCell.h"

@interface LeftTableViewCell ()



@end

@implementation LeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"分类名";;
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.highlightedTextColor = [UIColor redColor];
    _titleLabel.font = UIFontLarge;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(5);
        make.height.mas_equalTo(30);
    }];
    
    _remarkView = [[UIView alloc] init];
    [self.contentView addSubview:_remarkView];
    [_remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(5);
    }];
    self.remarkView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.remarkView];

}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.highlighted = selected;
    self.titleLabel.highlighted = selected;
    self.remarkView.backgroundColor = selected ? [UIColor redColor] : [UIColor whiteColor];
}

@end
