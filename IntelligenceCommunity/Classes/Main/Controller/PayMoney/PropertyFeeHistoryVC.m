//
//  PropertyFeeHistoryVC.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeHistoryVC.h"
#import "PropertyFeeHistoryViewCell.h"    //缴费记录列表
#import "PropertyFeeBillingVC.h"   //账单详情
#import "PropertyFeeHistoryListModel.h"  //数据模型


NSString *const PropertyFeeHistoryCellIdentifier = @"propertyFeeHistoryCellIdentifier";

@interface PropertyFeeHistoryVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *propertyFeeHistoryListMArray;

@end

@implementation PropertyFeeHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"缴费记录";
    [self defaultViewStyle];

    if (!_propertyFeeHistoryListMArray) {
        _propertyFeeHistoryListMArray = [NSMutableArray array];
    }
    
    
    [self initializeComponent];
}
-(void)initializeComponent{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [_tableView registerClass:[PropertyFeeHistoryViewCell class] forCellReuseIdentifier:PropertyFeeHistoryCellIdentifier];
    
    [self dataRequest];
}
#pragma mark--缴费记录
-(void)dataRequest{
    
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    
    NSString *URLString = @"";
    switch (_feetype) {
        case propertyFee:       //物业费接口
            self.navigationItem.title = @"物业缴费记录";
            
            [parametersDic setValue:@"1" forKey:@"userId"];
            [parametersDic setValue:@"1" forKey:@"pageNum"];
            [parametersDic setValue:@"1" forKey:@"pageSize"];

            
            URLString = @"find/user/profee/history";
            break;
        case ParkingFee:        //停车费接口
            self.navigationItem.title = @"停车缴费记录";
            [parametersDic setValue:@"1" forKey:@"userId"];
            [parametersDic setValue:@"1" forKey:@"pageNum"];
            [parametersDic setValue:@"10" forKey:@"pageSize"];
            
            URLString = @"find/user/parkingfee/history";
            break;
            
        default:
            break;
    }
    
    [HUD showProgress:@"正在加载数据"];
    [[RequestManager manager] JSONRequestWithType:Pro_api urlString:URLString method:RequestMethodPost timeout:20 parameters:parametersDic success:^(id  _Nullable responseObject) {
        
        [HUD dismiss];
        ICLog_2(@"%@",responseObject);
        if ([responseObject[@"resultCode"] integerValue] == 1000) {
            
            for (NSDictionary *dic in responseObject[@"body"]) {
                PropertyFeeHistoryListModel *model = [[PropertyFeeHistoryListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_propertyFeeHistoryListMArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    } faile:^(NSError * _Nullable error) {
        [HUD dismiss];
    }];
    
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _propertyFeeHistoryListMArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PropertyFeeHistoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PropertyFeeHistoryCellIdentifier forIndexPath:indexPath];
    
    PropertyFeeHistoryListModel *model = _propertyFeeHistoryListMArray[indexPath.row];
    //缴费时间
//    @property(nonatomic,strong) UILabel *timeLabel;
    if (model.payTime && model.payTime.length > 0) {
        
        cell.timeLabel.text = model.payTime;
    }

    //钱数
//    @property(nonatomic,strong) UILabel *priceCountLabel;
    if (model.amount) {
        cell.priceCountLabel.text = [NSString stringWithFormat:@"￥%@",model.amount];
    }
    //图标
    //    @property(nonatomic,strong) UIImageView *historyImageView;
    //费用类型
//    @property(nonatomic,strong) UILabel *priceTypeLabel;
    if (model.type) {
        
        NSString *string = @"";
        switch ([model.type integerValue]) {
            case 1:{
                cell.historyImageView.image = [UIImage imageNamed:@"Property"];
                string = @"物业费";
                break;
            }
            case 2:{
                cell.historyImageView.image = [UIImage imageNamed:@"parking"];
                string = @"停车费";
                break;
            }
                
            default:
                break;
        }
        if (model.flowNum) {
            
            cell.priceTypeLabel.text = [NSString stringWithFormat:@"%@(流水号:%@)",string,model.flowNum];
        }
    }
    
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = view;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PropertyFeeBillingVC *VC = [[PropertyFeeBillingVC alloc] init];
    
    PropertyFeeHistoryListModel *model = _propertyFeeHistoryListMArray[indexPath.row];
    VC.paymentId = model.paymentId;     //支付记录ID，查看详情用
    VC.feetype = _feetype;              //费用类型
    
    [self.navigationController pushViewController:VC animated:YES];
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
