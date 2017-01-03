//
//  FeeHistoryListViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/30.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FeeHistoryListViewController.h"
#import "FeeHistoryListHeaderFooterViewCell.h"      //分区头
#import "PropertyFeeHistoryViewCell.h"              //cell
#import "PropertyFeeHistoryListModel.h"             //model


NSString *const FeeHistoryListHeaderFooterViewCellIdentifier = @"feeHistoryListHeaderFooterViewCellIdentifier";

//FeeHistoryListHeaderFooterViewCellDelegate  分区的展开与闭合
@interface FeeHistoryListViewController ()<UITableViewDelegate,UITableViewDataSource,FeeHistoryListHeaderFooterViewCellDelegate>

@property(nonatomic,strong) UITableView *tableView;

//分区
@property(nonatomic,strong) NSMutableArray <NSMutableDictionary *>*headerViewListMrray;
//列表
@property(nonatomic,strong) NSMutableArray <NSMutableArray *>*propertyFeeHistoryListMArray;


@end

@implementation FeeHistoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    
    
    [self initializeComponent];
    
    if (!_headerViewListMrray) {
        _headerViewListMrray = [NSMutableArray new];
    }
    if (!_propertyFeeHistoryListMArray) {
        _propertyFeeHistoryListMArray = [NSMutableArray new];
    }
    
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[FeeHistoryListHeaderFooterViewCell class] forHeaderFooterViewReuseIdentifier:FeeHistoryListHeaderFooterViewCellIdentifier];

    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [parametersDic setValue:@"1" forKey:@"userId"];
    User *user = [User currentUser];
    [parametersDic setValue:user.sessionId forKey:@"sessionId"];
    [HUD showProgress:@"数据正在加载"];
    
    [[RequestManager manager] JSONRequestWithType:Pro_api urlString:@"find/payment/history" method:RequestMethodPost timeout:20 parameters:nil success:^(id  _Nullable responseObject) {
        [HUD dismiss];
        ICLog_2(@"%@",responseObject);
        
        if ([responseObject[@"resultCode"] integerValue] == 1000) {
            
            for (NSDictionary *dic in responseObject[@"body"]) {
                
                //分区信息
                NSMutableDictionary *headerViewDic = [NSMutableDictionary new];
                [headerViewDic setValue:[NSString stringWithFormat:@"%@",dic[@"totalprice"]] forKey:@"totalprice"];
                [headerViewDic setValue:dic[@"date"] forKey:@"date"];
                [_headerViewListMrray addObject:headerViewDic];
                
                //列表
                NSMutableArray *tempMArray = [NSMutableArray new];
                for (NSDictionary *feeHistoryDic in dic[@"ProperFee"]) {   //一个分区
                    
                    PropertyFeeHistoryListModel *model = [[PropertyFeeHistoryListModel alloc] init];
                    [model setValuesForKeysWithDictionary:feeHistoryDic];
                    [tempMArray addObject:model];
                }
                
                [_propertyFeeHistoryListMArray addObject:tempMArray];
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
    
    return _headerViewListMrray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [_propertyFeeHistoryListMArray[section] count];
    return [_propertyFeeHistoryListMArray[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FeeHistoryListHeaderFooterViewCell *HeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FeeHistoryListHeaderFooterViewCellIdentifier];
    HeaderView.delegate = self;
    HeaderView.section = section;
    
    
    return HeaderView;
}
-(void)FeeHistoryListHeaderFooterViewCell:(FeeHistoryListHeaderFooterViewCell *)headerViewCell didSelectAtSection:(NSInteger)section{
    
    ICLog_2(@"%ld",section);
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
