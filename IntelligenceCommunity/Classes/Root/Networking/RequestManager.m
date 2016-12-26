//
//  RequestManager.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RequestManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>



static const char * REQUEST_METHOD[4] = {"GET","POST","PUT","DELETE"};

@implementation RequestManager

-(instancetype)initWithPrivate {
    self = [super init];
    if(self) {
        
    }
    return self;
}

+(instancetype)manager {
    RequestManager *manager = [[RequestManager alloc] initWithPrivate];
    return manager;
}

-(void)setNetworkActivityIndicatorManagerEnabled:(BOOL)isEnabled {
    [[AFNetworkActivityIndicatorManager sharedManager] setActivationDelay:0];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:isEnabled];
}

-(AFURLSessionManager *)sessionManager {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    return sessionManager;
}

-(NSString *)requestMethod:(RequestMethod)method {
    const char *methodChar = REQUEST_METHOD[method];
    NSString *methodString = [NSString stringWithUTF8String:methodChar];
    return methodString;
}

-(void)HTTPRequest:(NSString*)urlString method:(RequestMethod)method timeout:(NSTimeInterval)timeout parameters:(id)parameters success:(RequestSuccess)success faile:(RequestFaile)faile {
    
    NSString *requestMethod = [self requestMethod:method];
    NSError *error;
    
    NSMutableURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:requestMethod URLString:urlString parameters:parameters error:&error];
    if(error) {
        faile(error);
        return;
    }
    urlRequest.timeoutInterval = timeout;
    
    AFURLSessionManager *manager = [self sessionManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *dataTask = [self dataTaskWithManager:manager url:urlRequest success:success faile:faile];
    [dataTask resume];
}

-(NSURLSessionDataTask*)dataTaskWithManager:(AFURLSessionManager*)manager url:(NSURLRequest*)urlRequest success:(RequestSuccess)success faile:(RequestFaile)faile {
    if(!manager) {
        manager = [self sessionManager];
    }
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error) {
            faile(error);
            return;
        }
        if(responseObject) {
            success(responseObject);
        } else {
            faile([NSError errorWithDomain:@"NO Data" code:-1 userInfo:nil]);
        }
    }];
    return dataTask;
}

