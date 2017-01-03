//
//  FeeHistoryListHeaderFooterViewCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/30.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FeeHistoryListHeaderFooterViewCell;

@protocol FeeHistoryListHeaderFooterViewCellDelegate <NSObject>

@optional
-(void)FeeHistoryListHeaderFooterViewCell:(FeeHistoryListHeaderFooterViewCell*)headerViewCell didSelectAtSection:(NSInteger)section;

@end
//混合缴费列表
@interface FeeHistoryListHeaderFooterViewCell : UITableViewHeaderFooterView

@property(nonatomic,weak) id<FeeHistoryListHeaderFooterViewCellDelegate>delegate;
@property(nonatomic,assign) NSInteger section;
-(void)refreshArrowStatusWithExpand:(BOOL)isExpand;


@property(nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,strong) UILabel *moneyLabel;

@property(nonatomic,strong,readonly) UIImageView *arrowImageView;

@end
