//
//  User.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CacheObject.h"

@interface User : CacheObject

@property NSString *name;           //用户名
@property NSString *password;       //密码
@property NSString *workState;
@property BOOL isLogout;            //是否登出
@property BOOL isEnableTouchID;     //是否进行安全验证

/**
 *  获取最后一个有登录记录的用户，以isLogout判断用户是否登录
 *
 *  @return 最后一个有登录记录的用户
 */
+(instancetype)currentUser;


#pragma mark--用户基本信息
@property NSString *account;
@property NSString *headimage;
@property NSString *birthday;
@property NSString *houseid;
@property NSString *username;
@property NSString *referee;
@property NSString *communityId;
@property NSString *telephone;
@property NSString *communityName;
@property NSString *nickname;
@property NSString *sex;
@property NSString *lasttime;
@property NSString *type;
@property NSString *userID;         //主键
@property NSString *email;
@property NSString *houseRole;
@property NSString *viplevel;
@property NSString *identity;
@property NSString *passwd;
@property NSString *createtime;
@property NSString *address;
@property NSString *userDescription;

@property NSString *sessionId;

@end

/*
    account = 18092456642,
	headimage = ,
	birthday = 1990,
	houseid = 1,
	username = 卫平,
	referee = 钟会,
	communityId = 0,
	telephone = 18092456642,
	communityName = ,
	nickname = 小樊,
	sex = 1,
	lasttime = ,
	type = 2,
	id = 30,
	email = ,
	houseRole = 0,
	viplevel = 0,
	identity = 612522199008066533,
	passwd = ,
	createtime = 2016-12-24 16:44:49,
	address = 西安市莲湖区,
	description = 按时打算打算打算

 sessionId = 46E42155FD1D858C42563E7331F209DFD31D5AB2B24F7ED3609C0940D14962E1,

 */
