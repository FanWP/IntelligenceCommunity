//
//  HouseAuthorityModel.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseAuthorityModel.h"

@implementation HouseAuthorityModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             @"introduce" : @"description"
             };
}
@end
