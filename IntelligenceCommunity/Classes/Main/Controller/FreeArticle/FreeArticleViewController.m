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

/** 记录当前单元格对应的组号，在评论或者回复成功的时候刷新调用 */
@property (nonatomic,assign) NSInteger currentSession;


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
   // [self addSearchBar];

    [self setupRightBar];

    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
    self.pageNum = 1;
    self.pageSize = 10;

    if (!_freeArticleURL && !_parmas) {
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        parmas[@"userId"] = UserID;
        parmas[@"sessionId"] = SessionID;
        parmas[@"pageSize"] = @(self.pageSize);
        parmas[@"type"] = @"2";//1是闲置物品 2是邻里圈
        self.parmas = parmas;
        
        NSString*newurl = [NSString stringWithFormat:@"%@smart_community/find/sellingThings/list",Smart_community_URL];
        self.freeArticleURL = newurl;
    }
    self.parmas[@"pageNum"] = @(self.pageNum);
    
    MJRefreshLog(@"self.parmas,self--:%@self.freeArticleURL--:%@",self.parmas,self.freeArticleURL);
    
    
    [[AFHTTPSessionManager manager] POST:self.freeArticleURL parameters:self.parmas progress:^(NSProgress * _Nonnull uploadProgress) {
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
    
    
    if (!_freeArticleURL && !_parmas) {
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        parmas[@"userId"] = UserID;
        parmas[@"sessionId"] = SessionID;
        parmas[@"pageNum"] = @(self.pageNum);
        parmas[@"pageSize"] = @(self.pageSize);
        parmas[@"type"] = @"2";//1是闲置物品 2是邻里圈
        self.parmas = parmas;
        
        NSString*newurl = [NSString stringWithFormat:@"%@smart_community/find/sellingThings/list",Smart_community_URL];
        self.freeArticleURL = newurl;
    }
    
    MJRefreshLog(@"self.parmas,self--:%@self.freeArticleURL--:%@",self.parmas,self.freeArticleURL);
    
    
    [[AFHTTPSessionManager manager]POST:self.freeArticleURL parameters:self.parmas progress:^(NSProgress * _Nonnull uploadProgress) {
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
    UIButton *rightbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightbutton addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    [rightbutton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
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
    _tableView.y = 0;
    _tableView.height = KHeight - 49;
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
    FreeArticleHeaderView *header = [FreeArticleHeaderView headerWithTableView:tableView];
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
    
    _currentSession = button.tag;
    
    self.isReply = NO;
    //创建并弹出键盘
    [self setupKeyboard];
    
}

/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 如果正在切换键盘，就不要执行后面的代码
    //    if (self.switchingKeybaord) return;
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 执行动画
    [UIView animateWithDuration:duration animations:^{

        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        //        if (keyboardF.origin.y > KHeight) { // 键盘的Y值已经远远超过了控制器view的高度
        //            self.replyView.y = self.view.height - self.replyView.height - 44 - 49;
        //        } else {
        //            self.replyView.y = keyboardF.origin.y - self.replyView.height - 44 - 49;
        //        }
        
        self.replyView.y = keyboardF.origin.y - 100;
        
    }];
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
    _currentSession = indexPath.section;
    
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
    button.enabled = NO;
    [self.view endEditing:YES];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userId"] = UserID;
    parmas[@"sessionId"] = SessionID;
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
    
//    [HUD showMessage:@"数据提交中"];
    [[AFHTTPSessionManager manager]POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        button.enabled = YES;
        
        MJRefreshLog(@"responseObject---%@",responseObject);
        
        NSNumber *num = responseObject[@"resultCode"];
        if ([num integerValue] == 1000) {//发布成功
            [self.replyView removeFromSuperview];
            [HUD showSuccessMessage:@"发布成功"];

            //更改本地数据
            FreeArticleReplyModel *model = [[FreeArticleReplyModel alloc] init];
            model.userid = UserID;
            model.type = 1;
            model.conment = self.replyTextView.text;
            model.userNickName = [User currentUser].nickname;
            if (_isReply) {//回复
                model.flag = NO;
                model.targetId = self.replyModel.targetId;
                model.replyToUserId = self.replyModel.userid;
                model.replyToUserNickName = self.replyModel.userNickName;
                FreeArticleModel *model1 = _FreeArticleArr[self.currentSession];
                [model1.friendsRefList addObject:model];
            }else{//评论
                model.flag = YES;
                model.targetId = self.commonModel.ID;
                //插入数据
                [self.commonModel.friendsRefList addObject:model];
            }
            
            
            NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:_currentSession];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MJRefreshLog(@"error---%@",error);
        button.enabled = YES;
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
    
    UIView *replyView = [[UIView alloc] initWithFrame:CGRectMake(0,KHeight -  216  - 44 + 5, KWidth, 44)];
    
    NSString *type = self.parmas[@"type"];
    if ([type isEqualToString:@"3"]) {//我的发布
        replyView.y = KHeight -  216  - 44 -64 - 49 - 90;
    }
    
    replyView.backgroundColor = [UIColor whiteColor];
    self.replyView = replyView;
    [self.view addSubview:replyView];
    
    //设置分割线
    UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 4)];
    topLine.backgroundColor = MJRefreshColor(238, 238, 238);
    topLine.layer.borderWidth = 0.500;
    topLine.layer.borderColor = [UIColor grayColor].CGColor;
    
    [replyView addSubview:topLine];
    
    
    UIImageView *footLine = [[UIImageView alloc] initWithFrame:CGRectMake(10, 44, KWidth - 20, 2)];
    footLine.backgroundColor = MJRefreshColor(75, 190, 43);
//    footLine.layer.borderWidth = 0.500;
//    footLine.layer.borderColor = [UIColor grayColor].CGColor;
    
    [replyView addSubview:footLine];

    
    //设置输入框
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 12, KWidth - 80, 24)];
//    textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.replyTextView = textView;
    textView.backgroundColor = [UIColor clearColor];
    textView.font = UIFontLarge;
    
    [replyView addSubview:textView];

    
    [textView becomeFirstResponder];
    
    //设置都发送按钮
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWidth - 70, 10, 60, 30)];
    sendBtn.backgroundColor = MJRefreshColor(222, 222, 222);
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    sendBtn.enabled = NO;
    self.sendBtn = sendBtn;
    [sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:sendBtn];
}



@end
