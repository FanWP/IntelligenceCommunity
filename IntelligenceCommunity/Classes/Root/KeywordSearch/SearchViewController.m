//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHistory.h"
#import "SearchResultsView.h"

NSString *const SearchViewCellIdentifier = @"SearchViewCellIdentifier";

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) RLMResults<SearchHistory*> *dataArray;
@property(nonatomic,strong) SearchResultsView *resultsView;

@end

@implementation SearchViewController

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeComponent];
}
-(void)initializeComponent {
    [self defaultViewStyle];
    
    [self loadSearchHistoryData];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索";
    _searchBar.enablesReturnKeyAutomatically = YES;
    _searchBar.showsCancelButton = YES;
    self.navigationItem.titleView = _searchBar;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame) - 20, CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = HexColor(0xeeeeee);
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.layoutMargins = UIEdgeInsetsZero;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SearchViewCellIdentifier];
    [self.view addSubview:_tableView];
    
    _resultsView = [[SearchResultsView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, self.view.width, self.view.height - NavigationBarHeight)];
    _resultsView.hidden = YES;
    [self.view addSubview:_resultsView];
    
    [_searchBar becomeFirstResponder];
}

///加载历史查询数据
-(void)loadSearchHistoryData {
    RLMResults *results = [CacheData search:[SearchHistory class] sorted:CacheObjectLocalCreateAtKey ascending:NO];
    _dataArray = results;
}

#pragma -mark searchBar delegate

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@",searchText);
}
//搜索后收藏关键字
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
    NSString *text = searchBar.text;
    if([[text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        text = @"";
    }
    
    SearchHistory *history = [[SearchHistory alloc] init];
    history.work = text;
    [CacheData addObject:history];
    [_tableView reloadData];
    
    
    self.searchBlock(searchBar.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma -mark tableView delegate 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!_dataArray || _dataArray.count == 0) {
        return 0;
    }
    return _dataArray.count + 1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"搜索历史";
    }
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchViewCellIdentifier forIndexPath:indexPath];
    
    if(indexPath.row == _dataArray.count) {
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = HexColor(0x666666);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"清除搜索纪录";
    } else {
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        SearchHistory *searchHistory = _dataArray[indexPath.row];
        cell.textLabel.text = searchHistory.work;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_searchBar resignFirstResponder];
    
    if(indexPath.row == _dataArray.count) {     //清除搜索记录
//        [CacheData removeAll:[SearchHistory class]];
        [CacheData deleteAllObjects:[SearchHistory class]];
        [tableView reloadData];
    } else {
        
        SearchHistory *searchHistory = _dataArray[indexPath.row];
        self.searchBlock(searchHistory.work);
        NSLog(@"从搜索记录中获取到的关键字---%@",searchHistory.work);
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}

@end
