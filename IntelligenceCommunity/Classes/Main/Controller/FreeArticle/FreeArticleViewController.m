//
//  FreeArticleViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleViewController.h"
#import "CommunityCell.h"
#import "SearchViewController.h"    //关键字搜索

NSString *const communityCellIdentifier = @"communityCellIdentifier";

@interface FreeArticleViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UISearchBar *searchBar;     //搜索栏
@property(nonatomic,retain) NSString *keywordSearchString;  //关键字

@end

@implementation FreeArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];

    self.navigationItem.title = @"闲置物品";
    [self defaultViewStyle];
    
    
    [self initializeComponent];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(action:)];

    
}
-(void)action:(UIBarButtonItem *)sender{
    //预留
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:communityCellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ICLog_2(@"%ld",(long)indexPath.row);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
