//
//  CommunityViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityServiceHeaderView.h"  //商品、便民、美食、娱乐
#import "CommunityServiceTypeModel.h"   //数据源


#import "CommunityServiceListCell.h"    //列表cell

#import "ServiceProvidersListViewController.h"  //服务商列表


NSString *const CommunityServiceHeaderViewCellIdentifier = @"communityServiceHeaderViewCellIdentifier";
NSString *const CommunityServiceListCellIdentifier = @"communityServiceListCellIdentifier";

//CommunityServiceHeaderViewDelegate  用来传递点击状态:商品、便民、美食、娱乐

@interface CommunityViewController ()<UITableViewDelegate,UITableViewDataSource,CommunityServiceHeaderViewDelegate>;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray <CommunityServiceTypeModel *> *dataMArray;

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区服务";
    [self defaultViewStyle];
    
    
    if (!_dataMArray) {
        _dataMArray = [NSMutableArray new];
    }
    
    [self initializeComponent];
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CommunityServiceHeaderView class] forHeaderFooterViewReuseIdentifier:CommunityServiceHeaderViewCellIdentifier];
    [_tableView registerClass:[CommunityServiceListCell class] forCellReuseIdentifier:CommunityServiceListCellIdentifier];
    
    [self dataRequest];
}
-(void)dataRequest{
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    
    [HUD showProgress:@"数据正在加载"];
    [[RequestManager manager] SessionRequestWithType:Mall_api requestWithURLString:@"find/communityService/type" requestType:RequestMethodPost requestParameters:parametersDic success:^(id  _Nullable responseObject) {
        [HUD dismiss];
        ICLog_2(@"%@",responseObject);
        
        if ([responseObject[@"resultCode"] integerValue] == 1000) {
            
            for (NSDictionary *dic in responseObject[@"body"]) {
                CommunityServiceTypeModel *model = [[CommunityServiceTypeModel alloc] init];
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
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 65;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommunityServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:CommunityServiceListCellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CommunityServiceHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CommunityServiceHeaderViewCellIdentifier];
    headerView.delegate = self;
    
    //四个按钮的顺序从服务器动态获取
//    @property(nonatomic,strong) UILabel *commodityLabel;     //------1
//    @property(nonatomic,strong) UILabel *convenientLabel;    //------2
//    @property(nonatomic,strong) UILabel *delicacyLabel;      //------3
//    @property(nonatomic,strong) UILabel *entertainmentLabel; //------4
    if (_dataMArray.count) {
        //第一个按钮
        CommunityServiceTypeModel *model_1 = [_dataMArray objectAtIndex:0];
        headerView.commodityLabel.text = model_1.serviceTypename;
        //第二个按钮
        CommunityServiceTypeModel *model_2 = [_dataMArray objectAtIndex:1];
        headerView.convenientLabel.text = model_2.serviceTypename;
        //第三个按钮
        CommunityServiceTypeModel *model_3 = [_dataMArray objectAtIndex:2];
        headerView.delicacyLabel.text = model_3.serviceTypename;
        //第四个按钮
        CommunityServiceTypeModel *model_4 = [_dataMArray objectAtIndex:3];
        headerView.entertainmentLabel.text = model_4.serviceTypename;
    }
    
    
    
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ICLog_2(@"%ld",indexPath.row);
}

-(void)headerView:(CommunityServiceHeaderView *)headerView buttonWithTag:(NSInteger)tag{
    
    ServiceProvidersListViewController *VC = [[ServiceProvidersListViewController alloc] init];

    if (!_dataMArray.count) {       
        return;
    }
    if (tag == 1) {
        CommunityServiceTypeModel *model_1 = [_dataMArray objectAtIndex:0];
        
        VC.serviceTypeID = model_1.serviceTypeID;
        VC.navigationItem.title = model_1.serviceTypename;
    }else if (tag == 2){
        CommunityServiceTypeModel *model_2 = [_dataMArray objectAtIndex:1];

        VC.serviceTypeID = model_2.serviceTypeID;
        VC.navigationItem.title = model_2.serviceTypename;
    }else if (tag == 3){
        CommunityServiceTypeModel *model_3 = [_dataMArray objectAtIndex:2];

        VC.serviceTypeID = model_3.serviceTypeID;
        VC.navigationItem.title = model_3.serviceTypename;
    }else if (tag == 4){
        CommunityServiceTypeModel *model_4 = [_dataMArray objectAtIndex:3];

        VC.serviceTypeID = model_4.serviceTypeID;
        VC.navigationItem.title = model_4.serviceTypename;
    }
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
