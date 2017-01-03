//
//  PropertyFeeViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PropertyFeeViewController.h"

#import "PropertyFeeHeaderView.h"   //分区头
#import "PropertyFeeViewCell.h"     //物业费详情

#import "PropertyFeeOtherInfoHeaderView.h"  //缴费账期、应缴金额、缴费账号、户名、住户信息
#import "SpecialOffersListViewCell.h"        //优惠信息
#import "PropertyFeeHistoryVC.h"    //缴费记录列表

//model
#import "PropertyFeeListModel.h"
#import "PropertyFeeOtherInfoModel.h"
#import "SpecialOffersListModel.h"


//缴费明细
NSString *const PropertyFeeCellIdentifier = @"propertyFeeCellIdentifier";
NSString *const  PropertyFeeHeaderViewCellIdentifier = @"propertyFeeHeaderViewCellIdentifier";
//缴费账期、应缴金额、缴费账号、户名、住户信息
NSString *const PropertyFeeOtherInfoHeaderViewIdentifier  = @"propertyFeeOtherInfoHeaderViewIdentifier";
//优惠信息
NSString *const SpecialOffersListViewCellIdentifier = @"specialOffersListViewCellIdentifier";


//PropertyFeeHeaderViewDelegate   控制分区展开/闭合的协议
//SpecialOffersListViewCellDelegate   用户选中某个优惠信息按钮的状态处理
@interface PropertyFeeViewController ()<UITableViewDelegate,UITableViewDataSource,PropertyFeeHeaderViewDelegate,SpecialOffersListViewCellDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray<SectionModel*> *dataArray;

//缴费明细单、基本数据、优惠活动
@property(nonatomic,strong) NSMutableArray <PropertyFeeListModel *>*propertyFeeListMArray;
@property(nonatomic,strong) PropertyFeeOtherInfoModel *propertyFeeOtherInfoModel;
@property(nonatomic,strong) NSMutableArray <SpecialOffersListModel *>*specialOffersListMArray;

@end

