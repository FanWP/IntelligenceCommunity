//
//  User.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "User.h"

@implementation User

#pragma mark-- 使用name做为用户主键与其它数据关联
+(NSString *)primaryKey {
    return @"name";
}

+(instancetype)currentUser {
    RLMResults *results = [CacheData search:[User class] sorted:CacheObjectLocalUpdateAtKey ascending:NO];
    if(results && results.count > 0) {
        return results.firstObject;
    }
    return nil;
}

@end
