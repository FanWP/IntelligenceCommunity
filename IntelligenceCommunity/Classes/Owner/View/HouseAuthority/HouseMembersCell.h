//
//  HouseMembersCell.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseMembersCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headerImageView;// 头像
@property (nonatomic,strong) UILabel *identifierLabel;// 身份
@property (nonatomic,strong) UILabel *nameLabel;// 姓名
@property (nonatomic,strong) UILabel *phoneNumberLabel;// 手机号

@end
