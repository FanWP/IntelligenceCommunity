//
//  CommodityListViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommodityListViewController.h"
#import "PopTableViewCustom.h"  //双表
#import "ProListModel.h"        //数据模型

#import "ShoppingCartBottomView.h"  //购物车按钮、总价栏
#import "ShoppingCartView.h"    //购物车列表
#import "ShoppingCartModel.h"   //购物车数据模型
#import "CommodityListHeaderView.h"

#import "CommodityDetailViewController.h"  //商品详情:商店、美食

#import "DeterminePayViewController.h"  //支付界面


//PopTableViewCustomDelegate--查看某件商品的详情
@interface CommodityListViewController ()<PopTableViewCustomDelegate>

@property(nonatomic,strong) NSMutableArray *categoryNameMArray; //左边大类目录
@property(nonatomic,strong) NSMutableArray *dataMArray;         //数据源

@end

@implementation CommodityListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self defaultViewStyle];
    self.navigationController.navigationBar.translucent = NO;
    [self initializeComponent];
    
    if (!_categoryNameMArray) {
        _categoryNameMArray = [NSMutableArray new];
    }
    if (!_dataMArray) {
        _dataMArray = [NSMutableArray new];
    }
}
-(void)initializeComponent{
    
    //顶部店铺基本信息
    CommodityListHeaderView *headerView = [[CommodityListHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kGetVerticalDistance(196))];
    
    [self.view addSubview:headerView];
    //tableView双表
    _popTableView = [[PopTableViewCustom alloc] initWithFrame:CGRectMake(0,kGetVerticalDistance(196), ScreenWidth,ScreenHeight-kGetVerticalDistance(196)-50-10) leftArray:nil rightArray:nil];
    _popTableView.ViewController = self;
    _popTableView.delegate = self;
    [self.view addSubview:_popTableView];
        //数据
    [self dataRequest];
    
    //底部菜单
    _shoppingCartBottomView = [[ShoppingCartBottomView alloc] initWithFrame:CGRectMake(0,ScreenHeight-64-50, ScreenWidth, 50)];
        //购物车列表
    [_shoppingCartBottomView.shoppingCartButton addTarget:self action:@selector(showshoppingCartlist:) forControlEvents:UIControlEventTouchUpInside];
        //去结算
    [_shoppingCartBottomView.goSettlementButton addTarget:self action:@selector(goSettlementButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shoppingCartBottomView];
    
    
    
}
- (void)dataRequest{
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary new];
    [parametersDic setValue:@"1" forKey:@"venderId"];
    [parametersDic setValue:@"1" forKey:@"pageNum"];
    [parametersDic setValue:@"5" forKey:@"pageSize"];
    
    [HUD showProgress:@"数据正在加载"];
    
    [[RequestManager manager] SessionRequestWithType:Mall_api requestWithURLString:@"find/vendor/product/for/sale" requestType:RequestMethodPost requestParameters:parametersDic success:^(id  _Nullable responseObject) {
        
        [HUD dismiss];
        ICLog(@"%@",responseObject);
        for (NSDictionary *dic in responseObject[@"body"]) {        //dic==一个大类
            
            //大目录
            [_categoryNameMArray addObject:dic[@"typeName"]];
            
            //数据源
            NSMutableArray *productMArray = [NSMutableArray new];
            for (NSDictionary *productDic in dic[@"proList"]) {
                ProListModel *model = [[ProListModel alloc] init];
                [model setValuesForKeysWithDictionary:productDic];
                model.orderCount = @"0";
                [productMArray addObject:model];                    //一个商品大类
            }
            
            [_dataMArray addObject:productMArray];                  //大类列表-->大类*N
        }
        NSLog(@"%ld",_dataMArray.count);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _popTableView.categoryNameMArray = _categoryNameMArray;
            _popTableView.leftMArray = _dataMArray; //数据源
            [_popTableView.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        });
        

        
    } faile:^(NSError * _Nullable error) {
        [HUD dismiss];
        ICLog_2(@"%@",error);
    }];
}
//结算
- (void)goSettlementButtonAction:(UIButton *)button{
    //服务类商品:家政
    NSString *urlString = [@"create/salerecord?buytype=2&userid=1&price=200&address=高新三路&productid=1,2&appointstart=2012-12-2 10:10:00&appointend=2012-12-2 14:10:00&telephone=15091655498&username=小吴&vendorid=3" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[RequestManager manager] JSONRequestWithType:Mall_api urlString:urlString method:RequestMethodGet timeout:50 parameters:nil success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"resultCode"] integerValue] == 1000) {
            ICLog_2(@"success");
        }else{
            ICLog_2(@"faile");
        }
    } faile:^(NSError * _Nullable error) {
        
    }];
    //普通商品购买
    NSString *urlString_2 = [@"create/salerecord?buytype=1&userid=1&price=500&address=高新三路&productid=2,4&count=5&telephone=15091655498&username=小吴&vendorid=1" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[RequestManager manager] JSONRequestWithType:Mall_api urlString:urlString_2 method:RequestMethodGet timeout:50 parameters:nil success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"resultCode"] integerValue] == 1000) {
            ICLog_2(@"success");
        }else{
            ICLog_2(@"faile");
        }
    } faile:^(NSError * _Nullable error) {
        
    }];
    
    DeterminePayViewController *VC = [[DeterminePayViewController alloc] init];
    VC.orderMArray = self.popTableView.orderMArray;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark -- 购物车按钮
