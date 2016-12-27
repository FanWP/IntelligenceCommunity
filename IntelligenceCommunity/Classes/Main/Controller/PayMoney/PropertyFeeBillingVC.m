//
//  PropertyFeeBillingVC.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeBillingVC.h"
#import "PropertyFeeBillingDetailViewCell.h"   //账单详情
#import "PropertyFeeBillingModel.h"             //数据模型


NSString *const PropertyFeeBillingDetailCellIdentifier = @"propertyFeeBillingDetailCellIdentifier";
@interface PropertyFeeBillingVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) PropertyFeeBillingModel *propertyFeeBillingModel;

@end

@implementation PropertyFeeBillingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
 
    [self initializeComponent];
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [_tableView registerClass:[PropertyFeeBillingDetailViewCell class] forCellReuseIdentifier:PropertyFeeBillingDetailCellIdentifier];
    
    [self dataRequest];
    if (!_propertyFeeBillingModel) {
        _propertyFeeBillingModel = [[PropertyFeeBillingModel alloc] init];
    }
}
-(void)dataRequest{
    
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionary];

    NSString *URLString = @"";
    switch (_feetype) {
        case propertyFee:       //物业费接口
            self.navigationItem.title = @"物业缴费记录";
            [parametersDictionary setValue:@"1" forKey:@"type"];
            [parametersDictionary setValue:@"2" forKey:@"paymentId"];

            URLString = @"find/profee/history/detail";
            break;
        case ParkingFee:        //停车费接口
            self.navigationItem.title = @"停车缴费记录";
            [parametersDictionary setValue:@"2" forKey:@"type"];
            [parametersDictionary setValue:@"232" forKey:@"paymentId"];
            URLString = @"find/parkingfee/history/detail";
            break;
            
        default:
            break;
    }
    [HUD showProgress:@"正在加载数据"];
    [[RequestManager manager] SessionRequestWithType:Pro_api requestWithURLString:URLString requestType:RequestMethodPost requestParameters:parametersDictionary success:^(id  _Nullable responseObject) {
        [HUD dismiss];

        ICLog(@"%@",responseObject);
        [_propertyFeeBillingModel setValuesForKeysWithDictionary:responseObject[@"body"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });

    } faile:^(NSError * _Nullable error) {
        [HUD dismiss];
        ICLog(@"%@",error);
    }];
}


#pragma mark--delgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PropertyFeeBillingDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PropertyFeeBillingDetailCellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:{
            cell.titleLabel.text = @"名        称:";
            if (_propertyFeeBillingModel.typeName) {
                cell.detailLabel.text = _propertyFeeBillingModel.typeName;
            }
            break;
        }
        case 1:{
            cell.titleLabel.text = @"金        额:";
            if (_propertyFeeBillingModel.amount) {
                cell.detailLabel.text = [NSString stringWithFormat:@"￥%@",_propertyFeeBillingModel.amount];
            }
            break;
        }
        case 2:{
            cell.titleLabel.text = @"付款方式:";
            if (_propertyFeeBillingModel.payType) {
                if ([_propertyFeeBillingModel.payType integerValue] == 1) {
                    cell.detailLabel.text = @"支付宝";
                }else if ([_propertyFeeBillingModel.payType integerValue] == 2){
                    cell.detailLabel.text = @"微信";
                }
            }
            break;
        }
        case 3:{
            cell.titleLabel.text = @"缴费说明:";
            if (_propertyFeeBillingModel.feePeriod) {
                cell.detailLabel.text = _propertyFeeBillingModel.feePeriod;
            }
            break;
        }
        case 4:{
            cell.titleLabel.text = @"房屋信息:";
            if (_propertyFeeBillingModel.houseInfo) {
                cell.detailLabel.text = _propertyFeeBillingModel.houseInfo;
            }
            break;
        }
        case 5:{
            cell.titleLabel.text = @"付款户号:";
            if (_propertyFeeBillingModel.payInfo && _propertyFeeBillingModel.payInfo.length > 0) {
                cell.detailLabel.text = _propertyFeeBillingModel.payInfo;
            }
            break;
        }
        case 6:{
            cell.titleLabel.text = @"时        间:";
            if (_propertyFeeBillingModel.payTime && _propertyFeeBillingModel.payTime.length > 0) {
                cell.detailLabel.text = _propertyFeeBillingModel.payTime;
            }
            break;
        }
            
        default:
            break;
    }
    return cell;
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
