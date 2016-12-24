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
    if (_flag) {//评论
        
        NSString *reply = [NSString stringWithFormat:@"%@：%@",self.userNickName,self.conment];
        attrReply = [[NSMutableAttributedString alloc]initWithString:reply];
        
        [attrReply addAttributes:@{NSForegroundColorAttributeName : MJRefreshColor(75, 190, 43),
                                   NSFontAttributeName : UIFont13
                                   
                                   } range:[reply rangeOfString:self.userNickName]];
        [attrReply addAttributes:@{NSFontAttributeName : UIFont13} range:NSMakeRange(0, reply.length)];
        
    }else//回复
    {
        NSString *reply = [NSString stringWithFormat:@"%@回复%@：%@",self.userNickName,self.replyToUserNickName,self.conment];
        attrReply = [[NSMutableAttributedString alloc] initWithString:reply];
        [attrReply addAttributes:@{NSForegroundColorAttributeName : MJRefreshColor(75, 190, 43)} range:[reply rangeOfString:self.userNickName]];
        [attrReply addAttributes:@{NSForegroundColorAttributeName : MJRefreshColor(75, 190, 43)} range:[reply rangeOfString:self.replyToUserNickName]];
        [attrReply addAttributes:@{NSFontAttributeName : UIFont13} range:NSMakeRange(0, reply.length)];
    }
    return attrReply;
}


-(CGFloat)contentH
{
    CGSize maxSize = CGSizeMake(KWidth - 32, MAXFLOAT);
    
    CGFloat contentH = [self.attrText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    //    MJRefreshLog(@"contentH---:%f",contentH);
    
    return contentH;
    
}



@end
