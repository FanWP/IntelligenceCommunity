//
//  FreeArticleHeaderView.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//
//  cell上面的配图相册（里面会显示1~9张图片, 里面都是uiimageView）

#import <UIKit/UIKit.h>

@interface SmartCommunityPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片个数计算相册的尺寸
 */
+ (CGSize)sizeWithCount:(NSUInteger)count;
@end
