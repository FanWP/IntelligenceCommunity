//
//  ServiceListCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ServiceListCell.h"

@interface ServiceListCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation ServiceListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self initializeComponent];
    }
    return self;
}

-(void)initializeComponent{
    
    //闲置物品、社区服务、缴费、保修
    //闲置物品
//    @property(nonatomic,strong) UIImageView *freeArticleImageView;
//    @property(nonatomic,strong) UILabel *freeArticleLabel;
    _freeArticleImageView = [[UIImageView alloc] init];
    _freeArticleImageView.contentMode = UIViewContentModeCenter;
    _freeArticleImageView.image = [UIImage imageNamed:@"Ceremony"];
    [self addSubview:_freeArticleImageView];
    [_freeArticleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kGetVerticalDistance(30));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth/4);
        make.height.mas_equalTo(30);
    }];
    _freeArticleLabel = [[UILabel alloc] init];
    _freeArticleLabel.text = @"闲置物品";
    _freeArticleLabel.font = UIFontNormal;
    _freeArticleLabel.textColor = HexColor(0x818281);
    _freeArticleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_freeArticleLabel];
    [_freeArticleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_freeArticleImageView.mas_bottom).offset(kGetVerticalDistance(10));
        make.left.mas_equalTo(0);
        make.width.equalTo(_freeArticleImageView.mas_width);
        make.height.mas_equalTo(30);
    }];
    UIButton *freeArticleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    freeArticleButton.backgroundColor = [UIColor grayColor];
    freeArticleButton.tag = 1;
    [freeArticleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:freeArticleButton];
    [freeArticleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.width.mas_equalTo(_freeArticleImageView);
        make.bottom.equalTo(_freeArticleLabel.mas_bottom);
    }];
//    //社区服务
//    @property(nonatomic,strong) UIImageView *communityImageView;
//    @property(nonatomic,strong) UILabel *communityLabel;
    _communityImageView = [[UIImageView alloc] init];
    _communityImageView.contentMode = UIViewContentModeCenter;
    _communityImageView.image = [UIImage imageNamed:@"service"];
    [self addSubview:_communityImageView];
    [_communityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleImageView);
        make.left.equalTo(_freeArticleImageView.mas_right).offset(0);
    }];
    _communityLabel = [[UILabel alloc] init];
    _communityLabel.text = @"社区服务";
    _communityLabel.font = UIFontNormal;
    _communityLabel.textColor = HexColor(0x818281);
    _communityLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_communityLabel];
    [_communityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleLabel);
        make.left.equalTo(_freeArticleLabel.mas_right).offset(0);
    }];
    UIButton *communityButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    communityButton.backgroundColor = [UIColor grayColor];
    communityButton.tag = 2;
    [communityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:communityButton];
    [communityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(freeArticleButton);
        make.left.equalTo(freeArticleButton.mas_right).offset(0);
    }];
//    //缴费
//    @property(nonatomic,strong) UIImageView *payMoneyImageView;
//    @property(nonatomic,strong) UILabel *payMoneyLabel;
    _payMoneyImageView = [[UIImageView alloc] init];
    _payMoneyImageView.contentMode = UIViewContentModeCenter;
    _payMoneyImageView.image = [UIImage imageNamed:@"Expenses"];
    [self addSubview:_payMoneyImageView];
    [_payMoneyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleImageView);
        make.left.equalTo(_communityImageView.mas_right).offset(0);
    }];
    _payMoneyLabel = [[UILabel alloc] init];
    _payMoneyLabel.text = @"便民缴费";
    _payMoneyLabel.font = UIFontNormal;
    _payMoneyLabel.textColor = HexColor(0x818281);
    _payMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_payMoneyLabel];
    [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleLabel);
        make.left.equalTo(_communityLabel.mas_right).offset(0);
    }];
    UIButton *payMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    payMoneyButton.backgroundColor = [UIColor grayColor];
    payMoneyButton.tag = 3;
    [payMoneyButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:payMoneyButton];
    [payMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(freeArticleButton);
        make.left.equalTo(communityButton.mas_right).offset(0);
    }];
//    //报修
//    @property(nonatomic,strong) UIImageView *repairsImageView;
//    @property(nonatomic,strong) UILabel *repairsLabel;
    _repairsImageView = [[UIImageView alloc] init];
    _repairsImageView.contentMode = UIViewContentModeCenter;
    _repairsImageView.image = [UIImage imageNamed:@"Reporter"];
    [self addSubview:_repairsImageView];
    [_repairsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleImageView);
        make.left.equalTo(_payMoneyImageView.mas_right).offset(0);
    }];
    
    _repairsLabel = [[UILabel alloc] init];
    _repairsLabel.text = @"事故报修";
    _repairsLabel.font = UIFontNormal;
    _repairsLabel.textColor = HexColor(0x818281);
    _repairsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_repairsLabel];
    [_repairsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleLabel);
        make.left.equalTo(_payMoneyLabel.mas_right).offset(0);
    }];
    UIButton *repairsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    repairsButton.tag = 4;
//    repairsButton.backgroundColor = [UIColor grayColor];
    [repairsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:repairsButton];
    [repairsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(freeArticleButton);
        make.left.equalTo(payMoneyButton.mas_right).offset(0);
    }];
    
    
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView.layer addSublayer:_lineLayer];
}
-(void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(serviceListCell:buttonWithTag:)]) {
        [_delegate serviceListCell:self buttonWithTag:button.tag];
    }
    
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
