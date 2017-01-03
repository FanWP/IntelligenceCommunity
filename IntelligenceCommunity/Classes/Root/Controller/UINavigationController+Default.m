//
//  UINavigationController+Default.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "UINavigationController+Default.h"


@implementation UINavigationController (Default)

- (void) defaultNavigationBarStyle {
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.translucent = YES;
//    self.navigationBar.tintColor = ThemeColor;
    self.navigationBar.tintColor = MJRefreshColor(122, 122, 122);
    //    self.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor blackColor]};
    
    [self.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = nil;
    
    self.navigationBar.backIndicatorImage = [[UIImage imageNamed:@"Root_Back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"Root_Back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationBar.barTintColor = MJRefreshColor(246, 246, 246);
}

- (void) setBackgroundColor:(UIColor*)color {
    UIImage *image = [self imageWithFrame:CGRectMake(0, 0, ScreenWidth, 3) color:color];
    [self.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (UIImage*) imageWithFrame:(CGRect)frame color:(UIColor*)color {
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
