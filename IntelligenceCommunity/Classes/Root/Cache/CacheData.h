//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CacheObject.h"

@interface CacheData : NSObject

/**
 *  初始化配置
 */
+(void)configCacheData;

/**
 *  添加或修改对象到数据库
 */
+(void)addObject:(__kindof CacheObject * _Nonnull) object;

/**
 *  删除对象
 */
+(void)deleteObject:(__kindof CacheObject * _Nonnull) object;
+(void)deleteObjects:(_Nonnull id)array;
+(void)deleteAllObjects:(_Nonnull Class)cls;

/**
 *  查询
 *
 *  @param cls 目标对象
 *
 *  @return 返回查询结果
 */
+( RLMResults<CacheObject *> * _Nullable )search:(_Nonnull Class)cls;

/**
 *  排序查询
 *
 *  @param cls       目标对象
 *  @param sorted    排序字段
 *  @param ascending 是否升序
 *
 *  @return 返回查询结果
 */
+(RLMResults<CacheObject *> * _Nullable)search:(_Nonnull Class)cls sorted:(NSString * _Nullable )sorted ascending:(BOOL)ascending;

/**
 *  条件查询
 *
 *  @param cls       目标对象
 *  @param predicate 查询条件
 *
 *  @return 返回查询结果
 */
+(RLMResults<CacheObject *> * _Nullable)search:(_Nonnull Class)cls predicate:(NSString * _Nullable)predicate;

+(RLMResults<CacheObject *> * _Nullable)search:(_Nonnull Class)cls predicate:(NSString * _Nullable)predicate sorted:(NSString * _Nullable)sorted ascending:(BOOL)ascending;

/**
 *  修改操作
 */
+(void)write:(void( ^ _Nonnull)(void))block;

//+(void)removeAll:(_Nonnull Class)cls;
//+(void)remove:(RLMResults * _Nonnull)results;

@end
