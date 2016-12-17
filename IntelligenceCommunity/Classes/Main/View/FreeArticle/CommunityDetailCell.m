//
//  CommunityDetailCell.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/16.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommunityDetailCell.h"


@interface CommunityDetailCell ()


/** 用户图像 */
@property (nonatomic,weak) UIImageView *userImg;

/** 用户昵称 */
@property (nonatomic,weak) UILabel *usernameLable;

/** 创建时间 */
@property (nonatomic,weak) UILabel *creattimeLable;

/** 是否支持物品交换 */
@property (nonatomic,weak) UILabel *isExchangeLable;

/** 内容 */
@property (nonatomic,weak) UILabel *contentLable;

@end

@implementation CommunityDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    
    //设置子控件
    [self setupControls];

    return self;
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    CommunityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}


//初始话子控件
-(void)setupControls
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 76)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:headerView];
    
    /** 用户图像 */
//    @property (nonatomic,weak) UIImageView *userImg;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(16, 8, 60, 60)];
    img.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    img.contentMode  = UIViewContentModeScaleAspectFill;
    img.layer.masksToBounds = YES;
    self.userImg = img;
    [headerView addSubview:img];

    /** 用户昵称 */
//    @property (nonatomic,weak) UILabel *usernameLable;
    UILabel *username = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img.frame) + 12, 16, 150, 17)];
    username.text = @"咖啡小猫";
    username.font = UIFont17;
    self.usernameLable = username;
    [headerView addSubview:username];
    
    /** 创建时间 */
//    @property (nonatomic,weak) UILabel *creattimeLable;
    UILabel *creattime = [[UILabel alloc] initWithFrame:CGRectMake(username.x, headerView.height - 21, 150, 13)];
    creattime.text = @"2016-12-31 12:22:44";
    creattime.font = UIFont13;
    creattime.textColor = [UIColor grayColor];
    self.creattimeLable = creattime;
    [headerView addSubview:creattime];

    /** 是否支持物品交换 */
//    @property (nonatomic,weak) UILabel *isExchangeLable;
    UILabel *exchange = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - 150 - 16, headerView.height - 21, 150, 16)];
    exchange.centerY = img.centerY;
    exchange.text = @"支持物品交换";
    exchange.textAlignment = NSTextAlignmentRight;
    exchange.font = UIFontNormal;
    exchange.textColor = [UIColor orangeColor];
    self.isExchangeLable = exchange;
    [headerView addSubview:exchange];

    /** 内容 */
//    @property (nonatomic,weak) UILabel *contentLable;
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(img.frame) + 12, KWidth - 24, 90)];
    content.text = @"支持物品交换";
    content.font = UIFont13;
    content.textColor = [UIColor blackColor];
    self.contentLable = content;
    [headerView addSubview:content];
}





-(void)setModel:(FreeArticleModel *)model
{
    _model = model;
}


@end
