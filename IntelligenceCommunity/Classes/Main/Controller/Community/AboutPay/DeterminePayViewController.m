//
//  DeterminePayViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "DeterminePayViewController.h"
#import "DeterminePaySendAddressCell.h" //收货地址
#import "CommodityInfoViewCell.h"       //商品信息列表cell
#import "DeterminePayBottomView.h"      //底部view

#import "ProListModel.h"        //商品数据模型
#import "ShoppingCartModel.h"   //计算商品总价格

#import "DeterminePayToCommodityDetailVC.h"     //查看详情
#import "PayMentViewController.h"               //进入支付界面

NSString *const DeterminePaySendAddressCellIdentifier = @"determinePaySendAddressCellIdentifier";
NSString *const CommodityInfoViewCellIdentifier = @"commodityInfoViewCellIdentifier";

//CommodityInfoViewCellDelegate  选择按钮的状态操作
@interface DeterminePayViewController ()<UITableViewDelegate,UITableViewDataSource,CommodityInfoViewCellDelegate>

@property(nonatomic,strong) UITableView *tableView;
//记录是否所有商品都处于选中状态
@property(nonatomic,assign) BOOL allCommodityIsSelectState;

//处于选中状态的商品总价
@property(nonatomic,strong) NSString *selectCommodityTotalPriceString;

@end

