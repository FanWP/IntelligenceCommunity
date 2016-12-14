//
//  SpecialOffersListModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>


//预交优惠活动列表

@interface SpecialOffersListModel : NSObject

@property(nonatomic,strong) NSNumber *discount;
@property(nonatomic,copy) NSString *discountcontent;    //内容详细
@property(nonatomic,strong) NSNumber *disprice;
@property(nonatomic,strong) NSNumber *specialOffersID;  //主键：优惠活动id
@property(nonatomic,strong) NSNumber *payMonth;
@property(nonatomic,strong) NSNumber *reduceMonth;
@property(nonatomic,strong) NSNumber *type;

@end
/*
 {
    discount = 0;
    discountcontent = "\U4ea4\U4e09\U4e2a\U6708\U51cf1\U4e2a\U6708";
    disprice = 0;
    id = 1;
    payMonth = 3;
    reduceMonth = 1;
    type = 3;
 },
 */
