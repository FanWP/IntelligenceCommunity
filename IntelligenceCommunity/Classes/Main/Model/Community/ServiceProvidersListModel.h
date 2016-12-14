//
//  ServiceProvidersListModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

//商品、便民、美食、娱乐具体模块的服务商列表
@interface ServiceProvidersListModel : NSObject

@property(nonatomic,copy) NSString *address;                    //地址
@property(nonatomic,copy) NSString *serviceProviderDescription; //描述
@property(nonatomic,strong) NSNumber *enable;                   //0营业中 ，1 不营业
@property(nonatomic,copy) NSString *endTime;                    //结束时间
@property(nonatomic,strong) NSNumber *evaluate;                 //评论几颗星
@property(nonatomic,strong) NSNumber *serviceProviderID;    //主键ID
@property(nonatomic,copy) NSString *images;
@property(nonatomic,strong) NSNumber *mallTypeId;               //门店类型id
@property(nonatomic,copy) NSString *remark;
@property(nonatomic,strong) NSNumber *salecount;                //月销量
@property(nonatomic,copy) NSString *startTime;                  //营业开始时间
@property(nonatomic,copy) NSString *telephone;
@property(nonatomic,copy) NSString *vendername;                 //门店名字

@end

/*
 {
    "address": "西安市回民街",
    "description": "回民街小吃",
    "enable": 0,
    "endTime": "20:00",
    "evaluate": 0,
    "id": 4,
    "images": "",
    "mallTypeId": 3,
    "remark": "",
    "salecount": 200,
    "startTime": "8:00",
    "telephone": "13659555879",
    "vendername": "重庆小面"
 }
 */
