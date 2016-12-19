//
//  FreeArticleReplyModel.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleReplyModel.h"

@implementation FreeArticleReplyModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{

    return @{
             
             @"ID" : @"id"
             
             };

}


-(NSMutableAttributedString *)attrText
{
    
    NSMutableAttributedString *attrReply = [[NSMutableAttributedString alloc] init];
    if (self.replyToUserNickName == nil || self.replyToUserNickName.length == 0) {//评论
        
        NSString *reply = [NSString stringWithFormat:@"%@%@",self.userNickName,self.conment];
        attrReply = [[NSMutableAttributedString alloc]initWithString:reply];
        
        [attrReply addAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor],
                                   NSFontAttributeName : UIFont13
                                   
                                   } range:[reply rangeOfString:self.userNickName]];

    }else//回复
    {
        NSString *reply = [NSString stringWithFormat:@"%@回复%@：%@",self.userNickName,self.replyToUserNickName,self.conment];
        attrReply = [[NSMutableAttributedString alloc] initWithString:reply];
        [attrReply addAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} range:[reply rangeOfString:self.userNickName]];
        [attrReply addAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} range:[reply rangeOfString:self.replyToUserNickName]];
        
    }

    return attrReply;

}


-(CGFloat)contentH
{
    CGSize maxSize = CGSizeMake(KWidth - 32, MAXFLOAT);
    
    CGFloat contentH = [self.attrText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    return contentH;

}



@end
