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
    
    MJRefreshLog(@"parmas---:%@",parmas);
    
    NSString*newurl = [NSString stringWithFormat:@"%@smart_community/find/friendsCircle/list",Smart_community_URL];
    
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//-(void)neighborhoodCircleCell:(NeighborhoodCircleCell *)neighborhoodCircleCell clickButtonWithTag:(NSInteger)tag{
//    if (tag == 1) {
//        NSLog(@"点击了对话按钮");
//    }else if (tag == 2){
//        NSLog(@"点击了点赞按钮");
//        neighborhoodCircleCell.thumbUpButton.selected = !neighborhoodCircleCell.thumbUpButton.selected;
//        if (neighborhoodCircleCell.thumbUpButton.selected) {
//        }else{
//        }
//    }else if (tag == 3){
//        NSLog(@"点击了评论按钮");
//    }
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:neighborhoodCircleCell];
//    NSLog(@"indexPath.row===%ld",indexPath.row);
//}

#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 260;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return _NeighborhoodArr.count;
    
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NeighborhoodCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:NeighborhoodCircleCellID  forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row == 0) {
//        cell.userNameLabel.text = @"咖啡小猫";
    }else{
//        cell.userNameLabel.text = @"咖啡大猫";
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ICLog_2(@"%ld",indexPath.row);
}


@end
