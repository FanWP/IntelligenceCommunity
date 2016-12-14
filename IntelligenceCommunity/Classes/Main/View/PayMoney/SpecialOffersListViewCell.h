//
//  SpecialOffersListViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

//优惠信息列表
@class SpecialOffersListViewCell;

@protocol SpecialOffersListViewCellDelegate <NSObject>

-(void)userSelectButtonWithSpecialOffersListViewCell:(SpecialOffersListViewCell *)cell;

@end


//优惠信息
@interface SpecialOffersListViewCell : UITableViewCell

//   edit_time_normal   edit_time_pressed
//@property(nonatomic,strong) UIImageView *selectimageView;
@property(nonatomic,strong) UIButton *selectButton;

//优惠信息详情
@property(nonatomic,strong) UILabel *specialOffersDetailLabel;

@property(nonatomic,weak) id<SpecialOffersListViewCellDelegate>delegate;

@end
