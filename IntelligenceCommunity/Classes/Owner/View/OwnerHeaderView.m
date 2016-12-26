//
//  OwnerHeaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "OwnerHeaderView.h"
#import "MyPublishVC.h"

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
    _backGroundImageView.image = [UIImage imageNamed:@"background"];
    [self addSubview:_backGroundImageView];
    [_backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_offset(130);
    }];
    
    
    
    _userImageView = [[UIImageView alloc] init];
    _userImageView.contentMode = UIViewContentModeScaleAspectFit;
    _userImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(55);
        make.left.mas_offset(25);
        make.width.height.mas_equalTo(70);
    }];
    
    
    
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.text = @"王先生";
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNameLabel.textColor = HexColor(0x505050);
    _userNameLabel.font = UIFont15;
    [self addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(75);
        make.left.equalTo(_userImageView.mas_right).offset(14);
        make.right.mas_offset(-25);
        make.height.mas_equalTo(30);
    }];
    
    
    
    _ownerUploadCountButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_ownerUploadCountButton.titleLabel setFont:UIFontSmall];
    [_ownerUploadCountButton setTitleColor:HexColor(0x505050) forState:(UIControlStateNormal)];
    [self addSubview:_ownerUploadCountButton];
    [_ownerUploadCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(130);
        make.left.mas_offset(58.5);
        make.width.mas_offset(129);
        make.height.mas_offset(20);
    }];
    
    
    _ownerUploadButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_ownerUploadButton.titleLabel setFont:UIFont15];
    [_ownerUploadButton setTitleColor:HexColor(0x161616) forState:(UIControlStateNormal)];
    [self addSubview:_ownerUploadButton];
    [_ownerUploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ownerUploadCountButton.mas_bottom);
        make.left.equalTo(_ownerUploadCountButton.mas_left);
        make.width.equalTo(_ownerUploadCountButton);
        make.height.mas_offset(30);
    }];
    

    
    _friendCountButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_friendCountButton.titleLabel setFont:UIFontSmall];
    [_friendCountButton setTitleColor:HexColor(0x505050) forState:(UIControlStateNormal)];
    [self addSubview:_friendCountButton];
    [_friendCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ownerUploadCountButton.mas_top);
        make.right.mas_offset(-58.5);
        make.width.height.equalTo(_ownerUploadCountButton);
    }];
    
    
    
    _friendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_friendButton.titleLabel setFont:UIFont15];
    [_friendButton setTitleColor:HexColor(0x161616) forState:(UIControlStateNormal)];
    [self addSubview:_friendButton];
    [_friendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ownerUploadButton.mas_top);
        make.left.equalTo(_friendCountButton.mas_left);
        make.width.height.equalTo(_ownerUploadButton);
    }];

    
    
    [_ownerUploadCountButton setTitle:@"35" forState:(UIControlStateNormal)];
    [_ownerUploadButton setTitle:@"我的发布" forState:(UIControlStateNormal)];
    [_ownerUploadButton addTarget:self action:@selector(myPublishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_friendCountButton setTitle:@"321" forState:(UIControlStateNormal)];
    [_friendButton setTitle:@"我的好友" forState:(UIControlStateNormal)];
}


-(void)myPublishBtnClick
{
    MJRefreshLog(@"发布");

    
    MyPublishVC *vc = [[MyPublishVC alloc] init];
    [[self viewController].navigationController pushViewController:vc animated:YES];


}



- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}









@end
