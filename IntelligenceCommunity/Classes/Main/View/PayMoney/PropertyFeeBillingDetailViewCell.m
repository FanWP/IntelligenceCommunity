//
//  PropertyFeeBillingDetailViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeBillingDetailViewCell.h"

@implementation PropertyFeeBillingDetailViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
//    @property(nonatomic,strong) UILabel *titleLabel;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"标题";
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = UIFontNormal;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
//    @property(nonatomic,strong) UILabel *detailLabel;
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.text = @"详情";
    _detailLabel.textColor = [UIColor grayColor];
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.font = UIFontNormal;
    [self addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleLabel.mas_centerY);
        make.left.equalTo(_titleLabel.mas_right).offset(30);
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
