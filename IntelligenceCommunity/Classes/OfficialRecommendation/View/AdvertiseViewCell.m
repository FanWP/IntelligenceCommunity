//
//  AdvertiseViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "AdvertiseViewCell.h"

@implementation AdvertiseViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return self;
}

-(void)initializeComponent{
    
    _advertiseImageView = [[UIImageView alloc] init];
    _advertiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    _advertiseImageView.clipsToBounds = YES;
    _advertiseImageView.image = [UIImage imageNamed:@"1.jpg"];
    [self addSubview:_advertiseImageView];
    [_advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    _advertiseTitleLabel = [[UILabel alloc] init];
    _advertiseTitleLabel.text = @"test";
    _advertiseTitleLabel.textColor = [UIColor grayColor];
    _advertiseTitleLabel.textAlignment = NSTextAlignmentLeft;
    _advertiseTitleLabel.font = UIFontNormal;
    [self addSubview:_advertiseTitleLabel];
    [_advertiseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_advertiseImageView.mas_bottom).offset(0);
        make.left.mas_offset(5);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
    
    
    
    
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
