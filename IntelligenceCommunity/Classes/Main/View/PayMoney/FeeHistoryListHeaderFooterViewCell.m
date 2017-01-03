//
//  FeeHistoryListHeaderFooterViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/30.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FeeHistoryListHeaderFooterViewCell.h"

@interface FeeHistoryListHeaderFooterViewCell ()

@property(nonatomic,strong) UIImageView *shadowImageView;
@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation FeeHistoryListHeaderFooterViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"11月";
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = UIFontNormal;
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY).offset(0);
        make.left.mas_offset(20);
    }];
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.text = @"金额: ￥00.00";
    _moneyLabel.textColor = [UIColor blackColor];
    _moneyLabel.textAlignment = NSTextAlignmentRight;
    _moneyLabel.font = UIFontNormal;
    [self.contentView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_timeLabel.mas_centerY).offset(0);
        make.right.mas_offset(-50);
    }];
    //展开／关闭标示
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Root_Arrow_Right"]];
    [_arrowImageView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    [self.contentView addSubview:_arrowImageView];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
    
    //地址下面阴影（分区展开时显示）
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

    
    //直接展开分区---废弃
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    

    
    
    
    
    
    
    
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    _lineLayer.frame = CGRectMake(0, self.height - 1, self.width, 1);
}
-(void)viewTap:(UIButton *)sender {
    
    
    if(_delegate && [_delegate respondsToSelector:@selector(FeeHistoryListHeaderFooterViewCell:didSelectAtSection:)]) {
        
        [_delegate FeeHistoryListHeaderFooterViewCell:self didSelectAtSection:_section];
        
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












@end
