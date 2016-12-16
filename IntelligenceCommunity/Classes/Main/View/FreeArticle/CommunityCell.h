//
//  CommunityCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>


//闲置物品主界面cell

@class MaterialsAreadlySaleView;


@class FreeArticleModel;

@interface CommunityCell : UITableViewCell

/** 传入cell的模型 */
@property (nonatomic,strong) FreeArticleModel *freeArticleModel;

@end
