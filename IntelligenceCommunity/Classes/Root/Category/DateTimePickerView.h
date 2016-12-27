//
//  DateTimePickerView.h
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/27.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    
    // 开始日期
    DateTimeTypeOfStart = 0,
    
    // 结束日期
    DateTimeTypeOfEnd,
    
}DateTimeType;


@protocol DateTimePickerViewDelegate <NSObject>

/**
 *  选择日期确定后的代理事件
 *
 *  @param date 日期
 *  @param type 时间选择器状态
 */
- (void)getSelectDateTime:(NSString *)date type:(DateTimeType)type button:(UIButton *)button;



@end


@interface DateTimePickerView : UIView


+(instancetype)initWithDateTimePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (nonatomic, weak) id<DateTimePickerViewDelegate> delegate;

@property (nonatomic, assign) DateTimeType type;

@end
