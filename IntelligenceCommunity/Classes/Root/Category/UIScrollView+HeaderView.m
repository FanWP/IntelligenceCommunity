//
//  CellModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "UIScrollView+HeaderView.h"

@implementation UIScrollView (HeaderView)

static char const headerViewKey = '\0';

-(void)setHeaderView:(UIView *)headerView {
    if(headerView) {
        CGRect frame = headerView.frame;
        frame.origin.y = -CGRectGetHeight(frame);
        headerView.frame = frame;
        [self addSubview:headerView];
        self.contentInset = UIEdgeInsetsMake(frame.size.height, 0, 0, 0);
        self.scrollIndicatorInsets = UIEdgeInsetsMake(frame.size.height, 0, 0, 0);
    } else if(self.headerView && !headerView) {
        [self.headerView removeFromSuperview];
    }
    
    objc_setAssociatedObject(self, &headerViewKey, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)headerView {
    return objc_getAssociatedObject(self, &headerViewKey);
}

@end
