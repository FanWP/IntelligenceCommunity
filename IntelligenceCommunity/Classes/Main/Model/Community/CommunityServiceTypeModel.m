//
//  CommunityServiceTypeModel.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommunityServiceTypeModel.h"

@implementation CommunityServiceTypeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.serviceTypeID = value;
    }
    if ([key isEqualToString:@"typename"]) {
        self.serviceTypename = value;
    }
}

@end