@implementation PropertyFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    self.navigationItem.title = @"物业缴费记录";
    self.navigationController.navigationBar.translucent = YES;
    
    [self defaultViewStyle];

    
    [self initializeComponent];
    
    
    _dataArray = [NSMutableArray array];
    [self createData];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"List"] style:UIBarButtonItemStylePlain target:self action:@selector(propertyFeeHistoryList:)];
    
    //物业费明细
    [self dataRequest];
}
-(void)propertyFeeHistoryList:(UIBarButtonItem *)sender{
    PropertyFeeHistoryVC *VC = [[PropertyFeeHistoryVC alloc] init];
    VC.feetype = propertyFee;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--物业费明细
-(void)dataRequest{
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [parametersDic setValue:@"1" forKey:@"userId"];
//    [parametersDic setValue:@"1" forKey:@"sessionId"];
    User *user = [User currentUser];
    [parametersDic setValue:user.sessionId forKey:@"sessionId"];
    
    [HUD showProgress:@"正在加载数据"];
    
    [[RequestManager manager] JSONRequestWithType:Pro_api urlString:@"find/user/profee" method:RequestMethodPost timeout:20 parameters:parametersDic success:^(id  _Nullable responseObject) {
        
        [HUD dismiss];
        ICLog_2(@"PropertyFeeViewController---%@",responseObject);
        
        if ([responseObject[@"resultCode"] integerValue] == 1000) {
            
            //物业费明细单
            for (NSDictionary *dic in responseObject[@"body"][@"detailList"]) {
                PropertyFeeListModel *model = [[PropertyFeeListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_propertyFeeListMArray addObject:model];
            }
            //基本信息
            [_propertyFeeOtherInfoModel setValuesForKeysWithDictionary:responseObject[@"body"]];
            //优惠信息
            for (NSDictionary *dic in responseObject[@"body"][@"discountList"]) {
                SpecialOffersListModel *model = [[SpecialOffersListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_specialOffersListMArray addObject:model];
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    } faile:^(NSError * _Nullable error) {
        [HUD dismiss];

    }];
}
/**
 *  创建数据
 */
-(void)createData {
    
    for (int i = 0; i < 5; i++) {
        CellModel *b1 = [CellModel cellModelWith:@"ssss" sel:nil];
        CellModel *b2 = [CellModel cellModelWith:@"ssss" sel:nil];
        CellModel *b3 = [CellModel cellModelWith:@"ssss" sel:nil];
        SectionModel *s1 = [SectionModel sectionModelWith:nil cells:@[b1,b2,b3]];
        [_dataArray addObject:s1];
    }
}
-(void)initializeComponent{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    //缴费明细
    [_tableView registerClass:[PropertyFeeViewCell class] forCellReuseIdentifier:PropertyFeeCellIdentifier];
    
    [_tableView registerClass:[PropertyFeeHeaderView class] forHeaderFooterViewReuseIdentifier:PropertyFeeHeaderViewCellIdentifier];
    [_tableView registerClass:[PropertyFeeOtherInfoHeaderView class] forHeaderFooterViewReuseIdentifier:PropertyFeeOtherInfoHeaderViewIdentifier];
    //优惠信息
    [_tableView registerClass:[SpecialOffersListViewCell class] forCellReuseIdentifier:SpecialOffersListViewCellIdentifier];
    
    if (!_propertyFeeListMArray) {
        
        _propertyFeeListMArray = [NSMutableArray new];
    }
    if (!_specialOffersListMArray) {
        _specialOffersListMArray = [NSMutableArray new];
    }
    if (!_propertyFeeOtherInfoModel) {
        _propertyFeeOtherInfoModel = [[PropertyFeeOtherInfoModel alloc] init];
    }
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 6) {
        return _specialOffersListMArray.count;
    }
    if (section == 0) {
        SectionModel *s = _dataArray[section];
        if(s.isExpand) {
            return _propertyFeeListMArray.count;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kGetVerticalDistance(100);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        PropertyFeeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PropertyFeeCellIdentifier forIndexPath:indexPath];
        PropertyFeeListModel *model =  _propertyFeeListMArray[indexPath.row];
        if (model.detail && model.detail.length>0) {
            
            cell.propertyFeeTitleLabel.text = model.detail;
        }
        if (model.price && [model.price stringValue].length > 0) {
            
            cell.feeMoneyCountLabel.text = [NSString stringWithFormat:@"￥ %@ 元",[model.price stringValue]];
        } 
        return cell;
    }else if (indexPath.section == 6){
        SpecialOffersListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SpecialOffersListViewCellIdentifier forIndexPath:indexPath];
//            cell.specialOffersDetailLabel.text = @"一次性预交1年减免一个月";
        
        SpecialOffersListModel *model = _specialOffersListMArray[indexPath.row];
        if (model.discountcontent && model.discountcontent.length > 0) {
            
            cell.specialOffersDetailLabel.text = model.discountcontent;
        }
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = backView;
        cell.delegate = self;
        return cell;
    }else{
        return nil;
    }
}
//分区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        PropertyFeeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PropertyFeeHeaderViewCellIdentifier];
        headerView.delegate = self;
        headerView.section = section;
        SectionModel *s = _dataArray[section];
        [headerView refreshArrowStatusWithExpand:s.isExpand];

        return headerView;
    }else{
        PropertyFeeOtherInfoHeaderView *otherInfoHeaderView  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PropertyFeeOtherInfoHeaderViewIdentifier];
        
        switch (section) {
            case 1:{
                otherInfoHeaderView.titleLabel.textColor = [UIColor blackColor];
                otherInfoHeaderView.titleLabel.text = @"缴费账期:";
                if (_propertyFeeOtherInfoModel.feeperiod.length > 0) {
                    
                    otherInfoHeaderView.detailLabel.text = _propertyFeeOtherInfoModel.feeperiod;
                }
            }
                break;
            case 2:{
                otherInfoHeaderView.titleLabel.text = @"应缴金额:";
                if (_propertyFeeOtherInfoModel.totalFee && [_propertyFeeOtherInfoModel.totalFee stringValue].length > 0) {
                    
                    otherInfoHeaderView.detailLabel.text = [NSString stringWithFormat:@"￥%@",_propertyFeeOtherInfoModel.totalFee];
                }
            }
                break;
            case 3:{
                otherInfoHeaderView.titleLabel.text = @"缴费账号:";
                if (_propertyFeeOtherInfoModel.feeAccount) {
                    
                    otherInfoHeaderView.detailLabel.text = [NSString stringWithFormat:@"%@",_propertyFeeOtherInfoModel.feeAccount];
                }
            }
                break;
            case 4:{
                otherInfoHeaderView.titleLabel.text = @"户     名:";
                if (_propertyFeeOtherInfoModel.houseMaster) {
                    
                    otherInfoHeaderView.detailLabel.text = _propertyFeeOtherInfoModel.houseMaster;
                }
            }
                break;
            case 5:{
                otherInfoHeaderView.titleLabel.text = @"住户信息:";
                if (_propertyFeeOtherInfoModel.houseInfo && _propertyFeeOtherInfoModel.houseInfo.length > 0) {
                    
                    otherInfoHeaderView.detailLabel.text = _propertyFeeOtherInfoModel.houseInfo;
                }
            }
                break;
            case 6:{
                otherInfoHeaderView.titleLabel.text = @"优惠活动:";
                otherInfoHeaderView.detailLabel.text = @"";
                otherInfoHeaderView.titleLabel.textColor = [UIColor redColor];
            }
                break;
                
            default:
                break;
                
        }
        return otherInfoHeaderView;
    }
    
}
//缴费明细的展开/闭合
-(void)headerView:(PropertyFeeHeaderView *)headerView didSelectAtSection:(NSInteger)section{
    
    SectionModel *s = _dataArray[section];
    s.isExpand = !s.isExpand;
        
    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < [_dataArray[section].cells count]; i++) {
//        [array addObject:[NSIndexPath indexPathForRow:i inSection:section]];
//    }
    for (int i = 0; i < _propertyFeeListMArray.count; i++) {
        [array addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    if (array.count == 0) {
        return;
    }
    if (s.isExpand) {
        [_tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableView scrollToRowAtIndexPath:[array firstObject] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }else{
        [_tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
#pragma mark--优惠活动
-(void)userSelectButtonWithSpecialOffersListViewCell:(SpecialOffersListViewCell *)cell{
    
    for (int i = 0; i < _specialOffersListMArray.count; i++) {
        
        SpecialOffersListViewCell *allCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:6]];
        allCell.selectButton.selected = NO;
        [allCell.selectButton setImage:[UIImage imageNamed:@"No choice"] forState:UIControlStateNormal];
        
    }
    
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    ICLog_2(@"%ld",indexPath.row);
    cell.selectButton.selected = !cell.selectButton.selected;
    if (cell.selectButton.selected) {
        
        [cell.selectButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        
    }else{
        
        [cell.selectButton setImage:[UIImage imageNamed:@"No choice"] forState:UIControlStateNormal];
    }
    [HUD showProgress:@"数据正在加载"];
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionary];
    [parametersDictionary setValue:@"27" forKey:@"userId"];
    [parametersDictionary setValue:@"2" forKey:@"discountId"];
    [parametersDictionary setValue:@"1" forKey:@"houseId"];
    User *user = [User currentUser];
    [parametersDictionary setValue:user.sessionId forKey:@"sessionId"];
    
    
    [[RequestManager manager] SessionRequestWithType:Pro_api requestWithURLString:@"find/propertyfee/bydiscount" requestType:RequestMethodPost requestParameters:parametersDictionary success:^(id  _Nullable responseObject) {
        
        [HUD dismiss];
        ICLog_2(@"%@",responseObject);
        NSDictionary *dictionary = [responseObject[@"body"] firstObject];
        if ([dictionary[@"resultCode"] integerValue] == 1000) {
            
            //更新缴费账期内容
            _propertyFeeOtherInfoModel.feeperiod = dictionary[@"feeperiod"];
            //更新缴费金额
            _propertyFeeOtherInfoModel.totalFee = dictionary[@"totalFee"];
            
            
            //物业费明细单
            [_propertyFeeListMArray removeAllObjects];
            for (NSDictionary *dic in dictionary[@"detailList"]) {
                PropertyFeeListModel *model = [[PropertyFeeListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_propertyFeeListMArray addObject:model];
            }
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    } faile:^(NSError * _Nullable error) {
        ICLog_2(@"%@",error);

    }];
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
