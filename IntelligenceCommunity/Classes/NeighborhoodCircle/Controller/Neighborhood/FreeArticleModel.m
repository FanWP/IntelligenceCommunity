//
//  FreeArticleModel.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//  限制物品的接收模型

#import "FreeArticleModel.h"
#import "NSDate+Extension.h"
#import "SmartCommunityPhotosView.h"

@implementation FreeArticleModel


+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"ID" : @"id" };

}


-(NSArray *)imagesArr
{
    if (!_imagesArr) {
        
        NSArray *arr = [self.images componentsSeparatedByString:@","];
        _imagesArr = arr;
    }
    return _imagesArr;
}


-(CGFloat)contentH
{
    //计算文字内容的高度
    if (!_contentH)
    {
        CGSize maxSize = CGSizeMake(KWidth - 20, MAXFLOAT);
        
        //计算图片的高度
        CGFloat imageH = [SmartCommunityPhotosView sizeWithCount:self.imagesArr.count].height;
        
        NSString *str = _content;
        
        CGFloat textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : UIFont15} context:nil].size.height;
        
//        _contentH = imageH + textH + 115;
        _contentH = textH + 115;
//        MJRefreshLog(@"contentH--%f",_contentH);
        
    }
    return _contentH;
}


-(NSString *)createTime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    _created_at = @"Tue Sep 30 17:06:25 +0600 2014";
    // 	createTime = 2016-12-29 14:19:03,
    
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_createTime];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }


}


@end
