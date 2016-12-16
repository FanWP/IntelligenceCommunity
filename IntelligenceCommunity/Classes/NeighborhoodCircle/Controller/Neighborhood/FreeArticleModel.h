//
//  FreeArticleModel.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeArticleModel : NSObject


/** 是否支持物品交换 */
@property (nonatomic,assign) BOOL change;

/** 内容 */
@property (nonatomic,copy) NSString *content;

/** 创建时间 */
@property (nonatomic,copy) NSString *createTime;

/** ID */
@property (nonatomic,copy) NSString *ID;

/** 图像 */
@property (nonatomic,copy) NSString *images;

/** 创建时间 */
@property (nonatomic,copy) NSString *likeUserid;


/** 价格 */
@property (nonatomic,copy) NSString *price;

/** 销售状态 */
@property (nonatomic,assign) BOOL saleStatus;

/** 原价 */
@property (nonatomic,copy) NSString *srcPrice;


/** 价格 */
@property (nonatomic,copy) NSString *status;

/** 标题 */
@property (nonatomic,copy) NSString *title;

/** 用户的ID */
@property (nonatomic,copy) NSString *userid;









/*
 
 "{
 ""resultCode"": 1000,
 ""body"": [
 {
 ""change"": 0,
 ""content"": ""adsfdsadfs"",
 ""createTime"": ""2016-12-13 17:15:43"",
 ""friendsRefList"":
 ""id"": 1,
 ""images"": ""fjlkafllafjskjdkl"",
 ""likeUserid"": """",
 ""price"": ""10"",
 ""saleStatus"": 0,
 ""srcPrice"": ""18"",
 ""status"": 0,
 ""title"": ""年轻人毕竟图样"",
 ""userid"": 2
 
 
 [
 {
 ""conment"": """",
 ""id"": 1,
 ""replyToUserId"": 0,
 ""targetId"": 1,
 ""type"": 0,
 ""userid"": 13
 },
 {
 ""conment"": """",
 ""id"": 2,
 ""replyToUserId"": 0,
 ""targetId"": 1,
 ""type"": 0,
 ""userid"": 14
 },
 {
 ""conment"": """",
 ""id"": 3,
 ""replyToUserId"": 13,
 ""targetId"": 1,
 ""type"": 0,
 ""userid"": 15
 }
 ],
 
 

 },
 {
 
 

 */

@end