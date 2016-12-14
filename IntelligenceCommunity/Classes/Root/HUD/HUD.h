//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface HUD : NSObject

+(void)dismiss;
+(void)showProgress:(CGFloat)progress message:(NSString*)message;
+(void)showMessage:(NSString*)message;
+(void)showProgress:(NSString*)message;
+(void)showErrorMessage:(NSString*)message;
+(void)showSuccessMessage:(NSString*)message;
+(void)initConfig;

@end
