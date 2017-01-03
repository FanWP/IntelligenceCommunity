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
    _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _videoImageView.clipsToBounds = YES;
    _videoImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_videoImageView];
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kGetVerticalDistance(254));
    }];
}

@end
