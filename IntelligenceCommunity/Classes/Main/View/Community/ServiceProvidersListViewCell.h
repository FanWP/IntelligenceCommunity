//
//  ServiceProvidersListViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceProvidersListViewCell : UITableViewCell

//商家展示图片
@property(nonatomic,strong) UIImageView *advertiseImageView;
//店名
@property(nonatomic,strong) UILabel *storeNameLabel;
//营业时间
@property(nonatomic,strong) UILabel *businessHoursLabel;
//签名
@property(nonatomic,strong) UILabel *signatureLabel;

//综合评分
@property(nonatomic,strong) UILabel *scoreCountLabel;
//月销量
@property(nonatomic,strong) UILabel *monthSaleCountLabel;

@end
