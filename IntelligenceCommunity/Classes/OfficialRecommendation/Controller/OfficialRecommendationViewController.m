//
//  OfficialRecommendationViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "OfficialRecommendationViewController.h"
#import "AdvertiseViewCell.h"

NSString *const officialRecommendCellIdentifier = @"advertiseViewCellIdentifier";

@interface OfficialRecommendationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray <SectionModel *>*dataArray;


@end

@implementation OfficialRecommendationViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"悠游官方推荐";
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[AdvertiseViewCell class] forCellReuseIdentifier:officialRecommendCellIdentifier];
}

///创建数据
-(void)createData {
    CellModel *milkReserve = [CellModel cellModelWith:@"鲜奶预定" sel:@"milkReserve:"];
    CellModel *CommunityTourism = [CellModel cellModelWith:@"社区旅游" sel:@"CommunityTourism:"];
    CellModel *saleMall = [CellModel cellModelWith:@"特卖商城" sel:@"saleMall:"];
    
    
    SectionModel *s0 = [SectionModel sectionModelWith:nil cells:@[milkReserve,CommunityTourism,saleMall]];
    
    _dataArray = @[s0];
    
}
#pragma -mark tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!_dataArray) {
        return 0;
    }
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    return s.cells.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        return 300;
    }
    return 230;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AdvertiseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:officialRecommendCellIdentifier forIndexPath:indexPath];
    CellModel *model = [self getCellModelWith:indexPath];
    cell.advertiseTitleLabel.text = model.title;
    
    
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
#pragma mark---cell点击方法
//鲜奶预定
-(void)milkReserve:(NSIndexPath *)indexPath{
    
}
//社区旅游
-(void)CommunityTourism:(NSIndexPath *)indexPath{
    
}
//特卖商城
-(void)saleMall:(NSIndexPath *)indexPath{
    
}
-(CellModel*)getCellModelWith:(NSIndexPath*)indexPath {
    SectionModel *section = _dataArray[indexPath.section];
    CellModel *row = section.cells[indexPath.row];
    return row;
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
