//
//  FreeArticleViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleViewController.h"
#import "CommunityCell.h"
#import "FreeArticleHeaderView.h"  //单元格顶部的发布详情


#import "SearchViewController.h"    //关键字搜索
#import "FreeArticleDetailTableVC.h" //闲置物品详情


#import "FreeArticleModel.h"

NSString *const communityCellIdentifier = @"communityCellIdentifier";

@interface FreeArticleViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UISearchBar *searchBar;     //搜索栏
@property(nonatomic,retain) NSString *keywordSearchString;  //关键字

/** 接收到的服务器返回的数据数组 */
@property (nonatomic,strong) NSMutableArray *FreeArticleArr;

/** 每页显示多少条数据 */
@property (nonatomic,assign) NSInteger pageSize;
/** 当前页 */
@property (nonatomic,assign) NSInteger pageNum;

@end

@implementation FreeArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];

    self.title = @"闲置物品处理";
    [self defaultViewStyle];

    [self initializeComponent];
    
    
    [self setupRefresh];
    
    //添加搜索框
    [self addSearchBar];

    
    [self setupRightBar];
    
}


-(void)addSearchBar
{
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(10, 64, KWidth - 20, 44)];
    searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 15.6, searchView.width, 28)];
    _searchBar.placeholder = @"搜索";
    _searchBar.backgroundColor = [UIColor grayColor];
    _searchBar.delegate = self;
    [searchView addSubview:_searchBar];
}

#pragma mark ==========/** 添加上下拉数据 */============
/** 添加上下拉数据 */
- (void)setupRefresh
{

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewFreeArticle)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreFreeArticle)];
}


//下拉刷新
-(void)loadNewFreeArticle
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
    
    
    NSString*url = @"find/sellingThings/list";
    
    [[RequestManager manager] JSONRequestWithType:Smart_community urlString:url method:RequestMethodPost timeout:30 parameters:parmas success:^(id  _Nullable responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        
        MJRefreshLog(@"闲置物品下拉显示成功：%@",responseObject);
        _FreeArticleArr = [FreeArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
        
        if (_FreeArticleArr.count > 0) {
            self.pageNum++;
            [self.tableView reloadData];
        }
        
    } faile:^(NSError * _Nullable error) {
        MJRefreshLog(@"闲置物品下拉失败:%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}

//上拉刷新
-(void)loadMoreFreeArticle
{
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userId"] = UserID;
    parmas[@"sessionId"] = SessionID;
    parmas[@"pageNum"] = @(self.pageNum);
    parmas[@"pageSize"] = @(self.pageSize);
    
    
    NSString*url = @"find/sellingThings/list";
    
    [[RequestManager manager] JSONRequestWithType:Smart_community urlString:url method:RequestMethodPost timeout:30 parameters:parmas success:^(id  _Nullable responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        MJRefreshLog(@"闲置物品加载更多显示成功：%@",responseObject);
        NSArray *arr = [FreeArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
        
        if (arr.count > 0) {
            [self.FreeArticleArr addObjectsFromArray:arr];
            self.pageNum++;
            [self.tableView reloadData];
        }
    } faile:^(NSError * _Nullable error) {
        MJRefreshLog(@"闲置物品加载更多失败:%@",error);
        
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}


- (void)setupRightBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
}


- (void)rightBarClick
{
    MJRefreshLog(@"rightBarClick");

}

-(void)action:(UIBarButtonItem *)sender{
    //预留
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.x = 0;
    _tableView.y = 44;
    _tableView.height = KHeight - _tableView.y;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CommunityCell class] forCellReuseIdentifier:communityCellIdentifier];
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
        return self.FreeArticleArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //设置假数据
    FreeArticleModel *model = _FreeArticleArr[section];
    return model.contentH + 200;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //设置假数据
    FreeArticleModel *model = _FreeArticleArr[section];
    FreeArticleHeaderView *header = [[FreeArticleHeaderView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 350)];
    header.freeArticleModel = model;
    header.nav = self.navigationController;
    return header;
    
    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置跳转并传入模型数据
    FreeArticleDetailTableVC *VC = [[FreeArticleDetailTableVC alloc] init];
    VC.model = self.FreeArticleArr[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
 
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    SearchViewController *searchController = [[SearchViewController alloc] init];
    
    searchController.searchBlock = ^(NSString *string){
        self.keywordSearchString = string;
        NSLog(@"%@",self.keywordSearchString);
        
    };
    
    
    [self.navigationController pushViewController:searchController animated:YES];
    return NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
