//
//  NeighborhoodMainCommonTableVC.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodMainCommonTableVC.h"
#import "NeighborhoodCircleCell.h"

#import "NeighborhoodModel.h"
#import "FreeArticleReplyModel.h"

#import "NeiborhoodHeaderView.h"
#import "FreeArticleReplyCell.h"



NSString *const NeighborhoodCircleCellID = @"neighborhoodCircleCellIdentifier";


@interface NeighborhoodMainCommonTableVC ()<NeighborhoodCircleCellDelegate>

/** 保存服务器返回的邻里圈列表数据 */
@property (nonatomic,strong) NSMutableArray *NeighborhoodArr;
/** 每页显示多少条数据 */
@property (nonatomic,assign) NSInteger pageSize;
/** 当前页 */
@property (nonatomic,assign) NSInteger pageNum;


@end

@implementation NeighborhoodMainCommonTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    
    [self.tableView registerClass:[NeighborhoodCircleCell class] forCellReuseIdentifier:NeighborhoodCircleCellID];
}


-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewNeighborhood)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNeighborhood)];
}

-(void)loadNewNeighborhood
{
    
    //结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    self.pageSize = 10;
    self.pageNum = 1;
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userId"] = UserID;
    parmas[@"sessionId"] = SessionID;
    parmas[@"pageNum"] = @(self.pageNum);
    parmas[@"pageSize"] = @(self.pageSize);
    if (self.NeighborhoodType != 0) {
        parmas[@"type"] = @(self.NeighborhoodType);
    }
    
    
    NSString*newurl = [NSString stringWithFormat:@"%@smart_community/find/friendsCircle/list",Smart_community_URL];
    
    MJRefreshLog(@"邻里圈下拉parmas%@--：url——---:%@",parmas,newurl);
    
    [[AFHTTPSessionManager manager] POST:newurl parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        MJRefreshLog(@"邻里圈下拉显示成功：%@",responseObject);
        
        //把数据保存到沙盒里的plist文件
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        
        NSLog(@"%@",plistPath1);
        //得到完整的路径名
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"linliCode.plist"];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            
            [responseObject writeToFile:fileName atomically:YES];
            NSLog(@"文件写入完成");
        }
        
        _NeighborhoodArr = [NeighborhoodModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
        
        if (_NeighborhoodArr.count > 0) {
            self.pageNum++;
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MJRefreshLog(@"邻里圈下拉失败:%@",error);
        [self.tableView.mj_header endRefreshing];
        
    }];

}

-(void)loadMoreNeighborhood
{
    
    
}





#pragma mark--delegate



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _NeighborhoodArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NeighborhoodModel *model = _NeighborhoodArr[section];
    NSArray *arr = model.friendsRef;
    
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    //设置数据
    NeighborhoodModel *model = _NeighborhoodArr[indexPath.section];
    FreeArticleReplyModel *replyModel = model.friendsRef[indexPath.row];
    return replyModel.contentH + 10;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NeighborhoodModel *model = _NeighborhoodArr[section];

//    NeighborhoodModel *model = [[NeighborhoodModel alloc] init];
//    model.images = @"805288420863245";
//    if (section == 1) {
//        model.images = @"88080880,3245";
//    }else if (section == 2) {
//        model.images = @"80528,84880,3245";
//    }else if (section == 3){
//        model.images = @"8052808,0,880,3245";
//    }else if (section == 4){
//        model.images = @"8052808,0,8,80,3245";
//    }
//    model.title = @"作为一项苹果独立发布的支持型开发语言，已经有了数个应用演示及合作开发公司的测试，相信将在未来得到更广泛的应用。某种意义上Swift作为苹果的新商业战略，将吸引更多的开发者入门，从而增强App Store和Mac Store本来就已经实力雄厚的应用数量基础。";
//    model.userNickName = @"大猫爱小雨";
//    model.createTime = @"2016-12-19 15:11:36";
//    model.content = @"Swift是苹果公司在WWDC2014上发布的全新开发语言。从演示视频及随后在appstore上线的标准文档看来，语法内容混合了OC,JS,Python，语法简单，使用方便，并可与OC混合使用。";
//    model.actionTime = @"周天周天晚上周天晚上周天晚----=上周天晚上周天晚上周天晚上晚上";
//    model.address = @"财富上周天晚上周天晚----=上周天晚上周天晚上周天中心";
//        return model.allContentH - 75;

    return model.allContentH ;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 8)];
//    imgView.backgroundColor = MJRefreshColor(238, 238, 238);
    imgView.backgroundColor = [UIColor lightGrayColor];
    
    return imgView;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NeiborhoodHeaderView *header = [NeiborhoodHeaderView headerWithTableView:tableView];
    
    NeighborhoodModel *model = _NeighborhoodArr[section];
//    NeighborhoodModel *model = [[NeighborhoodModel alloc] init];
//    model.images = @"805288420863245";
//    if (section == 1) {
//        model.images = @"88080880,3245";
//    }else if (section == 2) {
//        model.images = @"80528,84880,3245";
//    }else if (section == 3){
//        model.images = @"8052808,0,880,3245";
//    }else if (section == 4){
//        model.images = @"8052808,0,8,80,3245";
//    }
//    model.title = @"作为一项苹果独立发布的支持型开发语言，已经有了数个应用演示及合作开发公司的测试，相信将在未来得到更广泛的应用。某种意义上Swift作为苹果的新商业战略，将吸引更多的开发者入门，从而增强App Store和Mac Store本来就已经实力雄厚的应用数量基础。";
//    model.userNickName = @"大猫爱小雨";
//    model.createTime = @"2016-12-19 15:11:36";
//    model.content = @"Swift是苹果公司在WWDC2014上发布的全新开发语言。从演示视频及随后在appstore上线的标准文档看来，语法内容混合了OC,JS,Python，语法简单，使用方便，并可与OC混合使用。";
//    model.actionTime = @"周天周天晚上周天晚上周天晚----=上周天晚上周天晚上周天晚上晚上";
//    model.address = @"财富上周天晚上周天晚----=上周天晚上周天晚上周天中心";
    
    header.neiborhoodModel = model;

    return header;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FreeArticleReplyCell *cell = [FreeArticleReplyCell cellWithTableView:tableView];
    NeighborhoodModel *model = _NeighborhoodArr[indexPath.section];
    cell.replyModel = model.friendsRef[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ICLog_2(@"%ld",indexPath.row);
}


@end
