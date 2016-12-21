//
//  NeighborhoodCircleCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeighborhoodCircleCell;

@class NeighborhoodModel;
@protocol NeighborhoodCircleCellDelegate <NSObject>

@optional
-(void)neighborhoodCircleCell:(NeighborhoodCircleCell *)neighborhoodCircleCell clickButtonWithTag:(NSInteger)tag;
@end



@interface NeighborhoodCircleCell : UITableViewCell

/** 传入的模型 */
@property (nonatomic,strong) NeighborhoodModel *neiborhoodModel;

//代理
@property(nonatomic,weak) id<NeighborhoodCircleCellDelegate>delegate;

@end
