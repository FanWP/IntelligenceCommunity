//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//


#import <Realm/Realm.h>

extern NSString *const CacheObjectLocalObjectIDKey;
extern NSString *const CacheObjectLocalCreateAtKey;
extern NSString *const CacheObjectLocalUpdateAtKey;

@interface CacheObject : RLMObject

@property NSString *localObjectID;
@property NSDate *localCreateAt;
@property NSDate *localUpdateAt;

@end
