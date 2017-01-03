//
//  DeterminePaySendAddressCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>


//确认支付界面头部收货地址等信息
@interface DeterminePaySendAddressCell : UITableViewCell

//图标
@property(nonatomic,strong) UIImageView *addressImageView;
//姓名   地址    电话
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *phoneLabel;
@property(nonatomic,strong) UILabel *addressLabel;

//送达时间      尽快送达
@property(nonatomic,strong) UILabel *sendTimeLabel;
@property(nonatomic,strong) UILabel *fastSendLabel;
@property(nonatomic,strong) UIImageView *rightImageView;

@end
