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
#import "FreeArticleReplyCell.h"   //底部评论的cell


#import "SearchViewController.h"    //关键字搜索
#import "FreeArticleDetailTableVC.h" //闲置物品详情
#import "FreeArticleAddViewController.h" //闲置物品添加


#import "FreeArticleModel.h"
#import "FreeArticleReplyModel.h"

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

//评论回复
/** 回复的输入框 */
@property (nonatomic,weak) UIView *replyView;
/** 回复的输入框 */
@property (nonatomic,weak) UITextView *replyTextView;
/** 回复消息的模型 */
@property (nonatomic,strong) FreeArticleReplyModel *replyModel;
/** 发送按钮 */
@property (nonatomic,weak) UIButton *sendBtn;
/** 评论对应的模型 */
@property (nonatomic,strong) FreeArticleModel *commonModel;

/** 标记设置回复或者是评论 isReply  是否是回复 */
@property (nonatomic,assign) BOOL isReply;


@end

@implementation FreeArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self defaultViewStyle];

    self.title = @"闲置物品处理";
    [self defaultViewStyle];

    [self initializeComponent];

    [self setupRefresh];
    
    //添加搜索框
    [self addSearchBar];

    [self setupRightBar];

    //监听键盘
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //监听文本框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [HUD dismiss];

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
    parmas[@"type"] = @"2";//1是闲置物品 2是邻里圈
    
    MJRefreshLog(@"parmas---:%@",parmas);
    
    NSString*newurl = [NSString stringWithFormat:@"%@smart_community/find/sellingThings/list",Smart_community_URL];
    
    
    [[AFHTTPSessionManager manager] POST:newurl parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        MJRefreshLog(@"闲置物品下拉显示成功：%@",responseObject);

//        //把数据保存到沙盒里的plist文件
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *plistPath1= [paths objectAtIndex:0];
//        
//        NSLog(@"%@",plistPath1);
//        //得到完整的路径名
//        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"cityCode.plist"];
//
//        NSFileManager *fm = [NSFileManager defaultManager];
//        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
//            
//            [responseObject writeToFile:fileName atomically:YES];
//            NSLog(@"文件写入完成");
//        }

        _FreeArticleArr = [FreeArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
        
        if (_FreeArticleArr.count > 0) {
            self.pageNum++;
            [self.tableView reloadData];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
    parmas[@"type"] = @"2";//1是闲置物品 2是邻里圈
    
    MJRefreshLog(@"parmas---:%@",parmas);
    NSString*newurl = [NSString stringWithFormat:@"%@smart_community/find/sellingThings/list",Smart_community_URL];
    
    [[AFHTTPSessionManager manager]POST:newurl parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        MJRefreshLog(@"闲置物品加载更多显示成功：%@",responseObject);
        NSArray *arr = [FreeArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
        
        if (arr.count > 0) {
            [self.FreeArticleArr addObjectsFromArray:arr];
            self.pageNum++;
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
    FreeArticleAddViewController *VC= [[FreeArticleAddViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

}

-(void)action:(UIBarButtonItem *)sender{
    //预留
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    
    //设置数据
    FreeArticleModel *model = _FreeArticleArr[section];
    return model.friendsRefList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //设置数据
    FreeArticleModel *model = _FreeArticleArr[indexPath.section];
    FreeArticleReplyModel *replyModel = model.friendsRefList[indexPath.row];
    return replyModel.contentH + 10;
    
    
//    FreeArticleReplyModel *modelReply = [[FreeArticleReplyModel alloc] init];
//    modelReply.userNickName = @"我也是醉了";
//    modelReply.flag = YES;
//    modelReply.replyToUserNickName = @"你就是醉了";
//    modelReply.conment = @"你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了";
//    return modelReply.contentH + 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //设置数据
    FreeArticleModel *model = _FreeArticleArr[section];
    return model.contentH + 190;
}

//设置底部分割线的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

//顶部的用户头像和内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    
    //设置数据
    FreeArticleModel *model = _FreeArticleArr[section];
    FreeArticleHeaderView *header = [[FreeArticleHeaderView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 350)];
    header.commentsButton.tag = section;
    [header.commentsButton addTarget:self action:@selector(commentsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    header.freeArticleModel = model;
    header.nav = self.navigationController;
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *footer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 8)];
//    footer.backgroundColor = MJRefreshColor(238, 238, 238);
    footer.backgroundColor = [UIColor lightGrayColor];
    return footer;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FreeArticleReplyCell *cell = [FreeArticleReplyCell cellWithTableView:tableView];
    
    FreeArticleModel *model = _FreeArticleArr[indexPath.section];
    cell.replyModel = model.friendsRefList[indexPath.row];
    
    
    
//    FreeArticleReplyModel *modelReply = [[FreeArticleReplyModel alloc] init];
//    modelReply.userNickName = @"我也是醉了";
//    modelReply.flag = YES;
//    modelReply.replyToUserNickName = @"你就是醉了";
//    modelReply.conment = @"你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了你真的是醉了";
//        cell.replyModel = modelReply;
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [self.replyView removeFromSuperview];

}


#pragma mark===== 回复评论=============


-(void)commentsButtonClick:(UIButton *)button
{
    self.commonModel = _FreeArticleArr[button.tag];
    
    self.isReply = NO;
    //创建并弹出键盘
    [self setupKeyboard];
    
}


-(void)textDidChange
{
    self.sendBtn.enabled = [self.replyTextView hasText];
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


//点击回复评论
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FreeArticleModel *model = _FreeArticleArr[indexPath.section];
    _replyModel = model.friendsRefList[indexPath.row];
    
    if ([_replyModel.userid isEqualToString:UserID]) {//自己给自己回复
        [HUD showErrorMessage:@"您不能给自己回复！"];
        [self.replyView removeFromSuperview];
        MJRefreshLog(@"自己");
        _replyModel = nil;
        return;
    }else
    {
        //创建并弹出键盘
        self.isReply = YES;
        [self setupKeyboard];
    }
}


//发送按钮的点击事件
-(void)sendBtnClick:(UIButton *)button
{
    [self.view endEditing:YES];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userId"] = UserID;
    parmas[@"sessionid"] = SessionID;
    parmas[@"type"] = @"2";
    parmas[@"conment"] = self.replyTextView.text;
    
    //判断是回复还是评论
    if (_isReply) {//回复
        parmas[@"targetId"] = self.replyModel.targetId;
        parmas[@"replyToUserId"] = self.replyModel.userid;
    }else //评论
    {
        parmas[@"targetId"] = self.commonModel.ID;
//        parmas[@"replyToUserId"] = @"0";
    }
    
    NSString *url = [NSString stringWithFormat:@"%@smart_community/save/update/friendsRef",Smart_community_URL];
    MJRefreshLog(@"parmas--:%@url---:%@",parmas,url);
    
    [HUD showMessage:@"数据提交中"];
    [[AFHTTPSessionManager manager]POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MJRefreshLog(@"responseObject---%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        if ([num integerValue] == 1000) {//发布成功
            [self.replyView removeFromSuperview];
            [HUD showSuccessMessage:@"发布成功"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MJRefreshLog(@"error---%@",error);
    }];

}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark=====创建输入框，弹出键盘======
-(void)setupKeyboard
{
    [self.replyView removeFromSuperview];
    
    
    UIView *replyView = [[UIView alloc] initWithFrame:CGRectMake(0,KHeight -  216  - 44, KWidth, 44)];
    replyView.backgroundColor = [UIColor whiteColor];
    self.replyView = replyView;
    [self.view addSubview:replyView];
    
    //设置输入框
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KWidth - 80, 34)];
    textView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.replyTextView = textView;
    textView.backgroundColor = [UIColor clearColor];
    textView.font = UIFontLarge;
    
    [replyView addSubview:textView];

    
    [textView becomeFirstResponder];
    
    //设置都发送按钮
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWidth - 80, 0, 80, 44)];
    sendBtn.backgroundColor = [UIColor redColor];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    sendBtn.enabled = NO;
    self.sendBtn = sendBtn;
    [sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:sendBtn];
}



@end
