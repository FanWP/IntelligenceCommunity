//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//


#import "CacheData.h"

@implementation CacheData

+(void)configCacheData {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
//warning 设置新的架构版本。这个版本号必须高于之前所用的版本号（如果您之前从未设置过架构版本，那么这个版本号设置为 0）
    config.schemaVersion = 1;
    // 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // 目前我们还未进行数据迁移，因此 oldSchemaVersion == 0
        if (oldSchemaVersion < config.schemaVersion) {
            // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
        }
    };
    // 告诉 Realm 为默认的 Realm 数据库使用这个新的配置对象
    [RLMRealmConfiguration setDefaultConfiguration:config];
    // 现在我们已经告诉了 Realm 如何处理架构的变化，打开文件之后将会自动执行迁移
    [RLMRealm defaultRealm];
}

+(RLMRealm*)defaultRealm {
    
    return [RLMRealm defaultRealm];
}

+(NSString*)UUID {
    return [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+(void)addObject:(__kindof CacheObject *)object {
    if(!object.localObjectID) {
        object.localObjectID = [self UUID];
    }
//        object.localObjectID = [self UUID];
    
    
    if(!object.localCreateAt) {
        object.localCreateAt = [NSDate date];
    }
    
    object.localUpdateAt = [NSDate date];
    
    RLMRealm *realm = [self defaultRealm];
    [realm transactionWithBlock:^{
        if([[object class] primaryKey]) {
            [realm addOrUpdateObject:object];
        } else {
            [realm addObject:object];
        }
    }];
}

+(void)deleteObject:(__kindof CacheObject *)object {
    RLMRealm *realm = [self defaultRealm];
    [realm transactionWithBlock:^{
        [realm deleteObject:object];
    }];
}

+(void)deleteObjects:(id)array {
    RLMRealm *realm = [self defaultRealm];
    [realm transactionWithBlock:^{
        [realm deleteObjects:array];
    }];
}

+(void)deleteAllObjects:(Class)cls {
    RLMRealm *realm = [self defaultRealm];
    RLMResults *results = [self search:cls];
    [realm beginWriteTransaction];
    for (id obj in results) {
        [realm deleteObject:obj];
    }
    [realm commitWriteTransaction];
}

+(BOOL)isSubclassOfCacheObjectClass:(Class)cls {
    if(![cls isSubclassOfClass:[CacheObject class]]) {
        NSLog(@"错误：不是CacheObject的子类");
        return NO;
    }
    return YES;
}

+(RLMResults<CacheObject *> *)search:(Class)cls {
    return [self search:cls predicate:nil sorted:nil ascending:YES];
}

+(RLMResults<CacheObject *> *)search:(Class)cls sorted:(NSString*)sorted ascending:(BOOL)ascending {
    return [self search:cls predicate:nil sorted:sorted ascending:ascending];
}

+(RLMResults<CacheObject *> *)search:(Class)cls predicate:(NSString*)predicate {
    return [self search:cls predicate:predicate sorted:nil ascending:YES];
}

+(RLMResults<CacheObject *> *)search:(Class)cls predicate:(NSString*)predicate sorted:(NSString*)sorted ascending:(BOOL)ascending {
    if(![self isSubclassOfCacheObjectClass:cls]) {
        return nil;
    }
    
    RLMResults *results;
    if(predicate) {
        results = [cls objectsWhere:predicate];
    } else {
        results = [cls allObjects];
    }
    
    if(results && results.count > 0) {
        if(sorted) {
            results = [results sortedResultsUsingProperty:sorted ascending:ascending];
        } else {
            results = [results sortedResultsUsingProperty:CacheObjectLocalCreateAtKey ascending:NO];
        }
    }
    
    return results;
}

+(void)write:(void (^)(void))block {
    RLMRealm *realm = [self defaultRealm];
    [realm transactionWithBlock:^{
        block();
    }];
}

//+(void)removeAll:(Class)cls {
//    RLMRealm *realm = [self defaultRealm];
//    RLMResults *results = [self search:cls];
//    [realm beginWriteTransaction];
//    for (id obj in results) {
//        [realm deleteObject:obj];
//    }
//    [realm commitWriteTransaction];
//}
//
//+(void)remove:(RLMResults*)results {
//    RLMRealm *realm = [self defaultRealm];
//    [realm beginWriteTransaction];
//    for (id item in results) {
//        [realm deleteObject:item];
//    }
//    [realm commitWriteTransaction];
//}


@end
