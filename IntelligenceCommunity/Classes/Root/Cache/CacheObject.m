//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//


#import "CacheObject.h"

NSString *const CacheObjectLocalObjectIDKey = @"localObjectID";
NSString *const CacheObjectLocalCreateAtKey = @"localCreateAt";
NSString *const CacheObjectLocalUpdateAtKey = @"localUpdateAt";

@implementation CacheObject

+(NSString *)primaryKey {
    return CacheObjectLocalObjectIDKey;
}

@end
