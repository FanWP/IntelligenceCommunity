//
//  FreeArticleDetailTableVC.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/16.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleDetailTableVC.h"
#import "CommunityDetailCell.h"     // 闲置物品详情的cell



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

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger count = 1;
    if (section == 1) {
        count = 3;
    }
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 200;

    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityDetailCell *cell= [CommunityDetailCell cellWithTableView:tableView];
    cell.model = self.model;
    
    return cell;
}




@end
