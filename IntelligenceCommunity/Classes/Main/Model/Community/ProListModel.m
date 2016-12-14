//
//  ProListModel.m
//  CommodityListTableView
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ProListModel.h"

@implementation ProListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _commodityID = value;
    }
}


@end
