//
//  PropertyFeeBillingDetailViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeBillingDetailViewCell.h"

@interface PropertyFeeBillingDetailViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation PropertyFeeBillingDetailViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
//    @property(nonatomic,strong) UILabel *titleLabel;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = HexColor(0x242424);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = UIFontNormal;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(kGetHorizontalDistance(30));
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
//    @property(nonatomic,strong) UILabel *detailLabel;
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.textColor = HexColor(0x242424);
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.font = UIFontNormal;
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleLabel.mas_centerY);
        make.left.equalTo(_titleLabel.mas_right).offset(kGetHorizontalDistance(64));
        make.right.mas_equalTo(-20);
    }];
    
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = [UIColor grayColor].CGColor;
//    [self.contentView.layer addSublayer:_lineLayer];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    _lineLayer.frame = CGRectMake(0, self.height-1, ScreenWidth, 1);
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
