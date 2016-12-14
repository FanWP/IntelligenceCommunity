//
//  PayMoneyViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PayMoneyViewController.h"
#import "CostListViewCell.h"    //列表
#import "PropertyFeeViewController.h"   //物业费
#import "ParkingFeeViewController.h"    //停车费
#import "HelpCenterViewController.h"    //帮助中心

NSString *const CostListViewCellIdentifier = @"costListViewCellIdentifier";

@interface PayMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray <SectionModel *> *dataArray;

@property(nonatomic,strong) NSDictionary *payTypeDictionary;   //支持类型:0-支持  1-不支持

@property(nonatomic,strong) UIButton *helpCenterButton;   //帮助中心


@end

@implementation PayMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"缴费";
    [self defaultViewStyle];

    
    
    [self initializeComponent];
    
    
    _helpCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _helpCenterButton.backgroundColor = ThemeColor;
    
    [_helpCenterButton setTitle:@"帮助中心" forState:UIControlStateNormal];
    [_helpCenterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_helpCenterButton addTarget:self action:@selector(helpCenterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_helpCenterButton];
    [_helpCenterButton bringSubviewToFront:self.view];
    [_helpCenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(64);
    }];
    
}
#pragma mark--帮助中心
-(void)helpCenterAction:(UIButton *)button{
    
    HelpCenterViewController *VC = [[HelpCenterViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CostListViewCell class] forCellReuseIdentifier:CostListViewCellIdentifier];
    
    //页面基本元素
    [self createData];
    
    //判断时候支持某个缴费功能
    [self dataRequest];
}
#pragma mark--获取元素是否支持
-(void)dataRequest{
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [[RequestManager manager] requestWithURLString:@"find/surport/paytype/list" requestType:RequestMethodGet requestParameters:parametersDic success:^(id  _Nullable responseObject) {
        
        ICLog_2(@"%@",responseObject);
        _payTypeDictionary = [NSDictionary dictionaryWithDictionary:responseObject[@"body"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } faile:^(NSError * _Nullable error) {
        ICLog_2(@"%@",error);
    }];
}
-(void)createData{
    
    //第一分区
    CellModel *propertyFee = [CellModel cellModelWith:@"物业费" sel:@"propertyFee:"];
    CellModel *parkingFee = [CellModel cellModelWith:@"停车费" sel:@"parkingFee:"];
    CellModel *waterFee = [CellModel cellModelWith:@"水费" sel:@"waterFee:"];
    CellModel *powerFee = [CellModel cellModelWith:@"电费" sel:@"powerFee:"];
    CellModel *fuelGasFee = [CellModel cellModelWith:@"燃气费" sel:@"fuelGasFee:"];
    
    SectionModel *firstSection = [SectionModel sectionModelWith:@"" cells:@[propertyFee,parkingFee,waterFee,powerFee,fuelGasFee]];
    
    //第二分区
    CellModel *heatingFee = [CellModel cellModelWith:@"暖气费" sel:@"heatingFee:"];
    CellModel *fixedLineFee = [CellModel cellModelWith:@"固话宽带" sel:@"fixedLineFee:"];
    
    SectionModel *secondSection = [SectionModel sectionModelWith:@"" cells:@[heatingFee,fixedLineFee]];
    
    //第三分区
    CellModel *cableTV = [CellModel cellModelWith:@"有线电视" sel:@"cableTV:"];
    CellModel *pre_paidPhone = [CellModel cellModelWith:@"手机充值" sel:@"prePaidPhone:"];
    
    SectionModel *thirdSection = [SectionModel sectionModelWith:@"" cells:@[cableTV,pre_paidPhone]];
    
    
    _dataArray = @[firstSection,secondSection,thirdSection];
}

#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *model = _dataArray[section];
    return model.cells.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CostListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CostListViewCellIdentifier forIndexPath:indexPath];
    CellModel *model = [self getCellModelWith:indexPath];
    
    if ([[_payTypeDictionary[@"payType1"] stringValue] isEqualToString:@"0"] && indexPath.section==0 && indexPath.row == 0 ) {
        //物业费
        cell.titleLabel.textColor = [UIColor greenColor];
    }
    if ([[_payTypeDictionary[@"payType2"] stringValue] isEqualToString:@"0"] && indexPath.section==0 && indexPath.row == 1){
        //停车费
        cell.titleLabel.textColor = [UIColor greenColor];
    }
    
    cell.titleLabel.text = model.title;
    
    
    return cell;
}
-(CellModel*)getCellModelWith:(NSIndexPath*)indexPath {
    SectionModel *section = _dataArray[indexPath.section];
    CellModel *row = section.cells[indexPath.row];
    return row;
}
#pragma mark--cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CellModel *row = [self getCellModelWith:indexPath];
    NSString *selectorString = row.selectorString;
    if(selectorString) {
        SEL selector = NSSelectorFromString(selectorString);
        if([self respondsToSelector:selector]) {
            ((void (*)(void *, SEL, NSIndexPath*))objc_msgSend)((__bridge void *)(self), selector, indexPath);
        }
    }
}
//物业费
-(void)propertyFee:(NSIndexPath *)indexPath{
    
    PropertyFeeViewController *VC = [[PropertyFeeViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}
//停车费
-(void)parkingFee:(NSIndexPath *)indexPath{
    ParkingFeeViewController *VC = [[ParkingFeeViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}
//水费
-(void)waterFee:(NSIndexPath *)indexPath{
    
}

//电费
-(void)powerFee:(NSIndexPath *)indexPath{
    
}
//燃气费
-(void)fuelGasFee:(NSIndexPath *)indexPath{
    
}
//暖气费
-(void)heatingFee:(NSIndexPath *)indexPath{
    
}
//宽带
-(void)fixedLineFee:(NSIndexPath *)indexPath{
    
}
//有限电视
-(void)cableTV:(NSIndexPath *)indexPath{
    
}
//手机充值
-(void)prePaidPhone:(NSIndexPath *)indexPath{
    
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
