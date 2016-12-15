//
//  YYTextView.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYTextView : UITextView

/**  占位文字*/
@property(nonatomic,copy)NSString *placeholder;
/**  占位文字的颜色*/
@property(nonatomic,strong)UIColor *placeholderColor;

@end
