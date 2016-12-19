//
//  OwnerHeaderView.h
//  IntelligenceCommunity
//
//  Created by beibei on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnerHeaderView : UIView

//背景图片
@property (nonatomic,strong) UIImageView *backGroundImageView;

//用户头像、名称
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *userNameLabel;

//我的发布、好友 和 发布数量
@property (nonatomic,strong) UIButton *ownerUploadCountButton;
@property (nonatomic,strong) UIButton *ownerUploadButton;
@property (nonatomic,strong) UIButton *friendCountButton;
@property (nonatomic,strong) UIButton *friendButton;

@end
