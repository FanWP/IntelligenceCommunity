//
//  PropertyFeeListModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

//物业缴费明细:明细单
@interface PropertyFeeListModel : NSObject

//明细栏目名称
@property(nonatomic,strong) NSString *detail;
@property(nonatomic,strong) NSNumber *propertyFeeListid;
//明细栏目金额
@property(nonatomic,strong) NSNumber *price;

@property(nonatomic,strong) NSNumber *sid;
@property(nonatomic,strong) NSNumber *type;


@property(nonatomic,assign) BOOL isExpand;

@end

/*
 {
 detail = "\U536b\U751f\U8d39";
 id = 0;
 price = 7;
 sid = 0;
 type = 0;
 },
 
 */
