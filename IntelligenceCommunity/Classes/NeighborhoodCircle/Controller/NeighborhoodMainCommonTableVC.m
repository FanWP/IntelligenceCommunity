//
//  NeighborhoodMainCommonTableVC.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodMainCommonTableVC.h"
#import "NeighborhoodCircleCell.h"
#import "IQKeyboardManager.h"

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
@property (nonatomic,strong) NeighborhoodModel *commonModel;

/** 标记设置回复或者是评论 isReply  是否是回复 */
@property (nonatomic,assign) BOOL isReply;


@end

@implementation NeighborhoodMainCommonTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupRefresh];
    
    
    [self.tableView registerClass:[NeighborhoodCircleCell class] forCellReuseIdentifier:NeighborhoodCircleCellID];
    
    
//    // 键盘的frame发生改变时发出的通知（位置和尺寸）
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    //监听文本框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:nil];
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
    
    //结束上拉刷新
    [self.tableView.mj_header endRefreshing];
    self.pageSize = 10;
    
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
        
        [self.tableView.mj_footer endRefreshing];
        MJRefreshLog(@"邻里圈下拉显示成功：%@",responseObject);
        
        NSArray *arr = [NeighborhoodModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
        [_NeighborhoodArr addObjectsFromArray:arr];
        
        if (arr.count > 0) {
            self.pageNum++;
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MJRefreshLog(@"邻里圈下拉失败:%@",error);
        [self.tableView.mj_footer endRefreshing];
        
    }];

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
    header.deleteteButton.tag = section;
    [header.deleteteButton addTarget:self action:@selector(deleteteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [header.commentsButton addTarget:self action:@selector(commentsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NeighborhoodModel *model = _NeighborhoodArr[section];

    header.neiborhoodModel = model;

    return header;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FreeArticleReplyCell *cell = [FreeArticleReplyCell cellWithTableView:tableView];
    NeighborhoodModel *model = _NeighborhoodArr[indexPath.section];
    cell.replyModel = model.friendsRef[indexPath.row];
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
    self.commonModel = _NeighborhoodArr[button.tag];
    
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
        self.replyView.y = KHeight - keyboardF.origin.y - 44 - 44 - 100;
    }];
}


-(void)textDidChanged
{
    self.sendBtn.enabled = [self.replyTextView hasText];
}

//点击回复评论
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        ICLog_2(@"%ld",indexPath.row);
    if ([_replyModel.userid isEqualToString:UserID]) {//自己给自己回复
        [HUD showErrorMessage:@"您不能给自己回复！"];
        [self.replyView removeFromSuperview];
        MJRefreshLog(@"自己");
        return;
    }else
    {
        //创建并弹出键盘
        self.isReply = YES;
        [self setupKeyboard];
        NeighborhoodModel *model = _NeighborhoodArr[indexPath.section];
        _replyModel = model.friendsRef[indexPath.row];
    }
}


//发送按钮的点击事件
-(void)sendBtnClick:(UIButton *)button
{
    [self.view endEditing:YES];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userId"] = UserID;
    parmas[@"sessionid"] = SessionID;
    parmas[@"type"] = @"1";
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
    
    
    UIView *replyView = [[UIView alloc] initWithFrame:CGRectMake(0,KHeight -  216  - 100 - 44, KWidth, 44)];
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


-(void)deleteteButtonClick:(UIButton *)button
{
    MJRefreshLog(@"删除");
    
    NeighborhoodModel *model = _NeighborhoodArr[button.tag];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"sessionId"] = SessionID;
    parmas[@"userId"] = UserID;
    parmas[@"ids"] = model.ID;
    
    NSString *url = [NSString stringWithFormat:@"%@smart_community/delete/friendsCircle",Smart_community_URL];
    
    MJRefreshLog(@"parmas--:%@url---:%@",parmas,url);
    [[AFHTTPSessionManager manager]POST:url parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MJRefreshLog(@"responseObject--:%@",responseObject);
        NSNumber *num = responseObject[@"resultCode"];
        if ([num integerValue] == 1000) {//删除成功
            
//            NSIndexSet *set = [NSIndexSet indexSetWithIndex:button.tag];
//            
//            [self.tableView deleteSections:set withRowAnimation:UITableViewRowAnimationRight];
            
            MJRefreshLog(@"删除成功");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MJRefreshLog(@"responseObject--:%@",error);
    }];
}






@end
