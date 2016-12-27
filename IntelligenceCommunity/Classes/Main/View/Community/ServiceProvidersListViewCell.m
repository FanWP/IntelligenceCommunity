//
//  ServiceProvidersListViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ServiceProvidersListViewCell.h"

@interface ServiceProvidersListViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation ServiceProvidersListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    //商家展示图片
//    @property(nonatomic,strong) UIImageView *advertiseImageView;
    _advertiseImageView = [[UIImageView alloc] init];
    _advertiseImageView.contentMode = UIViewContentModeCenter;
    _advertiseImageView.clipsToBounds = YES;
    _advertiseImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_advertiseImageView];
    [_advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(kGetHorizontalDistance(30));
        make.width.mas_offset(kGetHorizontalDistance(150));
        make.height.mas_offset(kGetVerticalDistance(140));
    }];
//    //店名
//    @property(nonatomic,strong) UILabel *storeNameLabel;
    _storeNameLabel = [[UILabel alloc] init];
    _storeNameLabel.text = @"店铺名称";
    _storeNameLabel.textColor = HexColor(0x484747);
    _storeNameLabel.textAlignment = NSTextAlignmentLeft;
    _storeNameLabel.font = UIFontLarge;
    [self addSubview:_storeNameLabel];
    [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_advertiseImageView.mas_top).offset(0);
        make.left.equalTo(_advertiseImageView.mas_right).offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
//    //营业时间
//    @property(nonatomic,strong) UILabel *businessHoursLabel;
    _businessHoursLabel = [[UILabel alloc] init];
    _businessHoursLabel.text = @"营业时间00:00~00:00";
    _businessHoursLabel.textColor = HexColor(0x656464);
    _businessHoursLabel.textAlignment = NSTextAlignmentLeft;
    _businessHoursLabel.font = UIFontSmall;
    [self addSubview:_businessHoursLabel];
    [_businessHoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_advertiseImageView.mas_centerY);
        make.left.mas_equalTo(_storeNameLabel);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
//    //签名
//    @property(nonatomic,strong) UILabel *signatureLabel;
    _signatureLabel = [[UILabel alloc] init];
    _signatureLabel.text = @"签名";
    _signatureLabel.textColor = HexColor(0x696969);
    _signatureLabel.textAlignment = NSTextAlignmentLeft;
    _signatureLabel.font = UIFontNormal;
    [self addSubview:_signatureLabel];
    [_signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_storeNameLabel);
        make.bottom.equalTo(_advertiseImageView.mas_bottom).offset(0);
        make.width.mas_offset(200);
        make.height.mas_equalTo(30);
    }];
    //综合评分
//    @property(nonatomic,strong) UILabel *scoreCountLabel;
    _scoreCountLabel = [[UILabel alloc] init];
    _scoreCountLabel.text = @"综合评分:0.0";
    _scoreCountLabel.textColor = HexColor(0x0dcdac);
    _scoreCountLabel.textAlignment = NSTextAlignmentRight;
    _scoreCountLabel.font = UIFontLarge;
    [self.contentView addSubview:_scoreCountLabel];
    [_scoreCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_storeNameLabel.mas_centerY).offset(0);
        make.right.mas_equalTo(-kGetHorizontalDistance(30));
        make.left.equalTo(_storeNameLabel.mas_right).offset(0);
        make.height.mas_equalTo(30);
    }];
    
//    //月销量
//    @property(nonatomic,strong) UILabel *monthSaleCountLabel;
    _monthSaleCountLabel = [[UILabel alloc] init];
    _monthSaleCountLabel.text = @"月销量:  0单";
    _monthSaleCountLabel.textColor = HexColor(0x484747);
    _monthSaleCountLabel.textAlignment = NSTextAlignmentRight;
    _monthSaleCountLabel.font = UIFontNormal;
    [self addSubview:_monthSaleCountLabel];
    [_monthSaleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_signatureLabel.mas_centerY).offset(0);
        make.right.mas_equalTo(-10);
        make.left.equalTo(_signatureLabel.mas_right).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView.layer addSublayer:_lineLayer];
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
