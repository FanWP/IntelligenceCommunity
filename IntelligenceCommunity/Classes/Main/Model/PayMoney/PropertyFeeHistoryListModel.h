//
//  PropertyFeeHistoryListModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

//查询当前用户物业费缴费记录
@interface PropertyFeeHistoryListModel : NSObject

@property(nonatomic,strong) NSNumber *amount;   //缴费金额
@property(nonatomic,copy) NSString *feePeriod;  //缴费账期
@property(nonatomic,strong) NSNumber *flowNum;    //流水号
@property(nonatomic,copy) NSString *payTime;    //缴费时间
@property(nonatomic,strong) NSNumber *paymentId;//支付记录ID，查看详情用
@property(nonatomic,strong) NSNumber *type;     //1:物业费

@end

/*
 {
    amount = 0;
    feePeriod = "2016-11-01\U81f32016-12-30";
    flowNum = 20161120;
    payTime = "2016-11-20 10:23";
    paymentId = 15498;
    type = 1;
 }
 */
