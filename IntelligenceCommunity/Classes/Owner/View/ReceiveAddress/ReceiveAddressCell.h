//
//  ReceiveAddressCell.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveAddressCell : UITableViewCell

@property (nonatomic,strong) UILabel *receiverLabel;// 收货人
@property (nonatomic,strong) UILabel *receiverPhoneNumLabel;// 收货人手机号
@property (nonatomic,strong) UILabel *receiveAddressLabel;// 收货地址
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIButton *defaultAddressButton;// 设为默认地址按钮
@property (nonatomic,strong) UILabel *defaultAddressLabel;// 设为默认地址
@property (nonatomic,strong) UIButton *editAddressButton;// 编辑地址
@property (nonatomic,strong) UIButton *deleteAddressButton;// 删除地址

@end
