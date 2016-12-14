//
//  CommunityServiceTypeModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

//社区服务首页四个入口://商品-commodity  方便--convenient  美食--delicacy  娱乐--entertainment

@interface CommunityServiceTypeModel : NSObject

@property(nonatomic,strong) NSNumber *enable;     //可用1 ，不可用0
@property(nonatomic,strong) NSNumber *serviceTypeID;    //主键ID
@property(nonatomic,copy) NSString *image;              //图标
@property(nonatomic,strong) NSNumber *status;           // 1是直接支付  2是预约形式
@property(nonatomic,copy) NSString *serviceTypename;    //服务类型:四大类


@end

/*
 {
    "enable": 1,
    "id": 1,
    "image": "",
    "status": 0,
    "typename": "商店"
 }
 */
