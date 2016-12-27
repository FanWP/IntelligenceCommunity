//
//  CommodityDetailBottomViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommodityDetailBottomViewCell.h"

@interface CommodityDetailBottomViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;


@end
@implementation CommodityDetailBottomViewCell

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
    
    //商品简介
//    @property(nonatomic,strong) UILabel *titleLabel;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"商品简介";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = UIFontLarge;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(kGetHorizontalDistance(32));
        make.right.mas_offset(0);
        make.height.mas_equalTo(kGetVerticalDistance(44));
    }];
//    //图片
//    @property(nonatomic,strong) UIImageView *advertiseImageView;
    _advertiseImageView = [[UIImageView alloc] init];
    _advertiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    _advertiseImageView.clipsToBounds = YES;
    _advertiseImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_advertiseImageView];
    [_advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.left.mas_offset(kGetHorizontalDistance(40));
        make.right.mas_offset(-kGetHorizontalDistance(40));
        make.height.mas_offset(kGetVerticalDistance(380));
    }];
//    //商品详情
//    @property(nonatomic,strong) UILabel *commodityDetailLabel;
    _commodityDetailLabel = [[UILabel alloc] init];
    _commodityDetailLabel.text = @"商品详情";
    _commodityDetailLabel.textColor = [UIColor grayColor];
    _commodityDetailLabel.textAlignment = NSTextAlignmentLeft;
    _commodityDetailLabel.font = UIFontNormal;
    _commodityDetailLabel.numberOfLines = 0;
    [_commodityDetailLabel sizeToFit];
    [self addSubview:_commodityDetailLabel];
    [_commodityDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_advertiseImageView.mas_bottom).offset(kGetVerticalDistance(26));
        make.left.mas_offset(kGetHorizontalDistance(56));
        make.right.mas_offset(-kGetHorizontalDistance(56));
        make.bottom.mas_offset(0);
    }];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
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
