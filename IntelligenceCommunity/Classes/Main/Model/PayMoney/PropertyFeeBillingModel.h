//
//  PropertyFeeBillingModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

//查询物业费缴费记录明细

@interface PropertyFeeBillingModel : NSObject

@property(nonatomic,strong) NSNumber *amount;       //缴费金额
@property(nonatomic,copy) NSString *feePeriod;      //缴费账期
@property(nonatomic,copy) NSString *houseInfo;      //房屋信息
@property(nonatomic,copy) NSString *payInfo;        //付款账户
@property(nonatomic,copy) NSString *payTime;        //支付时间
@property(nonatomic,strong) NSNumber *payType;      //支付方式：1支付宝，2微信
@property(nonatomic,copy) NSString *typeName;       //名称
@end

/*
 body =     {
    amount = 215;
    feePeriod = "2016-11-01\U81f32016-12-30";
    houseInfo = "XX\U5c0f\U533a3\U53f7\U697c1502\U5ba4";
    payInfo = "231006 **\U4f73";
    payTime = "2016-11-26 13:42:23";
    payType = 1;
    typeName = "\U7269\U4e1a\U8d39";
 };
 */
