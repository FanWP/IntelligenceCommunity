//
//  PropertyFeeOtherInfoModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>


//缴费账期、应缴金额、缴费账号、户名、住户信息

@interface PropertyFeeOtherInfoModel : NSObject

@property(nonatomic,strong) NSNumber *feeAccount;   //缴费账号
@property(nonatomic,strong) NSNumber *feeStatus;
@property(nonatomic,strong) NSString *feeperiod;    //缴费账期
@property(nonatomic,strong) NSString *houseInfo;    //住户信息
@property(nonatomic,strong) NSString *houseMaster;  //户名
@property(nonatomic,strong) NSNumber *proFeeCode;   //物业费信息，0：有信息，-1未查到信息
@property(nonatomic,strong) NSNumber *totalFee;      //应缴金额

@end

/*
 feeAccount = 1546854;
 feeStatus = 1;
 feeperiod = "2016-10-01-2016-11-01";
 houseInfo = "1\U53f7\U697c\U4e8c\U5355\U51432304";
 houseMaster = "\U5f20\U4e09";
 proFeeCode = 0;
 totalFee = 1500;
 */
