//
//  RequestManager.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>


//服务器地址后缀:共三种类型
typedef NS_ENUM(NSUInteger, RequestMethodType) {
    Pro_api,
    Smart_community,
    Mall_api,
};

typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGet = 0,
    RequestMethodPost = 1,
    RequestMethodPut = 2,
    RequestMethodDelete = 3
};

typedef void(^RequestSuccess)(_Nullable id responseObject);
typedef void(^RequestFaile)(NSError * _Nullable error);

/**
 *  网络请求管理
 */
@interface RequestManager : NSObject

+(_Nonnull instancetype) manager;

-(_Nullable instancetype)init NS_UNAVAILABLE;
-(_Nullable instancetype)new NS_UNAVAILABLE;

-(void)HTTPRequest:(NSString * _Nonnull)urlString method:(RequestMethod)method timeout:(NSTimeInterval)timeout parameters:(_Nullable id)parameters success:(_Nonnull RequestSuccess)success faile:(_Nullable RequestFaile)faile;

-(void)JSONRequest:(NSString * _Nonnull)urlString method:(RequestMethod)method timeout:(NSTimeInterval)timeout parameters:(_Nullable id)parameters success:(_Nonnull RequestSuccess)success faile:(_Nullable RequestFaile)faile;

-(void)JSONRequestWithType:(RequestMethodType)requestMethodType  urlString:(NSString * _Nonnull)urlString method:(RequestMethod)method timeout:(NSTimeInterval)timeout parameters:(_Nullable id)parameters success:(_Nonnull RequestSuccess)success faile:(_Nullable RequestFaile)faile;

-(void)setNetworkActivityIndicatorManagerEnabled:(BOOL)isEnabled;

-(void)requestWithURLString:(NSString * _Nonnull)urlString  requestType:(RequestMethod)requestType  requestParameters:(NSDictionary * _Nonnull)parameters  success:(_Nonnull RequestSuccess)success faile:(_Nonnull RequestFaile)faile;

@end
