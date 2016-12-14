//
//  NeighborhoodCircleViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodCircleViewController.h"
#import "NeighborhoodCircleHeaderView.h"
#import "NeighborhoodCircleCell.h"

NSString *const NeighborhoodCircleHeaderViewIdentifier = @"neighborhoodCircleHeaderViewIdentifier";
NSString *const NeighborhoodCircleCellIdentifier = @"neighborhoodCircleCellIdentifier";

//NeighborhoodCircleCellDelegate   cell上面对话按钮、点赞、评论按钮的响应
@interface NeighborhoodCircleViewController ()<UITableViewDelegate,UITableViewDataSource,NeighborhoodCircleCellDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation NeighborhoodCircleViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"邻里圈";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self initializeComponent];
    
}
-(void)initializeComponent{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    NeighborhoodCircleHeaderView *headerView = [[NeighborhoodCircleHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:@[@"邻里",@"约",@"生活分享",@"寻物招领"] clickBlick:^void(NSInteger index) {
        NSLog(@"%ld",index);
    }];
    //以下属性可以根据需求修改
    //    view.titleFont=[UIFont systemFontOfSize:30];
    //    view.defaultIndex=2;
    //    view.titleNomalColor=[UIColor blueColor];
    //    view.titleSelectColor=[UIColor orangeColor];
    
    _tableView.tableHeaderView = headerView;
    
    [_tableView registerClass:[NeighborhoodCircleHeaderView class] forHeaderFooterViewReuseIdentifier:NeighborhoodCircleHeaderViewIdentifier];
    [_tableView registerClass:[NeighborhoodCircleCell class] forCellReuseIdentifier:NeighborhoodCircleCellIdentifier];
    
    
}
-(void)neighborhoodCircleCell:(NeighborhoodCircleCell *)neighborhoodCircleCell clickButtonWithTag:(NSInteger)tag{
        if (tag == 1) {
            NSLog(@"点击了对话按钮");
        }else if (tag == 2){
            NSLog(@"点击了点赞按钮");
            neighborhoodCircleCell.thumbUpButton.selected = !neighborhoodCircleCell.thumbUpButton.selected;
            if (neighborhoodCircleCell.thumbUpButton.selected) {
            }else{
            }
        }else if (tag == 3){
            NSLog(@"点击了评论按钮");
        }
    NSIndexPath *indexPath = [_tableView indexPathForCell:neighborhoodCircleCell];
    NSLog(@"indexPath.row===%ld",indexPath.row);
}

#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 260;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NeighborhoodCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:NeighborhoodCircleCellIdentifier  forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row == 0) {
        cell.userNameLabel.text = @"咖啡小猫";
    }else{
        cell.userNameLabel.text = @"咖啡大猫";
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ICLog_2(@"%ld",indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
