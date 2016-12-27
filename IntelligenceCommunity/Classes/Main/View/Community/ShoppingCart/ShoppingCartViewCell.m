//
//  ShoppingCartViewCell.m
//  CommodityListTableView
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ShoppingCartViewCell.h"

@implementation ShoppingCartViewCell

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
    
    //商品名字
//    @property(nonatomic,strong) UILabel *commodityNameLabel;
    _commodityNameLabel = [[UILabel alloc] init];
    _commodityNameLabel.text = @"商品名称";
    _commodityNameLabel.textColor = [UIColor grayColor];
    _commodityNameLabel.textAlignment = NSTextAlignmentLeft;
    _commodityNameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_commodityNameLabel];
    [_commodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
//    //商品价格
//    @property(nonatomic,strong) UILabel *commodityPriceLabel;
    _commodityPriceLabel = [[UILabel alloc] init];
    _commodityPriceLabel.text = @"￥25.00元";
    _commodityPriceLabel.textColor = [UIColor grayColor];
    _commodityPriceLabel.textAlignment = NSTextAlignmentLeft;
    _commodityPriceLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_commodityPriceLabel];
    [_commodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_commodityNameLabel.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(_commodityNameLabel);
    }];
//    //商品单位:  /件   /个
//    @property(nonatomic,strong) UILabel *commodityTypeLabel;
    
    _commodityTypeLabel = [[UILabel alloc] init];
    _commodityTypeLabel.text = @"/件";
    _commodityTypeLabel.textColor = [UIColor grayColor];
    _commodityTypeLabel.textAlignment = NSTextAlignmentLeft;
    _commodityTypeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_commodityTypeLabel];
    [_commodityTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_commodityNameLabel.mas_centerY);
        make.left.equalTo(_commodityPriceLabel.mas_right).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(_commodityPriceLabel);
    }];
    //    //➕
    //    @property(nonatomic,strong) UIButton *addCommodityButton;
    _addCommodityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addCommodityButton setImage:[UIImage imageNamed:@"addCommodity"] forState:UIControlStateNormal];
    [_addCommodityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _addCommodityButton.tag = 1;
    [self addSubview:_addCommodityButton];
    [_addCommodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.right.mas_offset(-10);
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
}
-(void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(shoppingCartViewCell:buttonWithTag:)]) {
        [_delegate shoppingCartViewCell:self buttonWithTag:button.tag];
    }
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
