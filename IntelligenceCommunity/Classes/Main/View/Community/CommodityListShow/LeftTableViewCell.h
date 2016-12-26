//
//  LeftTableViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftTableViewCell : UITableViewCell

//分类名称
@property(nonatomic,strong) UILabel *categoryTitleLabel;
//标记
@property(nonatomic,strong) UIView *remarkView;

@property (nonatomic, strong) UIView *redView;

@end
