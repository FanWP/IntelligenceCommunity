//
//  ChangePWDVC.h
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePWDVC : UIViewController

// 新密码
@property (nonatomic,strong) UILabel *changedPWDLabel;
@property (nonatomic,strong) UITextField *changedPWDTF;
// 确认密码
@property (nonatomic,strong) UILabel *okChangedLabel;
@property (nonatomic,strong) UITextField *okChangedTF;

@end