@implementation DeterminePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    self.navigationItem.title = @"确认支付";
    
    
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
    
    [_tableView registerClass:[DeterminePaySendAddressCell class] forCellReuseIdentifier:DeterminePaySendAddressCellIdentifier];
    [_tableView registerClass:[CommodityInfoViewCell class] forCellReuseIdentifier:CommodityInfoViewCellIdentifier];
    
    _bottomView = [[DeterminePayBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-50, ScreenWidth, 50)];
    //全选按钮
    [_bottomView.selectAllCommodityButton addTarget:self action:@selector(selectionAllCommodityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //提交订单
    [_bottomView.commitOrderButton addTarget:self action:@selector(commitOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_bottomView];
    
    if (_orderMArray.count) {
        
        _allCommodityIsSelectState = YES;
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
        
        //总金额富文本
        NSString *string = [NSString stringWithFormat:@"%.2f",[ShoppingCartModel getShoppingCartCommodityTotalPrice:_orderMArray]];
        NSString *commodityTotalPrice = [NSString stringWithFormat:@"合计金额: ￥%@",string];
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:commodityTotalPrice];
        [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]} range:[commodityTotalPrice rangeOfString:string]];
        _bottomView.commodityTotalPriceLabel.attributedText = attributedString;
        
        
        _selectCommodityTotalPriceString = string;
    }else{
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        _selectCommodityTotalPriceString = @"0";
    }
    
}
#pragma bottomView
//全选
-(void)selectionAllCommodityButtonAction:(UIButton *)button{
    
    if (!_orderMArray.count) {
        return;
    }
    
    for (int i = 0; i < _orderMArray.count; i++) {
       CommodityInfoViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i+1 inSection:0]];
        
        if (_allCommodityIsSelectState) {       //所有商品取消选中
            cell.selectButton.selected = NO;
            [cell.selectButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
            //总金额富文本
            NSString *string = @"0.00";
            NSString *commodityTotalPrice = [NSString stringWithFormat:@"合计金额: ￥%@",string];
            
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:commodityTotalPrice];
            [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]} range:[commodityTotalPrice rangeOfString:string]];
            _bottomView.commodityTotalPriceLabel.attributedText = attributedString;
            
            _selectCommodityTotalPriceString = string;
        }else{                                  //选中所有商品
            cell.selectButton.selected = YES;
            [cell.selectButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
            
            //总金额富文本
            NSString *string = [NSString stringWithFormat:@"%.2f",[ShoppingCartModel getShoppingCartCommodityTotalPrice:_orderMArray]];
            NSString *commodityTotalPrice = [NSString stringWithFormat:@"合计金额: ￥%@",string];
            
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:commodityTotalPrice];
            [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]} range:[commodityTotalPrice rangeOfString:string]];
            _bottomView.commodityTotalPriceLabel.attributedText = attributedString;
            
            _selectCommodityTotalPriceString = string;
        }
    }
    
    if (_allCommodityIsSelectState) {
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    }else{
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
    }
    
    _allCommodityIsSelectState = !_allCommodityIsSelectState;

}
//提交订单
-(void)commitOrderButtonAction:(UIButton *)button{
    
    if ([_selectCommodityTotalPriceString intValue] == 0) {      //用户未选中任何商品
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"当前未选中任何商品!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //预留
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:^{
            //预留
        }];
    }else{
        PayMentViewController *VC = [[PayMentViewController alloc] init];
        VC.payMentTotalPriceString = _selectCommodityTotalPriceString;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
//单个商品的选中/取消操作
-(void)commodityInfoViewCell:(CommodityInfoViewCell *)commodityInfoViewCell withButton:(UIButton *)button{
    
    //改变该商品的选中状态
    if (commodityInfoViewCell.selectButton.selected) {
        [commodityInfoViewCell.selectButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    }else{
        [commodityInfoViewCell.selectButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
    }
    commodityInfoViewCell.selectButton.selected = !commodityInfoViewCell.selectButton.selected;

    
    BOOL remark = YES;
    double commodityTotalPrice = 0.0;
    for (int i = 0; i < _orderMArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i+1 inSection:0];
        CommodityInfoViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        
        //1、判断当前是否所有商品都处于选中状态-->改变bottomView全选按钮的状态
        if (!cell.selectButton.selected) {
            remark = NO;
        }
        //2、根据商品选中状态计算总价
        ProListModel *model = _orderMArray[indexPath.row-1];
        if (cell.selectButton.selected) {
            commodityTotalPrice = commodityTotalPrice + [model.orderCount doubleValue] * [model.price doubleValue];
        }
        
        
    }
    
        //1、判断当前是否所有商品都处于选中状态-->改变bottomView全选按钮的状态
    _allCommodityIsSelectState = remark;
    if (_allCommodityIsSelectState) {
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
    }else{
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    }
        //2、根据商品选中状态计算总价
    //总金额富文本
    NSString *string = [NSString stringWithFormat:@"%.2f",commodityTotalPrice];
    NSString *commodityTotalPriceString = [NSString stringWithFormat:@"合计金额: ￥%@",string];
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:commodityTotalPriceString];
    [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]} range:[commodityTotalPriceString rangeOfString:string]];
    _bottomView.commodityTotalPriceLabel.attributedText = attributedString;
    
    _selectCommodityTotalPriceString = string;
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderMArray.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row==0 ? 100 : 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        DeterminePaySendAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:DeterminePaySendAddressCellIdentifier forIndexPath:indexPath];
        return cell;
    }else{
        CommodityInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommodityInfoViewCellIdentifier forIndexPath:indexPath];
        ProListModel *model = _orderMArray[indexPath.row-1];
        
        //商品名称
        if (model.productname && model.productname.length > 0) {
            cell.commodityNameLabel.text = model.productname;
        }
        //商品价格
        if (model.price) {
            cell.commodityPriceLabel.text = [NSString stringWithFormat:@"￥%@",[model.price stringValue]];
        }
        //商品信息
        if (model.introduction && model.introduction.length > 0) {
            cell.commodityDescriptionLabel.text = [NSString stringWithFormat:@"%@",model.introduction];
        }
        //商品数量
        if (model.orderCount && model.orderCount.length > 0) {
            cell.commodityCountLabel.text = [NSString stringWithFormat:@"数量:X%@",model.orderCount];
        }
        
        cell.delegate = self;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ICLog_2(@"%ld",indexPath.row);
    ProListModel *model = _orderMArray[indexPath.row-1];
    
    DeterminePayToCommodityDetailVC *VC = [[DeterminePayToCommodityDetailVC alloc] init];
    VC.model = model;
    [self.navigationController pushViewController:VC animated:YES];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