- (void)showshoppingCartlist:(UIButton *)button{
    
    ICLog_2(@"%d",button.selected);
    __weak typeof(self) weakSelf = self;
    button.selected = !button.selected;
    if (button.selected) {
        self.shoppingCartView =[[ShoppingCartView alloc]init];
//        self.shoppingCartView.frame =CGRectMake(0, (ScreenHeight-50), ScreenWidth,ScreenWidth);
        self.shoppingCartView.frame =CGRectMake(0,ScreenHeight-64, ScreenWidth,200);

        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,self.view.bounds.size.height-CGRectGetHeight(self.shoppingCartBottomView.frame))];
        bgView.alpha = .7;
        bgView.tag = 111;
        bgView.backgroundColor =[UIColor lightGrayColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeShopingCartViewAction:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        
        [bgView addGestureRecognizer:tap];
        
        [self.view addSubview:bgView];
        self.shoppingCartView.block = ^(NSMutableArray *darasArr,ProListModel *model){
            
            [weakSelf updateShoppingCartWithMArray:darasArr model:model];
//            [weakSelf updateShoppingCart:darasArr];
        };
        
        [self.shoppingCartView addShoppingCartView:self];

        [UIView animateWithDuration:.3 animations:^{
            
//            self.shoppingCartView.frame =CGRectMake(0, (ScreenHeight-CGRectGetHeight(self.shoppingCartBottomView.frame)-200), ScreenWidth,200);
            self.shoppingCartView.frame =CGRectMake(0,ScreenHeight-64-50-200, ScreenWidth,200);
            self.shoppingCartView.shoppingCartMArray = self.popTableView.orderMArray;
        } completion:^(BOOL finished){
            
            
        }];

    }else{
        [self.shoppingCartView removeSubView:self];
    }
    
}
#pragma mark--点击移除购物车列表
-(void)removeShopingCartViewAction:(UITapGestureRecognizer *)tap{
    [self.shoppingCartView removeSubView:self];
    _shoppingCartBottomView.shoppingCartButton.selected = NO;
}
#pragma mark -- 更新 数量 价钱
- (void)updateShoppingCartWithMArray:(NSMutableArray *)darasArr model:(ProListModel *)model{
    
    __weak typeof(self) weakSelf = self;
    ICLog_2(@"%ld-%ld",model.indexPath.section,model.indexPath.row);
    //数量
    weakSelf.shoppingCartBottomView.commodityCountLabel.text  = [NSString stringWithFormat:@"%ld",(long)[ShoppingCartModel getShoppingCartCommodityCount:darasArr]];
    //总价
    weakSelf.shoppingCartBottomView.commodityTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[ShoppingCartModel getShoppingCartCommodityTotalPrice:darasArr]];
    
    if (model) {
        
        [weakSelf.popTableView.rightTableView reloadRowsAtIndexPaths:@[model.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    //    [weakSelf.popTableView.rightTableView reloadData];
}
#pragma mark--查看商品详情
-(void)didSelectTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    ICLog_2(@"%@--section:%ld--row:%ld",tableView,indexPath.section,indexPath.row);
    
    ProListModel *model = _popTableView.leftMArray[indexPath.section][indexPath.row];
    
    
    CommodityDetailViewController *VC = [[CommodityDetailViewController alloc] init];
    VC.popTableView = self.popTableView;
    VC.model = model;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--当用户在详情界面对购物车中的商品数量做了操作之后,返回商品列表界面时候的数据同步
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;

    [self updateShoppingCartWithMArray:self.popTableView.orderMArray model:nil];
    [weakSelf.popTableView.rightTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
