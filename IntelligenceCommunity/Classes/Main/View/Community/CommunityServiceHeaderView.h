//
//  CommunityServiceHeaderView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

//商品-commodity  方便--convenient  美食--delicacy  娱乐--entertainment

@class CommunityServiceHeaderView;

@protocol CommunityServiceHeaderViewDelegate <NSObject>

-(void)headerView:(CommunityServiceHeaderView *)headerView buttonWithTag:(NSInteger)tag;

@end

@interface CommunityServiceHeaderView : UITableViewHeaderFooterView

//商品
@property(nonatomic,strong) UIImageView *commodityImageView;
@property(nonatomic,strong) UILabel *commodityLabel;

//便民
@property(nonatomic,strong) UIImageView *convenientImageView;
@property(nonatomic,strong) UILabel *convenientLabel;

//美食
@property(nonatomic,strong) UIImageView *delicacyImageView;
@property(nonatomic,strong) UILabel *delicacyLabel;

//娱乐
@property(nonatomic,strong) UIImageView *entertainmentImageView;
@property(nonatomic,strong) UILabel *entertainmentLabel;

@property(nonatomic,weak) id<CommunityServiceHeaderViewDelegate> delegate;

@end
