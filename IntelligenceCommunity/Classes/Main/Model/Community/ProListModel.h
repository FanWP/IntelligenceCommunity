//
//  ProListModel.h
//  CommodityListTableView
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

//商品列表
@interface ProListModel : NSObject

@property(nonatomic,strong) NSNumber *commodityID;      //商品ID
@property(nonatomic,copy) NSString *images;             //图片
@property(nonatomic,strong) NSString *introduction;
@property(nonatomic,strong) NSNumber *inventory;
@property(nonatomic,strong) NSNumber *price;            //价格
@property(nonatomic,strong) NSNumber *productTypeId;
@property(nonatomic,copy) NSString *productTypeName;    //商品分类
@property(nonatomic,copy) NSString *productname;        //商品名称
@property(nonatomic,strong) NSNumber *purchaseprice;
@property(nonatomic,copy) NSString *remark;             //备注
@property(nonatomic,strong) NSNumber *shelves;
@property(nonatomic,strong) NSNumber *vendorid;
@property(nonatomic,copy) NSString *vendors;


//自定义字段,用于记录购物车中某件商品的数量
@property(nonatomic,copy) NSString *orderCount;         //在购物车中的数量
//用于当商品数量变动的时候，刷新UI
@property(nonatomic,strong) NSIndexPath *indexPath;

@end

/*
 "id": 4,
 "images": "",
 "introduction": "",
 "inventory": 0,
 "price": 0,
 "productTypeId": 2,
 "productTypeName": "水果",
 "productname": "苹果",
 "purchaseprice": 0,
 "remark": "",
 "shelves": 0,
 "shelvestime": {
 "date": 2,
 "day": 5,
 "hours": 16,
 "minutes": 37,
 "month": 11,
 "seconds": 6,
 "time": 1480667826000,
 "timezoneOffset": -480,
 "year": 116
 */
