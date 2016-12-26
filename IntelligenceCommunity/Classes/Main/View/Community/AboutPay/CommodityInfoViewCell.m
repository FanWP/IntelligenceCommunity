//
//  CommodityInfoViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommodityInfoViewCell.h"

@interface CommodityInfoViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end

@implementation CommodityInfoViewCell

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
    
//    @property(nonatomic,strong) UIButton *selectButton;
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectButton.selected = YES;
    [_selectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
    [_selectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectButton];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_offset(0);
        make.width.mas_offset(60);
    }];
//    //商品图片
//    @property(nonatomic,strong) UIImageView *commodityImageView;
    _commodityImageView = [[UIImageView alloc] init];
    _commodityImageView.contentMode = UIViewContentModeScaleAspectFill;
    _commodityImageView.clipsToBounds = YES;
    _commodityImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self.contentView addSubview:_commodityImageView];
    [_commodityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectButton.mas_centerY);
        make.left.mas_equalTo(_selectButton.mas_right).offset(5);
        make.width.height.mas_offset(60);
    }];
//    //商品名称
//    @property(nonatomic,strong) UILabel *commodityNameLabel;
    _commodityNameLabel = [[UILabel alloc] init];
    _commodityNameLabel.text = @"商品名称";
    _commodityNameLabel.textColor = [UIColor blackColor];
    _commodityNameLabel.textAlignment = NSTextAlignmentLeft;
    _commodityNameLabel.font = UIFontNormal;
    [self.contentView addSubview:_commodityNameLabel];
    [_commodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commodityImageView.mas_top).offset(0);
        make.left.equalTo(_commodityImageView.mas_right).offset(5);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
//    //商品价格
//    @property(nonatomic,strong) UILabel *commodityPriceLabel;
    _commodityPriceLabel = [[UILabel alloc] init];
    _commodityPriceLabel.text = @"￥ 120.00";
    _commodityPriceLabel.textColor = [UIColor grayColor];
    _commodityPriceLabel.textAlignment = NSTextAlignmentRight;
    _commodityPriceLabel.font = UIFontNormal;
    [self.contentView addSubview:_commodityPriceLabel];
    [_commodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_commodityNameLabel.mas_centerY);
        make.right.mas_offset(-10);
        make.width.mas_offset(100);
        make.height.mas_offset(30);

    }];
//    //商品描述
//    @property(nonatomic,strong) UILabel *commodityDescriptionLabel;
    _commodityDescriptionLabel = [[UILabel alloc] init];
    _commodityDescriptionLabel.text = @"服务便民";
    _commodityDescriptionLabel.textColor = [UIColor grayColor];
    _commodityDescriptionLabel.textAlignment = NSTextAlignmentLeft;
    _commodityDescriptionLabel.font = UIFontNormal;
    [self.contentView addSubview:_commodityDescriptionLabel];
    [_commodityDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_commodityNameLabel);
        make.bottom.mas_equalTo(_commodityImageView.mas_bottom);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
//    //商品数量
//    @property(nonatomic,strong) UILabel *commodityCountLabel;
    _commodityCountLabel = [[UILabel alloc] init];
    _commodityCountLabel.text = @"数量: X1";
    _commodityCountLabel.textColor = [UIColor grayColor];
    _commodityCountLabel.textAlignment = NSTextAlignmentRight;
    _commodityCountLabel.font = UIFontNormal;
    [self.contentView addSubview:_commodityCountLabel];
    [_commodityCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_commodityDescriptionLabel.mas_centerY);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.layer addSublayer:_lineLayer];
}
-(void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(commodityInfoViewCell:withButton:)]) {
        [_delegate commodityInfoViewCell:self withButton:_selectButton];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _lineLayer.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
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
