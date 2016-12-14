//
//  MaterialsAreadlySaleView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/24.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MaterialsAreadlySaleView.h"

@implementation MaterialsAreadlySaleView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"已售";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = UIFontLargest;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
}

@end
