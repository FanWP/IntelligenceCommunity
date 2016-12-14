//
//  DeterminePayBottomView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "DeterminePayBottomView.h"

@implementation DeterminePayBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeComponent];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    //全选
//    @property(nonatomic,strong) UIButton *selectAllCommodityButton;
//    @property(nonatomic,strong) UILabel *selectAllLabel;
    _selectAllCommodityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectAllCommodityButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
    [_selectAllCommodityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectAllCommodityButton];
    [_selectAllCommodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_offset(10);
        make.width.height.mas_offset(50);
    }];
    _selectAllLabel = [[UILabel alloc] init];
    _selectAllLabel.text = @"全选";
    _selectAllLabel.textColor = [UIColor grayColor];
    _selectAllLabel.textAlignment = NSTextAlignmentLeft;
    _selectAllLabel.font = UIFontNormal;
    [self addSubview:_selectAllLabel];
    [_selectAllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectAllCommodityButton.mas_centerY);
        make.left.equalTo(_selectAllCommodityButton.mas_right).offset(0);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
    }];
    //总价
//    @property(nonatomic,strong) UILabel *commodityTotalPriceLabel;
    _commodityTotalPriceLabel = [[UILabel alloc] init];
    _commodityTotalPriceLabel.text = @"合计金额: ￥00.00";
    _commodityTotalPriceLabel.textColor = [UIColor grayColor];
    _commodityTotalPriceLabel.textAlignment = NSTextAlignmentLeft;
    _commodityTotalPriceLabel.font = UIFontNormal;
    [self addSubview:_commodityTotalPriceLabel];
    [_commodityTotalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectAllCommodityButton.mas_centerY);
        make.left.equalTo(_selectAllLabel.mas_right).offset(0);
        make.width.mas_offset(150);
        make.height.mas_offset(30);
    }];
    
    //去结算
//    @property(nonatomic,strong) UIButton *commitOrderButton;
    _commitOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commitOrderButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [_commitOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitOrderButton setBackgroundColor:[UIColor purpleColor]];
    [_commitOrderButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commitOrderButton];
    [_commitOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_offset(0);
        make.width.mas_offset(100);
    }];
    
}
-(void)buttonAction:(UIButton *)button{
    
    
}

@end
