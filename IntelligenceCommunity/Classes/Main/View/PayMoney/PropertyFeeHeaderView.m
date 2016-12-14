//
//  PropertyFeeHeaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeHeaderView.h"

@interface PropertyFeeHeaderView ()

@property(nonatomic,strong) UIImageView *shadowImageView;
@property(nonatomic,strong) CALayer *lineLayer;


@end

@implementation PropertyFeeHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    //标题:缴费明细
//    @property(nonatomic,strong) UILabel *titleLabel;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"缴费明细";
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = UIFontNormal;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
    }];
//    @property(nonatomic,strong) UILabel *totalTitleLabel;     //@"明细单"
    _totalTitleLabel = [[UILabel alloc] init];
    _totalTitleLabel.text = @"明细单";
    _totalTitleLabel.textColor = [UIColor grayColor];
    _totalTitleLabel.textAlignment = NSTextAlignmentLeft;
    _totalTitleLabel.font = UIFontNormal;
    [self.contentView addSubview:_totalTitleLabel];
    [_totalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_top).offset(0);
        make.left.equalTo(_titleLabel.mas_right).offset(70);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
    
    //分区展开标示
//    @property(nonatomic,strong,readonly) UIImageView *arrowImageView;
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.contentMode = UIViewContentModeCenter;
    _arrowImageView.image = [UIImage imageNamed:@"Root_Arrow_Right"];
    [self.contentView addSubview:_arrowImageView];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleLabel.mas_centerY);
        make.right.mas_equalTo(-20);
    }];
    
    //分区下阴影
    _shadowImageView = [[UIImageView alloc] init];
    _shadowImageView.contentMode = UIViewContentModeScaleToFill;
    _shadowImageView.image = [UIImage imageNamed:@"House_Shadow"];
    _shadowImageView.hidden = YES;
    [self.contentView addSubview:_shadowImageView];
    [_shadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(9);
    }];
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = HexColor(0xeeeeee).CGColor;
    [self.contentView.layer addSublayer:_lineLayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];

}
-(void)viewTap{
    
    if (_delegate && [_delegate respondsToSelector:@selector(headerView:didSelectAtSection:)]) {
        
        [_delegate headerView:self didSelectAtSection:_section];
        
        __weak typeof(self) weakSelf = self;
        if(CGAffineTransformEqualToTransform(_arrowImageView.transform, CGAffineTransformMakeRotation(M_PI_2))) {
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI + M_PI_2);
                weakSelf.shadowImageView.hidden = NO;
                weakSelf.lineLayer.hidden = YES;
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
                weakSelf.shadowImageView.hidden = YES;
                weakSelf.lineLayer.hidden = NO;
            }];
        }
    }
}

-(void)refreshArrowStatusWithExpand:(BOOL)isExpand {
    if(isExpand) {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI + M_PI_2);
        self.shadowImageView.hidden = NO;
        self.lineLayer.hidden = YES;
    } else {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.shadowImageView.hidden = YES;
        self.lineLayer.hidden = NO;
    }
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    _lineLayer.frame = CGRectMake(0, self.height - 1, self.width, 1);
}


















@end
