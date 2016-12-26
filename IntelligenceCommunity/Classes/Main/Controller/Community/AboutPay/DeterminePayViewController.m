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
    self.navigationController.navigationBar.translucent = NO;

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
    
    _bottomView = [[DeterminePayBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-64-50, ScreenWidth, 50)];
    //全选按钮
    [_bottomView.selectAllCommodityButton addTarget:self action:@selector(selectionAllCommodityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //提交订单
    [_bottomView.commitOrderButton addTarget:self action:@selector(commitOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_bottomView];
    
    if (_orderMArray.count) {
        
        _allCommodityIsSelectState = YES;
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
        
        //总金额富文本
        NSString *string = [NSString stringWithFormat:@"%.2f",[ShoppingCartModel getShoppingCartCommodityTotalPrice:_orderMArray]];
        NSString *commodityTotalPrice = [NSString stringWithFormat:@"合计金额: ￥%@",string];
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:commodityTotalPrice];
        [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]} range:[commodityTotalPrice rangeOfString:string]];
        _bottomView.commodityTotalPriceLabel.attributedText = attributedString;
        
        
        _selectCommodityTotalPriceString = string;
    }else{
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"Choice"] forState:UIControlStateNormal];
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
            [cell.selectButton setImage:[UIImage imageNamed:@"Choice"] forState:UIControlStateNormal];
            //总金额富文本
            NSString *string = @"0.00";
            NSString *commodityTotalPrice = [NSString stringWithFormat:@"合计金额: ￥%@",string];
            
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:commodityTotalPrice];
            [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]} range:[commodityTotalPrice rangeOfString:string]];
            _bottomView.commodityTotalPriceLabel.attributedText = attributedString;
            
            _selectCommodityTotalPriceString = string;
        }else{                                  //选中所有商品
            cell.selectButton.selected = YES;
            [cell.selectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
            
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
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"Choice"] forState:UIControlStateNormal];
    }else{
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
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
        
//        [self AliPay];
    }
}
//单个商品的选中/取消操作
-(void)commodityInfoViewCell:(CommodityInfoViewCell *)commodityInfoViewCell withButton:(UIButton *)button{
    
    //改变该商品的选中状态
    if (commodityInfoViewCell.selectButton.selected) {
        [commodityInfoViewCell.selectButton setImage:[UIImage imageNamed:@"Choice"] forState:UIControlStateNormal];
    }else{
        [commodityInfoViewCell.selectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
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
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
    }else{
        [_bottomView.selectAllCommodityButton setImage:[UIImage imageNamed:@"Choice"] forState:UIControlStateNormal];
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
    
    return indexPath.row==0 ? 130 : 80;
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
    
    if (indexPath.row==0) {     //收货地址
        return;
    }
    ProListModel *model = _orderMArray[indexPath.row-1];
    
    DeterminePayToCommodityDetailVC *VC = [[DeterminePayToCommodityDetailVC alloc] init];
    VC.model = model;
    [self.navigationController pushViewController:VC animated:YES];
    
}
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)AliPay{
    
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    //    Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088421934186781";
    NSString *seller = @"yoyosiji@163.com";     //3455287891@qq.com     //yoyosiji@163.com
    NSString *privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKtlsUPly6KAvkQbjzFNWjX0jpssmdXhDC3V+j7jMvCcQEjwRL2DHNwqfgveo34Y84Oa5LJ6foPz4qvUIcRuQtymEAlZQwPoF70gzxb7vWSp6I91uqwrQtgFowm6gg4JfE/V3UaiIosdtTQKI3oEScXXAGU4daiASYP4dMXuxOpXAgMBAAECgYABh6naak20CKQqJXjUvtUEUEeJmQ9SemzKZ/OQ5iRJQ4vLWuGyM15plLOFVZpuALkDvrk14qQId3/Zes5GW5mbLN6YbGDqp2i63xAv2tkqQZ58nDYD4ZfGtGN1sXjLAcwhI72ubFtrgue+ygekPb/dzmMm93HwltRYiKNgSuh2eQJBANdViIRSoEC8d3aFMChtlDYlP/BB/gI661LDa02cfpSBknEkiXpJb1Z1Qy8hjN3HxLc398CZM6qY/zyhXggFnt0CQQDLxACf1v5sjJlWriZDVJUIOV04Lc8m/irETkwva0IuBwU3ufrXZaNLS3PMYMS4Lw20Jluz2rDjSKWPqr0cPgjDAkB4z7s9CiJwz4xyyXzgYcJSsolx4YSCec4HbC5qp894wE2J/wbGviaiKj4cVkVzNJ5QcS0mOI39O8OPn7Vi6MxdAkAjEX2GBMtOxTfSqjAdoF3xx2WauI+RR2b21/7WnmAKadzlBVX9YhmjaL3qK7FPfZGfMobPwlB1HViZDCp1xNtfAkAiSZkBlnFZbCnE4faqphj/GQRj7tTbkjmGmrp+XW9c83yhI2YKySwbLF6r2u+q6PIiExpzakm7tRjRDoe0pHpE";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = [self generateTradeNO];  //订单ID（由商家自行制定）
    order.subject = @"这是商品标题";                    //商品标题
    order.body = @"亲,包邮哦!";                        //商品描述
    order.totalFee = @"0.01";                   //价格
    order.notifyURL =  @"http://www.yoyosiji.com:32106/AlipayInterface/alipay/notify"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"IntelligenceCommunity";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"-------------------reslut = %@",resultDic);
            NSInteger backCode = [resultDic[@"resultStatus"] integerValue];
            NSLog(@"-----------------------%ld",backCode);
            switch (backCode) {
                case 9000:
                    NSLog(@"支付成功");
                    
                    break;
                case 8000:
                    NSLog(@"正在处理中");
                    break;
                case 4000:
                    NSLog(@"订单支付失败");
                    break;
                case 6001:
                    NSLog(@"用户中途取消");
                    break;
                case 6002:
                    NSLog(@"网络连接出错");
                    break;
                default:
                    break;
            }
            
        }];
    }
}
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
