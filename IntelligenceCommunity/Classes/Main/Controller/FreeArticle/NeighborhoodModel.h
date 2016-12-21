//
//  NeighborhoodModel.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/20.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NeighborhoodModel : NSObject


/** 当前用户昵称 */
@property (nonatomic,copy) NSString *userNickName;
/** 头像 */
@property (nonatomic,copy) NSString *headImage;
/** 回复评论目标的头像 */
@property (nonatomic,copy) NSString *replyToUserHeadImage;
/** 头像 */
@property (nonatomic,copy) NSString *ID;
/** 目标用户ID */
@property (nonatomic,copy) NSString *targetId;
/** 用户的ID */
@property (nonatomic,copy) NSString *userid;
/** 设置评论还是回复  0-no-评论  1-yes-回复 */
@property (nonatomic,assign) BOOL flag;
/** 内容 */
@property (nonatomic,copy) NSString *conment;
/**  */
@property (nonatomic,copy) NSString *replyToUserNickName;
/** 1 朋友圈  2闲置物品处理 */
@property (nonatomic,assign) BOOL type;
/** <#房源信息#> */
@property (nonatomic,copy) NSString *replyToUserId;


/** 创建时间 */
@property (nonatomic,copy) NSString *createTime;

@end



/*
 
 resultCode = 1000,
	body = [
 {
	friendsRef = [
 {
	userNickName = 甲,
	headImage = 451ce3b26fef_img.jpg,
	replyToUserHeadImage = ,
	id = 1,
	targetId = 1,
	userid = 13,
	flag = 0,
	conment = ,
	replyToUserNickName = ,
	type = 2,
	replyToUserId = 1
 },
 
 */
