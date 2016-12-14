//
//  HeaderView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

//宣传片
@property(nonatomic,strong) UIImageView *videoImageView;

//公告图片
@property(nonatomic,strong) UIImageView *noticeImageView;

//公告信息
@property(nonatomic,strong) UILabel *noticeLabel;
//公告内容
@property(nonatomic,copy) NSString *noticeContentString;

@end
