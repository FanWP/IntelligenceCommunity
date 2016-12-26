
//
//  CommonHeaderView.m
//  IntelligenceCommunityService
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommonHeaderView.h"

@implementation CommonHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    _commodityCategoryNameLabel = [[UILabel alloc] init];
    _commodityCategoryNameLabel.text = @"商品分类名称";
    _commodityCategoryNameLabel.textColor = [UIColor brownColor];
    _commodityCategoryNameLabel.textAlignment = NSTextAlignmentLeft;
    _commodityCategoryNameLabel.font = UIFontNormal;
    [self.contentView addSubview:_commodityCategoryNameLabel];
    [_commodityCategoryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.bottom.right.mas_offset(0);
    }];
}
@end
