//
//  PropertyFeeListModel.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeListModel.h"

@implementation PropertyFeeListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _propertyFeeListid = value;
    }
}

@end
