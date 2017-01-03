//
//  MyOrdersProductsCell.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/26.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MyOrdersProductsCell.h"

@implementation MyOrdersProductsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self initializeComponent];
    }
    
    return self;
}


- (void)initializeComponent
{
    // 商品图片 productImageView;
    _productImageView = [[UIImageView alloc] init];
//    _productImageView.backgroundColor = [UIColor orangeColor];
    _productImageView.image = [UIImage imageNamed:@"2"];
    [self.contentView addSubview:_productImageView];
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.top.mas_offset(12);
        make.height.mas_offset(85);
        make.width.mas_offset(40);
    }];
    
    // 标题 titleLabel;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = UIFontSmall;
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productImageView.mas_right).offset(12);
        make.top.mas_offset(10);
        make.right.mas_offset(-12);
        make.height.mas_offset(25);
    }];
    
    // 详情 detailLabel;
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.font = UIFont11;
    _detailLabel.textColor = HexColor(0x3d3c3c);
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.right.mas_offset(-16 - 20 - 12);
        make.height.mas_offset(50);
    }];
    
    // 价格 priceLabel;
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = UIFontNormal;
    _priceLabel.textColor = HexColor(0xf18f52);
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.width.mas_offset(10);
        make.top.equalTo(_detailLabel.mas_bottom);
        make.height.equalTo(_titleLabel.mas_height);
    }];
    
    // 数量 countLabel;
    _countLabel = [[UILabel alloc] init];
    _countLabel.font = UIFontSmall;
    _countLabel.textColor = HexColor(0x8a8a8a);
    [self.contentView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel.mas_right);
        make.width.mas_offset(30);
        make.top.equalTo(_priceLabel.mas_top);
        make.height.equalTo(_titleLabel.mas_height);
    }];
    
//    _titleLabel.backgroundColor = [UIColor redColor];
//    _detailLabel.backgroundColor = [UIColor cyanColor];
//    _priceLabel.backgroundColor = [UIColor redColor];
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
