//
//  CostListViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CostListViewCell.h"

@interface CostListViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation CostListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
        self.backgroundColor = HexColor(0xffffff);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(weakSelf.centerY).offset(0);
        make.left.mas_equalTo(kGetHorizontalDistance(30));
        make.width.mas_equalTo(30);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = HexColor(0x5e5e5e);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = UIFontSmall;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_leftImageView.mas_centerY).offset(0);
        make.left.mas_offset(kGetHorizontalDistance(90));
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = HexColor(0xdddddd).CGColor;
    [self.contentView.layer addSublayer:_lineLayer];
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
