//
//  NeighborhoodModel.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/20.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodModel.h"
#import "NSDate+Extension.h"
#import "FreeArticleReplyModel.h"

#import "SmartCommunityPhotosView.h"

@implementation NeighborhoodModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};

}

+(NSDictionary *)mj_objectClassInArray
{
    
    return @{
             @"friendsRef":[FreeArticleReplyModel class]
             };
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


//标题
-(CGSize)titlewSize
{
    if (_titlewSize.width) return _titlewSize;
    CGSize titleSize = CGSizeMake(KWidth - 32, MAXFLOAT);
    CGSize  size = [_title boundingRectWithSize:titleSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : UIFont15} context:nil].size;
    return size;
}

-(CGSize)photosSize
{
    if (_photosSize.width) return _photosSize;
    NSArray *arr = [_images componentsSeparatedByString:@","];
    return  [SmartCommunityPhotosView sizeWithCount:arr.count];
}

-(CGSize)commenSize
{
    if (_commenSize.width) return _commenSize;
    CGSize titleSize = CGSizeMake(KWidth - 32, MAXFLOAT);
    CGSize  size = [_content boundingRectWithSize:titleSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : UIFontNormal} context:nil].size;
    return size;
}

-(CGSize)actionTimeSize
{
    if (_actionTimeSize.width) return _actionTimeSize;
    CGSize titleSize = CGSizeMake(KWidth - 32, MAXFLOAT);
    
    NSString *actiontimne = _actionTime;
    if (_actionTime) {
        actiontimne = [NSString stringWithFormat:@"地址：%@",_actionTime];
    }
    CGSize  size = [actiontimne boundingRectWithSize:titleSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : UIFontNormal} context:nil].size;
    return size;
}

-(CGSize)addressSize
{
    if (_addressSize.width) return _addressSize;
    CGSize titleSize = CGSizeMake(KWidth - 32, MAXFLOAT);
    
    NSString *address = _address;
    if (_address) {
     address = [NSString stringWithFormat:@"地址：%@",_address];
    }
    CGSize  size = [address boundingRectWithSize:titleSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : UIFontNormal} context:nil].size;
    _addressSize = size;
    return _addressSize;
}


-(CGFloat)allContentH
{
    if (_allContentH) return _allContentH;
    //顶部的头像
    CGFloat imgH = 45 + 24;
    
    //标题的高度
    CGFloat titleH = self.titlewSize.height  + 12;
    
    //中间的头像
    CGFloat photosH = self.photosSize.height + 12;
    
    //内容
    CGFloat contentH = self.commenSize.height + 8;
    
    //时间
    CGFloat timeH = 0;
    timeH = self.titlewSize.height + 8;

    
    //地点
    CGFloat addressH = 0;
    addressH  = self.addressSize.height ;

    
    
    //底部的三个按钮
    CGFloat btnsH = 38;

    _allContentH = imgH + titleH + photosH + contentH + timeH + addressH + btnsH;
    return _allContentH;

}




@end
