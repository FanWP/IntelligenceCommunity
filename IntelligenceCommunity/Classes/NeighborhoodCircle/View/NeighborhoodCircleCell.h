//
//  NeighborhoodCircleCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeighborhoodCircleCell;

@protocol NeighborhoodCircleCellDelegate <NSObject>

@optional
-(void)neighborhoodCircleCell:(NeighborhoodCircleCell *)neighborhoodCircleCell clickButtonWithTag:(NSInteger)tag;

@end


@interface NeighborhoodCircleCell : UITableViewCell

//用户头像
@property(nonatomic,strong) UIImageView *userImageView;
//用户名
@property(nonatomic,strong) UILabel *userNameLabel;
//发布时间
@property(nonatomic,strong) UILabel *uploadTimeLabel;
//对话按钮
@property(nonatomic,strong) UIButton *dialogueButton;
//图片
@property(nonatomic,strong) UIImageView *imageView_1;
@property(nonatomic,strong) UIImageView *imageView_2;
@property(nonatomic,strong) UIImageView *imageView_3;

//动态内容
@property(nonatomic,strong) UILabel *dynamicLabel;

//点赞、评论
@property(nonatomic,strong) UIButton *thumbUpButton;
@property(nonatomic,strong) UIButton *commentsButton;

//代理
@property(nonatomic,weak) id<NeighborhoodCircleCellDelegate>delegate;

@end
