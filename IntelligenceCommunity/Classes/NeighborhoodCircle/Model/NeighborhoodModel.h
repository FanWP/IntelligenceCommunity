//
//  NeighborhoodModel.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/20.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NeighborhoodModel : NSObject

/** 活动的主题 */
@property (nonatomic,copy) NSString *title;

/** 当前用户昵称 */
@property (nonatomic,copy) NSString *userNickName;
/** 头像 */
@property (nonatomic,copy) NSString *headImage;

/** 图片 */
@property (nonatomic,copy) NSString *images;

/** 回复评论目标的头像 */
@property (nonatomic,copy) NSString *replyToUserHeadImage;
/** ID */
@property (nonatomic,copy) NSString *ID;
/** 目标用户ID */
@property (nonatomic,copy) NSString *targetId;
/** 用户的ID */
@property (nonatomic,copy) NSString *userid;
/** 设置评论还是回复  0-no-评论  1-yes-回复 */
@property (nonatomic,assign) BOOL flag;
/** 内容 */
@property (nonatomic,copy) NSString *content;
/** 1 约 */
@property (nonatomic,copy) NSString *replyToUserNickName;
/** 1 约 2生活分享 3寻物招领 不传就是查询所有 */
@property (nonatomic,assign) NSInteger type;
/** <#房源信息#> */
@property (nonatomic,copy) NSString *replyToUserId;

/** <#房源信息#> */
@property (nonatomic,copy) NSString *likeUserid;




/** 创建时间 */
@property (nonatomic,copy) NSString *createtime;
/** 约活动的时间 */
@property (nonatomic,copy) NSString *actionTime;
/** 约活动的地点 */
@property (nonatomic,copy) NSString *address;

/** <#Class#> */
@property (nonatomic,assign) NSInteger number;


/** 评论的数组 */
@property (nonatomic,strong) NSMutableArray *friendsRef;







/** 额外属性*/

/** 标题的尺寸 */
@property (nonatomic,assign) CGSize titlewSize;
/** 图像的尺寸 */
@property (nonatomic,assign) CGSize photosSize;
/** 内容的尺寸 */
@property (nonatomic,assign) CGSize commenSize;
/** 时间的尺寸 */
@property (nonatomic,assign) CGSize actionTimeSize;
/** 地点的尺寸 */
@property (nonatomic,assign) CGSize addressSize;

/** 计算所有内容的高度 */
@property (nonatomic,assign) CGFloat allContentH;


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
