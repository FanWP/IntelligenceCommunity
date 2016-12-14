//
//  OwnerHeaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "OwnerHeaderView.h"

@implementation OwnerHeaderView
-(instancetype)initWithFrame:(CGRect)frame {
    if(CGSizeEqualToSize(CGSizeZero, frame.size)) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        frame.size = CGSizeMake(size.width, 100);
    }
    self = [super initWithFrame:frame];
    if(self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    _backGroundImageView = [[UIImageView alloc] init];
    _backGroundImageView.contentMode = UIViewContentModeScaleToFill;
    _backGroundImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_backGroundImageView];
    [_backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    //用户头像、名称
//    @property(nonatomic,strong) UIImageView *userImageView;
//    @property(nonatomic,strong) UILabel *userName;
    _userImageView = [[UIImageView alloc] init];
    _userImageView.contentMode = UIViewContentModeScaleAspectFit;
    _userImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(70);
    }];
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.text = @"王先生";
    _userNameLabel.textColor = [UIColor grayColor];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.font = UIFontNormal;
    [self addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImageView.mas_bottom).offset(5);
        make.left.right.equalTo(_userImageView);
        make.height.mas_equalTo(30);
    }];
    //我的发布、好友
//    @property(nonatomic,strong) UILabel *onwerUploadLabel;
//    @property(nonatomic,strong) UILabel *friendCountLabel;
    _ownerUploadLabel = [[UILabel alloc] init];
    _ownerUploadLabel.text = @"43\n我的发布";
    _ownerUploadLabel.numberOfLines = 0;
    _ownerUploadLabel.textColor = [UIColor grayColor];
    _ownerUploadLabel.textAlignment = NSTextAlignmentCenter;
    _ownerUploadLabel.font = UIFontNormal;
    [self addSubview:_ownerUploadLabel];
    [_ownerUploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(-70);
        make.bottom.mas_equalTo(-20);
        make.width.mas_equalTo(100);
    }];
    _friendCountLabel = [[UILabel alloc] init];
    _friendCountLabel.text = @"21\n好友";
    _friendCountLabel.numberOfLines = 0;
    _friendCountLabel.textColor = [UIColor grayColor];
    _friendCountLabel.textAlignment = NSTextAlignmentCenter;
    _friendCountLabel.font = UIFontNormal;
    [self addSubview:_friendCountLabel];
    [_friendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(70);
        make.bottom.equalTo(_ownerUploadLabel.mas_bottom);
        make.width.equalTo(_ownerUploadLabel.mas_width);
    }];
    
}









@end
