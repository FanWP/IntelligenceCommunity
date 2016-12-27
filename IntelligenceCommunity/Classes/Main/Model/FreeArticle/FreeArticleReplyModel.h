//
//  FreeArticleReplyModel.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeArticleReplyModel : NSObject

/** 评论 */
@property (nonatomic,copy) NSString *conment;

/** 头像 */
@property (nonatomic,copy) NSString *headImage;

/** 用户的ID */
@property (nonatomic,copy) NSString *ID;

/** 回复评论目标的头像 */
@property (nonatomic,copy) NSString *replyToUserHeadImage;

/** replyToUserId */
@property (nonatomic,copy) NSString *replyToUserId;

/** 回复评论目标的昵称 */
@property (nonatomic,copy) NSString *replyToUserNickName;

/** 当前用户昵称 */
@property (nonatomic,copy) NSString *userNickName;

/** 当前用户id */
@property (nonatomic,copy) NSString *userid;

/** 目标用户id */
@property (nonatomic,copy) NSString *targetId;

/** 1 朋友圈  2闲置物品处理 */
@property (nonatomic,assign) NSInteger type;


/** 设置额外属性 */
@property (nonatomic,copy) NSMutableAttributedString *attrText;

/** 设置回复的高度 */
@property (nonatomic,assign) CGFloat contentH;

/** 设置评论还是回复  0-no-评论  1-yes-回复 */
@property (nonatomic,assign) BOOL flag;





@end
