//
//  ShoppingCartBottomView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ShoppingCartBottomView.h"


@implementation ShoppingCartBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeComponent];
        self.backgroundColor = HexColor(0xffffff);
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    //购物车按钮
//    @property(nonatomic,strong) UIButton *shoppingCartButton;
    _shoppingCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shoppingCartButton setImage:[UIImage imageNamed:@"Shopping Cart"] forState:UIControlStateNormal];
    [self addSubview:_shoppingCartButton];
    [_shoppingCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(weakSelf.mas_centerY);
//        make.left.mas_equalTo(20);
//        make.width.height.mas_equalTo(self.bounds.size.height);
        make.left.mas_offset(20);
        make.bottom.mas_offset(-9);
        make.width.height.mas_offset(kGetHorizontalDistance(106));
    }];
//    //商品数量
//    @property(nonatomic,strong) UILabel *commodityCountLabel;
    _commodityCountLabel = [[UILabel alloc] init];
    _commodityCountLabel.text = @"0";
    _commodityCountLabel.textColor = [UIColor whiteColor];
    _commodityCountLabel.textAlignment = NSTextAlignmentCenter;
    _commodityCountLabel.font = UIFontSmall;
    _commodityCountLabel.backgroundColor = HexColor(0x0dceac);
    _commodityCountLabel.layer.masksToBounds = YES;
    _commodityCountLabel.layer.cornerRadius = 8;
    [self addSubview:_commodityCountLabel];
    [_commodityCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shoppingCartButton.mas_top).offset(0);
        make.right.equalTo(_shoppingCartButton.mas_right).offset(0);
        make.width.height.mas_equalTo(16);
    }];
//    //总价
//    @property(nonatomic,strong) UILabel *commodityTotalPriceLabel;
    _commodityTotalPriceLabel = [[UILabel alloc] init];
    _commodityTotalPriceLabel.text = @"￥0.00";
    _commodityTotalPriceLabel.textColor = HexColor(0xe1390b);
    _commodityTotalPriceLabel.textAlignment = NSTextAlignmentLeft;
    _commodityTotalPriceLabel.font = UIFontLargest;
    [self addSubview:_commodityTotalPriceLabel];
    [_commodityTotalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_shoppingCartButton.mas_right).offset(kGetHorizontalDistance(64));
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
//    //去结算
//    @property(nonatomic,strong) UIButton *goSettlementButton;
    _goSettlementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goSettlementButton setTitle:@"立即购买" forState:UIControlStateNormal];
    _goSettlementButton.backgroundColor = HexColor(0xfe9913);
    
    [self addSubview:_goSettlementButton];
    [_goSettlementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kGetHorizontalDistance(244));
    }];
    
    
}
- (void)setNumber:(UILabel *)number{
    
    CGSize size = [_commodityCountLabel.text boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_commodityCountLabel.font} context:nil].size;
    CGRect rect = _commodityCountLabel.frame;
    if (size.width >rect.size.width) {
        rect.size.width = size.width+6;
    }
    _commodityCountLabel.frame = rect;
}
@end
