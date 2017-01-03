//
//  ICPickView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ICPickViewDelegate <NSObject>
@optional
-(void)didFinishPickView:(NSString*)date;
-(void)pickerviewbuttonclick:(UIButton *)sender;
-(void)hiddenPickerView;

@end


@interface ICPickView : UIView

@property (nonatomic, copy) NSString *province;
@property(nonatomic,strong)NSDate*curDate;
@property (nonatomic,strong)UITextField *myTextField;
@property(nonatomic,weak)id<ICPickViewDelegate>delegate;

- (void)showInView:(UIView *)view;
- (void)hiddenPickerView;

@end
