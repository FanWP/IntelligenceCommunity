//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation HUD

+(void)dismiss {
    [SVProgressHUD dismiss];
}

+(void)showProgress:(CGFloat)progress message:(NSString*)message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showProgress:progress status:message];
}

+(void)showMessage:(NSString*)message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showInfoWithStatus:message];
}

+(void)showProgress:(NSString*)message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:message];
}

+(void)showErrorMessage:(NSString*)message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showErrorWithStatus:message];
}

+(void)showSuccessMessage:(NSString*)message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showSuccessWithStatus:message];
}

+(void)initConfig {
    [SVProgressHUD setMinimumDismissTimeInterval:3];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setRingNoTextRadius:18];
}

@end
