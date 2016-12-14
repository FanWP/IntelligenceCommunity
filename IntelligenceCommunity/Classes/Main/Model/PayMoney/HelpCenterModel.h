//
//  HelpCenterModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/1.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpCenterModel : NSObject

@property(nonatomic,copy) NSString *answer;   //回答

@property(nonatomic,copy) NSString *createtime; //时间

@property(nonatomic,copy) NSString *question;   //问题

@end

/*{
    answer = "\U7b54\Uff1a\U6253\U5f00\U624b\U673a\Uff0c\U7136\U540e\U6309\U7f34\U8d39\U6309\U94ae\Uff0c\U7136\U540e\U4ed8\U6b3e\U5c31\U884c";
    createtime = "2016-11-30 11:04:18";
    question = "\U5982\U4f55\U5728\U624b\U673a\U4e0a\U8fdb\U884c\U7f34\U8d39";
 }
 */

