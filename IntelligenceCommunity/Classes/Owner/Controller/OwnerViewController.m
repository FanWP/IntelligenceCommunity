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

#import "FeedbackVC.h"// 意见反馈

NSString *const OwnerViewCellIdentifier = @"ownerViewCellIdentifier";

@interface OwnerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray <SectionModel *>*dataArray;

@end

@implementation OwnerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"我的";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initializeComponent];
    [self createData];
    
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[OwnerViewCell class] forCellReuseIdentifier:OwnerViewCellIdentifier];
    OwnerHeaderView *view = [[OwnerHeaderView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.bounds), 200)];

    _tableView.tableHeaderView = view;
}
-(void)buttonAction:(UIButton *)button{
    NSLog(@"1111");
}
-(void)createData{
    
    CellModel *payMoneyRecord = [CellModel cellModelWith:@"缴费记录" sel:@"payMoneyRecord:"];
    CellModel *ownerOrder = [CellModel cellModelWith:@"我的订单" sel:@"ownerOrder:"];
    CellModel *shipingAddress = [CellModel cellModelWith:@"收货地址" sel:@"shipAddress:"];
    CellModel *ownerShoppingChart = [CellModel cellModelWith:@"我的购物车" sel:@"ownerShoppingChart:"];
    CellModel *feedback = [CellModel cellModelWith:@"意见反馈" sel:@"feedback:"];
    
    SectionModel *section_1 = [SectionModel sectionModelWith:nil cells:@[payMoneyRecord,ownerOrder,shipingAddress,ownerShoppingChart,feedback]];
    
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
    
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OwnerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OwnerViewCellIdentifier forIndexPath:indexPath];
    CellModel *model = [self getCellModelWith:indexPath];
    cell.titleLabel.text = model.title;
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
//缴费记录
-(void)payMoneyRecord:(NSIndexPath *)indexPath{
    
}
//我的订单
-(void)ownerOrder:(NSIndexPath *)indexPath{
    
}
//收货地址
-(void)shipAddress:(NSIndexPath *)indexPath{
    
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
