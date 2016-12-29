//
//  OwnerViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "OwnerViewController.h"
#import "OwnerViewCell.h"
#import "OwnerHeaderView.h"

#import "SettingTableVC.h"// 设置
#import "HouseAuthorityVC.h"// 房屋认证
#import "MyOrdersVC.h"// 我的订单
#import "ReceiveAddressTableVC.h"// 收货地址
#import "FeedbackVC.h"// 意见反馈

NSString *const OwnerViewCellIdentifier = @"ownerViewCellIdentifier";

@interface OwnerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray <SectionModel *>*dataArray;
@property (nonatomic,strong) NSArray *leftImagesArray;

@end

@implementation OwnerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"我的";
    
    [self leftItemSetting];// 设置
    
    _leftImagesArray = @[[UIImage imageNamed:@"houses"],[UIImage imageNamed:@"ownerPayment"],[UIImage imageNamed:@"Orders"],[UIImage imageNamed:@"ownerAddress"],[UIImage imageNamed:@"shopping cart"],[UIImage imageNamed:@"opinion"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeComponent];
    
    [self defaultViewStyle];
    
    [self createData];
}

- (void)leftItemSetting
{
    self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"houses"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftItemSettingAction)];
}
- (void)leftItemSettingAction
{
    SettingTableVC *settingTableVC = [[SettingTableVC alloc] init];
    [self.navigationController pushViewController:settingTableVC animated:YES];
}


-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[OwnerViewCell class] forCellReuseIdentifier:OwnerViewCellIdentifier];
    OwnerHeaderView *view = [[OwnerHeaderView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.bounds), 183.5)];

    _tableView.tableHeaderView = view;
}
-(void)buttonAction:(UIButton *)button{
    NSLog(@"1111");
}
-(void)createData{
    
    CellModel *houseAuthority = [CellModel cellModelWith:@"房屋认证" sel:@"houseAuthority:"];
    CellModel *payMoneyRecord = [CellModel cellModelWith:@"缴费记录" sel:@"payMoneyRecord:"];
    CellModel *ownerOrder = [CellModel cellModelWith:@"我的订单" sel:@"ownerOrder:"];
    CellModel *shipingAddress = [CellModel cellModelWith:@"收货地址" sel:@"shipAddress:"];
    CellModel *ownerShoppingChart = [CellModel cellModelWith:@"我的购物车" sel:@"ownerShoppingChart:"];
    CellModel *feedback = [CellModel cellModelWith:@"意见反馈" sel:@"feedback:"];
    
    SectionModel *section_1 = [SectionModel sectionModelWith:nil cells:@[houseAuthority,payMoneyRecord,ownerOrder,shipingAddress,ownerShoppingChart,feedback]];
    
    _dataArray = @[section_1];
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!_dataArray) {
        return 0;
    }
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    SectionModel *sectionModel = _dataArray[section];
    return sectionModel.cells.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0)
    {
        return 60;
    }
    else
    {
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OwnerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OwnerViewCellIdentifier forIndexPath:indexPath];
    CellModel *model = [self getCellModelWith:indexPath];
    cell.titleLabel.text = model.title;
    cell.imageView.image = _leftImagesArray[indexPath.row];
    cell.titleLabel.textColor = [UIColor blackColor];
    return cell;
}
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


-(CellModel*)getCellModelWith:(NSIndexPath*)indexPath {
    SectionModel *section = _dataArray[indexPath.section];
    CellModel *row = section.cells[indexPath.row];
    return row;
}
#pragma mark--cell点击方法
//房屋认证
- (void)houseAuthority:(NSIndexPath *)indexPath{
    HouseAuthorityVC *houseAuthorityVC = [[HouseAuthorityVC alloc] init];
    [self.navigationController pushViewController:houseAuthorityVC animated:YES];
}
//缴费记录
-(void)payMoneyRecord:(NSIndexPath *)indexPath{
    
}
//我的订单
-(void)ownerOrder:(NSIndexPath *)indexPath{
    MyOrdersVC *myOrdersVC = [[MyOrdersVC alloc] init];
    [self.navigationController pushViewController:myOrdersVC animated:YES];
}
//收货地址
-(void)shipAddress:(NSIndexPath *)indexPath{
    ReceiveAddressTableVC *receiveAddressTableVC = [[ReceiveAddressTableVC alloc] init];
    [self.navigationController pushViewController:receiveAddressTableVC animated:YES];
}
//我的购物车
-(void)ownerShoppingChart:(NSIndexPath *)indexPath{
   
}
//意见反馈
-(void)feedback:(NSIndexPath *)indexPath{
    FeedbackVC *feedbackVC = [[FeedbackVC alloc] init];
    [self.navigationController pushViewController:feedbackVC animated:YES];
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
