//
//  NoticeCell.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

//公告
@interface NoticeCell : UITableViewCell

//公告图片
@property(nonatomic,strong) UIImageView *noticeCellImageView;

//公告
@property(nonatomic,strong) UILabel *noticeCellLabel;

//公告内容
@property(nonatomic,strong) UILabel *noticeCellContentLabel;

//公告内容
@property(nonatomic,copy) NSString *noticeCellContentString;

@end
