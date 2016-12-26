//
//  FreeArticleDetailTableVC.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/16.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleDetailTableVC.h"
#import "CommunityDetailCell.h"     // 闲置物品详情的cell
#import "FreeArticleModel.h"
#import "FreeArticleDetailTableViewImagesCell.h"



@interface FreeArticleDetailTableVC ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation FreeArticleDetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];

    self.title = @"物品详情";


}

-(void)setupheader
{
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 65)];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 76)];
    headerView.backgroundColor = [UIColor whiteColor];
    [header addSubview:headerView];
    
    /** 用户图像 */
    //    @property (nonatomic,weak) UIImageView *userImg;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(16, 8, 60, 60)];
    img.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    img.contentMode  = UIViewContentModeScaleAspectFill;
    img.layer.masksToBounds = YES;
    [img load:[NSString stringWithFormat:@"%@",self.model.headimage] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
    [headerView addSubview:img];
    
    /** 用户昵称 */
    //    @property (nonatomic,weak) UILabel *usernameLable;
    UILabel *username = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img.frame) + 12, 16, 150, 17)];
    username.text = self.model.nickName;
    username.font = UIFont17;
    [headerView addSubview:username];
    
    /** 创建时间 */
    //    @property (nonatomic,weak) UILabel *creattimeLable;
    UILabel *creattime = [[UILabel alloc] initWithFrame:CGRectMake(username.x, headerView.height - 21, 150, 13)];
    creattime.text = self.model.createTime;
    creattime.font = UIFont13;
    creattime.textColor = [UIColor grayColor];
    [headerView addSubview:creattime];
    
    /** 是否支持物品交换 */
    //    @property (nonatomic,weak) UILabel *isExchangeLable;
    UILabel *exchange = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - 150 - 16, headerView.height - 21, 150, 16)];
    exchange.centerY = img.centerY;
    exchange.text = @"支持物品交换";
    exchange.textAlignment = NSTextAlignmentRight;
    exchange.font = UIFontNormal;
    exchange.textColor = [UIColor orangeColor];
    exchange.hidden = self.model.change;
    [headerView addSubview:exchange];
    
    /** 内容 */
    //    @property (nonatomic,weak) UILabel *contentLable;
    CGSize maxSize = CGSizeMake(KWidth - 20, MAXFLOAT);
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(img.frame) + 12, KWidth - 24, 90)];
    content.height = [self.model.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : UIFont13} context:nil].size.height;
    content.text = self.model.content;
    content.font = UIFont13;
    content.numberOfLines = 0;
    content.textColor = [UIColor blackColor];
    
    headerView.height = CGRectGetMaxY(content.frame);
    [headerView addSubview:content];
    
    
    self.tableView.tableHeaderView = headerView;

}



- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self setupheader];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.imagesArr.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 212;

    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    FreeArticleDetailTableViewImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[FreeArticleDetailTableViewImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    [cell.images load:[NSString stringWithFormat:@"%@%@",Smart_community_picURL,self.model.imagesArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
    
    return cell;
}




@end
