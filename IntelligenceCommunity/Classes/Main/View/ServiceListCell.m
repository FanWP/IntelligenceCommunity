//
//  ServiceListCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ServiceListCell.h"

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
    _freeArticleImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_freeArticleImageView];
    [_freeArticleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth/4);
        make.height.mas_equalTo(30);
    }];
    _freeArticleLabel = [[UILabel alloc] init];
    _freeArticleLabel.text = @"闲置物品";
    _freeArticleLabel.font = UIFontNormal;
    _freeArticleLabel.textColor = [UIColor grayColor];
    _freeArticleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_freeArticleLabel];
    [_freeArticleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_freeArticleImageView.mas_bottom).offset(0);
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
    _communityImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_communityImageView];
    [_communityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleImageView);
        make.left.equalTo(_freeArticleImageView.mas_right).offset(0);
    }];
    _communityLabel = [[UILabel alloc] init];
    _communityLabel.text = @"社区服务";
    _communityLabel.font = UIFontNormal;
    _communityLabel.textColor = [UIColor grayColor];
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
    _payMoneyImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_payMoneyImageView];
    [_payMoneyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleImageView);
        make.left.equalTo(_communityImageView.mas_right).offset(0);
    }];
    _payMoneyLabel = [[UILabel alloc] init];
    _payMoneyLabel.text = @"缴费";
    _payMoneyLabel.font = UIFontNormal;
    _payMoneyLabel.textColor = [UIColor grayColor];
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
    _repairsImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_repairsImageView];
    [_repairsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_freeArticleImageView);
        make.left.equalTo(_payMoneyImageView.mas_right).offset(0);
    }];
    
    _repairsLabel = [[UILabel alloc] init];
    _repairsLabel.text = @"保修";
    _repairsLabel.font = UIFontNormal;
    _repairsLabel.textColor = [UIColor grayColor];
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
    
    //地图宣传图
//    @property(nonatomic,strong) UIImageView *advertiseImageView;
    _advertiseImageView = [[UIImageView alloc] init];
    _advertiseImageView.contentMode = UIViewContentModeScaleToFill;
    _advertiseImageView.image = [UIImage imageNamed:@"1.jpg"];
    [self addSubview:_advertiseImageView];
    [_advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_freeArticleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    //    @property(nonatomic,strong) UILabel *advertiseContentLabel;
    _advertiseContentLabel = [[UILabel alloc] init];
    _advertiseContentLabel.text = @"新鲜牛奶到家";
    _advertiseContentLabel.textAlignment = NSTextAlignmentCenter;
    _advertiseContentLabel.textColor = [UIColor grayColor];
    _advertiseContentLabel.font = UIFontNormal;
    [self addSubview:_advertiseContentLabel];
    [_advertiseContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_advertiseImageView.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
    }];
    //    @property(nonatomic,strong) UILabel *timeLabel;
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"2016-11-1";
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = UIFontNormal;
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_advertiseContentLabel.mas_top);
        make.right.mas_equalTo(10);
        make.width.mas_equalTo(100);
    }];
}
-(void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(serviceListCell:buttonWithTag:)]) {
        [_delegate serviceListCell:self buttonWithTag:button.tag];
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
