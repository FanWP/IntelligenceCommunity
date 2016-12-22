//
//  RepairModel.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

// 报修模型
@interface RepairModel : NSObject

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *repairId;
@property (nonatomic,copy) NSString *replyUserid;
@property (nonatomic,copy) NSString *userid;

@end
