//
//  ReceiveAddressTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ReceiveAddressTableVC.h"

#import "AddReceiveAddressVC.h"// 添加地址
#import "EditReceiveAddressVC.h"// 编辑地址

#import "ReceiveAddressCell.h"// 收货地址列表cell

#import "ReceiveAddressModel.h"

@interface ReceiveAddressTableVC ()

@property (nonatomic,strong) UIView *addReceiveAddressView;
@property (nonatomic,strong) UIButton *addReceiveAddressButton;// 添加地址

@property (nonatomic,strong) ReceiveAddressModel *receiveAddressModel;
@property (nonatomic,strong) NSMutableArray *receiveAddressArray;// 接收收货地址数据的数组

@end

@implementation ReceiveAddressTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收货地址";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)dataReceiveAddressList
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"userId"] = UserID;
    parameters[@"sessionId"] = SessionID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/address/list",URL_17_mall_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        ICLog_2(@"收货列表返回：%@",responseObject[@"body"]);
        
        if (resultCode == 1000)
        {
            _receiveAddressArray = [ReceiveAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"body"]];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        ICLog_2(@"收货列表错误：：%@",error);
    }];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self dataReceiveAddressList];
    
    [self creatAddReceiveAddressButton];
}

- (void)creatAddReceiveAddressButton
{
    _addReceiveAddressView = [[UIView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:_addReceiveAddressView];
    [_addReceiveAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.mas_offset(0);
        make.height.mas_offset(44);
    }];
    
    _addReceiveAddressButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _addReceiveAddressButton.backgroundColor = [UIColor orangeColor];
    [_addReceiveAddressButton setTitle:@"添加收货地址" forState:(UIControlStateNormal)];
    [_addReceiveAddressButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_addReceiveAddressButton.titleLabel setFont:UIFontNormal];
    [_addReceiveAddressView addSubview:_addReceiveAddressButton];
    [_addReceiveAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.equalTo(_addReceiveAddressView.mas_height);
    }];
    [_addReceiveAddressButton addTarget:self action:@selector(addReceiveAddressAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_addReceiveAddressView addSubview:_addReceiveAddressButton];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_addReceiveAddressView removeFromSuperview];
}


- (void)addReceiveAddressAction
{
    AddReceiveAddressVC *addReceiveAddressVC = [[AddReceiveAddressVC alloc] init];
    [self.navigationController pushViewController:addReceiveAddressVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _receiveAddressArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    ReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[ReceiveAddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    _receiveAddressModel = _receiveAddressArray[indexPath.row];
    
    cell.receiverLabel.text = [NSString stringWithFormat:@"收货人：%@",_receiveAddressModel.person];
    cell.receiverPhoneNumLabel.text = _receiveAddressModel.telephone;
    cell.receiveAddressLabel.text = _receiveAddressModel.area;
    
    [cell.defaultAddressButton addTarget:self action:@selector(changeDefautAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [cell.editAddressButton addTarget:self action:@selector(editAddressAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [cell.deleteAddressButton addTarget:self action:@selector(deleteAddressAction) forControlEvents:(UIControlEventTouchUpInside)];

    return cell;
}

- (void)changeDefautAddressAction:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)editAddressAction
{
    EditReceiveAddressVC *editReceiveAddressVC = [[EditReceiveAddressVC alloc] init];
    editReceiveAddressVC.receiveAddressModel = _receiveAddressModel;
    [self.navigationController pushViewController:editReceiveAddressVC animated:YES];
}

- (void)deleteAddressAction
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"ids"] = @"23";
    parameters[@"userId"] = UserID;
    parameters[@"sessionId"] = SessionID;
    
    ICLog_2(@"删除地址参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@delete/address",URL_17_mall_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            [HUD showSuccessMessage:@"删除成功"];
            
            [self dataReceiveAddressList];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        ICLog_2(@"删除错误：%@",error);
    }];
}


@end



























