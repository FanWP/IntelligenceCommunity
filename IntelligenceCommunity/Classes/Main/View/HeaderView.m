//
//  HeaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property(nonatomic,strong) CALayer *lineLayer;

@end

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame {
    if(CGSizeEqualToSize(CGSizeZero, frame.size)) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        frame.size = CGSizeMake(size.width, 30);
    }
    self = [super initWithFrame:frame];
    if(self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    _videoImageView = [[UIImageView alloc] init];
    _videoImageView.contentMode = UIViewContentModeScaleToFill;
    _videoImageView.image = [UIImage imageNamed:@"1.jpg"];
    [self addSubview:_videoImageView];
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    _noticeImageView = [[UIImageView alloc] init];
    _noticeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _noticeImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_noticeImageView];
    [_noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_videoImageView.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    _noticeLabel = [[UILabel alloc] init];
    _noticeLabel.text = @"阳澄湖秋季大闸蟹,夺鲜上市！！！";
    _noticeLabel.textColor = [UIColor grayColor];
    _noticeLabel.font = UIFontNormal;
    _noticeLabel.textAlignment = UIStackViewAlignmentLeading;
    [self addSubview:_noticeLabel];
    [_noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_noticeImageView.mas_centerY);
        make.left.equalTo(_noticeImageView.mas_right).offset(20);
        make.right.mas_equalTo(0);
        make.height.equalTo(_noticeImageView.mas_height);
    }];
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:_lineLayer];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _lineLayer.frame = CGRectMake(0, self.bounds.size.height - 10, self.bounds.size.width, 10);

}

@end