-(void)JSONRequest:(NSString*)urlString method:(RequestMethod)method timeout:(NSTimeInterval)timeout parameters:(id)parameters success:(RequestSuccess)success faile:(RequestFaile)faile {
    NSString *requestMethod = [self requestMethod:method];
    NSError *error;
    
//    NSString *serviceURL = @"http://192.168.1.23:8080/pro_api/";
    NSString *serviceURL = @"http://192.168.1.18:8080/pro_api/";   //李宇
    
    if ([urlString isEqualToString:@"find/help/center?pageSize=1"]) {    //缴费模块-帮助中心
        serviceURL = @"http://192.168.1.18:8080/smart_community/";
    }else if ([urlString isEqualToString:@"find/vendor/product/for/sale?venderId=1&pageNum=1&pageSize=5"]){
        serviceURL = @"http://192.168.1.18:8080/mall_api/";
    }else if ([urlString isEqualToString:@"find/communityService/type"]){
        serviceURL = @"http://192.168.1.18:8080/mall_api/";
    }else if ([urlString isEqualToString:@"find/vendorsInfo?malltypeid=1"] || [urlString isEqualToString:@"find/vendorsInfo?malltypeid=2"] || [urlString isEqualToString:@"find/vendorsInfo?malltypeid=3"] || [urlString isEqualToString:@"find/vendorsInfo?malltypeid=4"]){
        serviceURL = @"http://192.168.1.18:8080/mall_api/";
    }

    
    NSString *RequestURL = [serviceURL stringByAppendingString:[NSString stringWithFormat:@"%@",urlString]];

    
    NSMutableURLRequest *urlRequest = [[AFJSONRequestSerializer serializer] requestWithMethod:requestMethod URLString:RequestURL parameters:parameters error:&error];
    if(error){
        faile(error);
        return;
    }
    urlRequest.timeoutInterval = timeout;
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithManager:[self sessionManager] url:urlRequest success:success faile:faile];
    [dataTask resume];
}
-(void)JSONRequestWithType:(RequestMethodType)requestMethodType urlString:(NSString *)urlString method:(RequestMethod)method timeout:(NSTimeInterval)timeout parameters:(NSMutableDictionary *)parameters success:(RequestSuccess)success faile:(RequestFaile)faile{

    NSString *requestMethod = [self requestMethod:method];
    NSError *error;
    
    //    NSString *serviceURL = @"http://192.168.1.23:8080/pro_api/";
    NSString *serviceURL = [NSString stringWithFormat:@"%@pro_api/",Smart_community_URL];   //李宇
    if (requestMethodType == Pro_api) {
        serviceURL = [NSString stringWithFormat:@"%@pro_api/",Smart_community_URL];   //李宇
    }else if (requestMethodType == Smart_community){
        serviceURL = [NSString stringWithFormat:@"%@smart_community/",Smart_community_URL];
    }else if (requestMethodType == Mall_api){
        serviceURL = [NSString stringWithFormat:@"%@mall_api/",Smart_community_URL];
    }
    
    
    NSString *RequestURL = [serviceURL stringByAppendingString:[NSString stringWithFormat:@"%@",urlString]];
    
    MJRefreshLog(@"RequestURL---:%@",RequestURL);
    
    
    NSMutableURLRequest *urlRequest = [[AFJSONRequestSerializer serializer] requestWithMethod:requestMethod URLString:RequestURL parameters:parameters error:&error];
    
    if (method == RequestMethodPost) {
        if (parameters && parameters.count) {
            urlRequest.HTTPBody = [[RequestManager manager] dictionaryTransformParameters:parameters];
        }
    }
    
    if(error){
        faile(error);
        return;
    }
    urlRequest.timeoutInterval = timeout;
    //    [urlRequest setValue:@"userID" forHTTPHeaderField:<#(nonnull NSString *)#>]
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithManager:[self sessionManager] url:urlRequest success:success faile:faile];
    [dataTask resume];
}
#pragma mark--原生session请求
-(void)SessionRequestWithType:(RequestMethodType)requestMethodType  requestWithURLString:(NSString *)urlString  requestType:(RequestMethod)requestType  requestParameters:(NSDictionary *)parameters  success:(RequestSuccess)success faile:(RequestFaile)faile{
    
    //服务器
    //    NSString *serviceURL = @"http://192.168.1.4:8080/pro_api/";
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@pro_api/",Smart_community_URL];   //李宇
    if (requestMethodType == Pro_api) {
        serviceURL = [NSString stringWithFormat:@"%@pro_api/",Smart_community_URL];   //李宇
    }else if (requestMethodType == Smart_community){
        serviceURL = [NSString stringWithFormat:@"%@smart_community/",Smart_community_URL];
    }else if (requestMethodType == Mall_api){
        serviceURL = [NSString stringWithFormat:@"%@mall_api/",Smart_community_URL];
    }
    
    NSString *RequestURL = [serviceURL stringByAppendingString:[NSString stringWithFormat:@"%@",urlString]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:RequestURL]];
    
    if (requestType == RequestMethodPost) {
        request.HTTPMethod = @"POST";
        if (parameters && parameters.count) {
            request.HTTPBody = [[RequestManager manager] dictionaryTransformParameters:parameters];
        }
    }else{
        request.HTTPMethod = @"GET";
        //GET请求
    }
    request.timeoutInterval = 30;
    
    [[RequestManager manager] dataRequestWithRequest:request success:success faile:faile];
    
}

-(void)requestWithURLString:(NSString *)urlString  requestType:(RequestMethod)requestType  requestParameters:(NSDictionary *)parameters  success:(RequestSuccess)success faile:(RequestFaile)faile{
    
    //服务器
//    NSString *serviceURL = @"http://192.168.1.4:8080/pro_api/";
    
    NSString *serviceURL = @"http://192.168.1.17/smart_community/";   //李宇
    
    NSString *RequestURL = [serviceURL stringByAppendingString:[NSString stringWithFormat:@"%@",urlString]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:RequestURL]];
    
    if (requestType == RequestMethodPost) {
        request.HTTPMethod = @"POST";
        if (parameters && parameters.count) {
            request.HTTPBody = [[RequestManager manager] dictionaryTransformParameters:parameters];
        }
    }else{
        request.HTTPMethod = @"GET";
        //GET请求
    }
    request.timeoutInterval = 30;
    
    [[RequestManager manager] dataRequestWithRequest:request success:success faile:faile];
    
}
//session请求
-(void)dataRequestWithRequest:(NSURLRequest *)request success:(RequestSuccess)success faile:(RequestFaile)faile{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {    //请求成功
            faile(error);
            return;
        }else{          //请求失败
            if (data) {
                
                id resultObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if ([NSJSONSerialization isValidJSONObject:resultObject]) {
                    
                    success(resultObject);
                    
                }else{
                    faile(error);
                }
                
            }else{
                faile(error);
            }
        }
    }];
    
    [dataTask resume];
}
//字典转换为请求参数
-(NSData *)dictionaryTransformParameters:(NSDictionary *)dictionary{
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    for (NSString *key in dictionary) {
        
        NSString *keyAndValue = [NSString stringWithFormat:@"%@=%@",key,dictionary[key]];
        [resultArray addObject:keyAndValue];
        
    }
    NSString *resultString = [resultArray componentsJoinedByString:@"&"];
    return [resultString dataUsingEncoding:NSUTF8StringEncoding];
}





@end
