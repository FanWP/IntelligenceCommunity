//
//  CommodityDetailTopViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommodityDetailTopViewCell.h"

@interface CommodityDetailTopViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end

@implementation CommodityDetailTopViewCell

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
    
    //展示图
//    @property(nonatomic,strong) UIImageView *advertiseImageView;
    _advertiseImageView = [[UIImageView alloc] init];
    _advertiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    _advertiseImageView.image = [UIImage imageNamed:@"3.jpg"];
    _advertiseImageView.clipsToBounds = YES;
    [self addSubview:_advertiseImageView];
    [_advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_offset(250);
    }];
    //名称
//    @property(nonatomic,strong) UIView *bottomView;
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor grayColor];
    _bottomView.alpha = .8f;
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(_advertiseImageView);
        make.height.mas_equalTo(40);
    }];
//    @property(nonatomic,strong) UILabel *commodityNameLabel;
    _commodityNameLabel = [[UILabel alloc] init];
    _commodityNameLabel.text = @"名称:商品详情--商品详情--商品详情--商品详情";
    _commodityNameLabel.textColor = [UIColor whiteColor];
    _commodityNameLabel.textAlignment = NSTextAlignmentLeft;
    _commodityNameLabel.font = UIFontLarge;
    [self addSubview:_commodityNameLabel];
    [_commodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(_bottomView);
        make.left.equalTo(_bottomView.mas_left).offset(20);
    }];
//    //价格
//    @property(nonatomic,strong) UILabel *commodityPriceLabel;
    _commodityPriceLabel = [[UILabel alloc] init];
    _commodityPriceLabel.text = @"￥666.66元";
    _commodityPriceLabel.textColor = [UIColor redColor];
    _commodityPriceLabel.textAlignment =  NSTextAlignmentLeft;
    _commodityPriceLabel.font = UIFontLargest;
    [self addSubview:_commodityPriceLabel];
    [_commodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_advertiseImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    
//加减按钮
    //    @property(nonatomic,strong) UIImageView *bottomImageView;
    _bottomImageView = [[UIImageView alloc] init];
    _bottomImageView.contentMode =  UIViewContentModeScaleAspectFill;
    _bottomImageView.image = [UIImage imageNamed:@"addAndDeleteBottomView"];
    [self addSubview:_bottomImageView];
    _bottomImageView.userInteractionEnabled = YES;
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_commodityPriceLabel.mas_centerY);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(90);
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
        make.centerY.mas_equalTo(_bottomImageView.mas_centerY);
        make.right.equalTo(_bottomImageView.mas_right).offset(0);
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
    [_deleteCommodityButton setTitle:@"-" forState:UIControlStateNormal];
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
    _lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.layer addSublayer:_lineLayer];
    
}
-(void)buttonAction:(UIButton *)button{
   
    if (_delegate && [_delegate respondsToSelector:@selector(commodityDetailTopViewCell:buttonWithTag:)]) {
        [_delegate commodityDetailTopViewCell:self buttonWithTag:button.tag];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _lineLayer.frame = CGRectMake(0, self.bounds.size.height - 10, self.bounds.size.width, 10);
    
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
