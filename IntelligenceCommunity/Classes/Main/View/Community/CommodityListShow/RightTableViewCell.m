//
//  RightTableViewCell.m
//  CommodityListTableView
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RightTableViewCell.h"

@interface RightTableViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end

@implementation RightTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    //商品图片
//    @property(nonatomic,strong) UIImageView *commodityImageView;
    _commodityImageView = [[UIImageView alloc] init];
    _commodityImageView.contentMode = UIViewContentModeScaleAspectFill;
    _commodityImageView.clipsToBounds = YES;
    _commodityImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_commodityImageView];
    [_commodityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.centerY).offset(0);
        make.left.mas_equalTo(kGetHorizontalDistance(36));
        make.width.height.mas_equalTo(kGetVerticalDistance(128));
    }];
//    //商品名字
//    @property(nonatomic,strong) UILabel *commodityNameLabel;
    _commodityNameLabel = [[UILabel alloc] init];
    _commodityNameLabel.text = @"商品名称";
    _commodityNameLabel.textColor = HexColor(0x2f2f2f);
    _commodityNameLabel.textAlignment = NSTextAlignmentLeft;
    _commodityNameLabel.font = UIFontLarge;
    _commodityPriceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:_commodityNameLabel];
    [_commodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kGetVerticalDistance(30));
        make.left.equalTo(_commodityImageView.mas_right).offset(kGetHorizontalDistance(18));
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
//    //商品价格
//    @property(nonatomic,strong) UILabel *commodityPriceLabel;
    _commodityPriceLabel = [[UILabel alloc] init];
    _commodityPriceLabel.text = @"￥00.00";
    _commodityPriceLabel.textColor = HexColor(0xfba152);
    _commodityPriceLabel.textAlignment = NSTextAlignmentLeft;
    _commodityPriceLabel.font = UIFontNormal;
    [self addSubview:_commodityPriceLabel];
    [_commodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commodityNameLabel.mas_bottom).offset(kGetVerticalDistance(16));
        make.left.equalTo(_commodityNameLabel.mas_left).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
//    //➕
//    @property(nonatomic,strong) UIButton *addCommodityButton;
    _addCommodityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addCommodityButton setImage:[UIImage imageNamed:@"addCommodity"] forState:UIControlStateNormal];
    [_addCommodityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _addCommodityButton.tag = 1;
    [self addSubview:_addCommodityButton];
    [_addCommodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-kGetVerticalDistance(0));
        make.right.mas_offset(-kGetHorizontalDistance(26));
        make.width.height.mas_equalTo(30);
    }];
//    //商品数量
//    @property(nonatomic,strong) UILabel *commodityCountLabel;
    _commodityCountLabel = [[UILabel alloc] init];
    _commodityCountLabel.text = @"0";
    _commodityCountLabel.textColor = [UIColor blackColor];
    _commodityCountLabel.textAlignment = NSTextAlignmentCenter;
    _commodityCountLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_commodityCountLabel];
    [_commodityCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_addCommodityButton.mas_centerY);
        make.right.equalTo(_addCommodityButton.mas_left).offset(0);
        make.width.height.equalTo(_addCommodityButton);
    }];
//    //减
//    @property(nonatomic,strong) UIButton *deleteCommodityButton;
    _deleteCommodityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteCommodityButton setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
    [_deleteCommodityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _deleteCommodityButton.tag = 2;
    [_deleteCommodityButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self addSubview:_deleteCommodityButton];
    [_deleteCommodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_addCommodityButton.mas_centerY);
        make.right.equalTo(_commodityCountLabel.mas_left).offset(0);
        make.width.height.equalTo(_addCommodityButton);
    }];

    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = HexColor(0xe5e5e5).CGColor;
    [self.contentView.layer addSublayer:_lineLayer];
    
}
-(void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewCell:buttonWithTag:)]) {
        [_delegate tableViewCell:self buttonWithTag:button.tag];
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    _lineLayer.frame = CGRectMake(0, self.height-1, self.width, 1);
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
