
//
//  ServiceProvidersListViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ServiceProvidersListViewController.h"
#import "ServiceProvidersListViewCell.h"
#import "ServiceProvidersListModel.h"

#import "SearchViewController.h"        //关键字搜索
#import "CommodityListViewController.h" //下级界面

NSString *const ServiceProvidersListViewCellIdentifier = @"serviceProvidersListViewCellIdentifier";

@interface ServiceProvidersListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataMArray; //数据源

@property(nonatomic,strong) UISearchBar *searchBar;     //搜索栏
@property(nonatomic,retain) NSString *keywordSearchString;  //关键字


@end

@implementation ServiceProvidersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    
    if (!_dataMArray) {
        _dataMArray = [NSMutableArray new];
    }
    
    [self initializeComponent];
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.showsHorizontalScrollIndicator = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _searchBar = [[UISearchBar alloc] init];
//    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索店铺";
    _searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.tintColor = [UIColor cyanColor];
    _searchBar.showsScopeBar = NO;
    _searchBar.enablesReturnKeyAutomatically = YES;
    [_searchBar sizeToFit];
    [view addSubview:_searchBar];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-5);
    }];
    _tableView.tableHeaderView = view;
    
    [_tableView registerClass:[ServiceProvidersListViewCell class] forCellReuseIdentifier:ServiceProvidersListViewCellIdentifier];
    
    [self dataRequest];
}
-(void)dataRequest{
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [parametersDic setValue:[NSString stringWithFormat:@"%@",self.serviceTypeID] forKey:@"malltypeid"];
    
    [HUD showProgress:@"数据正在加载"];
    [[RequestManager manager] SessionRequestWithType:Mall_api requestWithURLString:@"find/vendorsInfo" requestType:RequestMethodPost requestParameters:parametersDic success:^(id  _Nullable responseObject) {
        
        [HUD dismiss];
        ICLog_2(@"%@",responseObject);
        if ([responseObject[@"resultCode"] integerValue] == 1000) {
            for (NSDictionary *dic in responseObject[@"body"]) {
                ServiceProvidersListModel *model = [[ServiceProvidersListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataMArray addObject:model];
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        

        
    } faile:^(NSError * _Nullable error) {
        [HUD dismiss];
        ICLog_2(@"%@",error);
    }];
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataMArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kGetVerticalDistance(170);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceProvidersListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ServiceProvidersListViewCellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ServiceProvidersListModel *model = _dataMArray[indexPath.row];

    //商家展示图片
//    @property(nonatomic,strong) UIImageView *advertiseImageView;
//    //店名
//    @property(nonatomic,strong) UILabel *storeNameLabel;
    if (model.vendername && model.vendername.length) {
        
        cell.storeNameLabel.text = model.vendername;
    }
//    //营业时间
//    @property(nonatomic,strong) UILabel *businessHoursLabel;
    if (model.startTime && model.startTime.length) {
        if (model.endTime && model.endTime.length) {
            
            cell.businessHoursLabel.text = [NSString stringWithFormat:@"营业时间: %@ ~ %@",model.startTime,model.endTime];
        }
    }
//    //签名
//    @property(nonatomic,strong) UILabel *signatureLabel;
    if (model.serviceProviderDescription && model.serviceProviderDescription.length) {
        
        cell.signatureLabel.text = model.serviceProviderDescription;
    }
    //综合评分
//    @property(nonatomic,strong) UILabel *scoreCountLabel;
    if (model.evaluate) {
        cell.scoreCountLabel.text = [NSString stringWithFormat:@"综合评分:%@",model.evaluate];
    }
//    //月销量
//    @property(nonatomic,strong) UILabel *monthSaleCountLabel;
    if (model.salecount) {
        
        cell.monthSaleCountLabel.text = [NSString stringWithFormat:@"月销量:%@单",model.salecount];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ICLog_2(@"%ld",indexPath.row);
    CommodityListViewController *VC = [[CommodityListViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark--keywordSearch
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
