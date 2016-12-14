//
//  PropertyFeeHistoryViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeHistoryViewCell.h"

@implementation PropertyFeeHistoryViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    
//    //缴费时间
//    @property(nonatomic,strong) UILabel *timeLabel;
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"缴费时间";
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = UIFontNormal;
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_offset(150);
        make.height.mas_offset(30);
    }];
//    //图标
//    @property(nonatomic,strong) UIImageView *historyImageView;
    _historyImageView = [[UIImageView alloc] init];
    _historyImageView.contentMode = UIViewContentModeScaleAspectFill;
    _historyImageView.clipsToBounds = YES;
    _historyImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_historyImageView];
    [_historyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_timeLabel.mas_centerY);
        make.left.equalTo(_timeLabel.mas_right).offset(20);
        make.width.height.mas_equalTo(30);
    }];
//    //钱数
//    @property(nonatomic,strong) UILabel *priceCountLabel;
    _priceCountLabel = [[UILabel alloc] init];
    _priceCountLabel.text = @"￥109.00";
    _priceCountLabel.textColor = [UIColor grayColor];
    _priceCountLabel.textAlignment = NSTextAlignmentLeft;
    _priceCountLabel.font = UIFontNormal;
    [self addSubview:_priceCountLabel];
    [_priceCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.equalTo(_historyImageView.mas_right).offset(30);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
//    //费用类型
//    @property(nonatomic,strong) UILabel *priceTypeLabel;
    _priceTypeLabel = [[UILabel alloc] init];
    _priceTypeLabel.text = @"费用类型";
    _priceTypeLabel.textColor = [UIColor grayColor];
    _priceTypeLabel.textAlignment = NSTextAlignmentLeft;
    _priceTypeLabel.font = UIFontNormal;
    [self addSubview:_priceTypeLabel];
    [_priceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceCountLabel.mas_bottom).offset(5);
        make.left.equalTo(_priceCountLabel.mas_left).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
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
