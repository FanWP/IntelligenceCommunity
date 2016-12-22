//
//  HouseAuthorityVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseAuthorityVC.h"

#import "HouseAuthorityTelNumberVC.h"// 添加房屋-输入业主手机号


@interface HouseAuthorityVC ()

@property (nonatomic,strong) UILabel *ridgepoleLabel;// 栋
@property (nonatomic,strong) UILabel *unitLabel;// 单元
@property (nonatomic,strong) UILabel *roomNumberLabel;// 房号
@property (nonatomic,strong) UIButton *nextStepButton;// 下一步

@property (nonatomic,strong) UITextField *ridgepoleTF;
@property (nonatomic,strong) UITextField *unitTF;
@property (nonatomic,strong) UITextField *roomNumTF;

@end

@implementation HouseAuthorityVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"添加房屋";
    
    [self initializeComponent];
    
    [self dataRidgepole];
    [self dataUnit];
    [self dataRoom];
}


- (void)dataRidgepole
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"type"] = @"0";
    parameters[@"sessionId"] = SessionID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/house/type/list",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"楼栋号返回：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        ICLog_2(@"楼栋号错误：%@",error);
    }];
}


- (void)dataUnit
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"type"] = @"1";
    parameters[@"buildNumber"] = @"1";
    parameters[@"sessionId"] = SessionID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/house/type/list",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         ICLog_2(@"单元号返回：%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         ICLog_2(@"单元号错误：%@",error);
     }];
}


- (void)dataRoom
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"type"] = @"1";
    parameters[@"buildNumber"] = @"1";
    parameters[@"unitNumber"] = @"1";
    parameters[@"sessionId"] = SessionID;
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/house/type/list",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         ICLog_2(@"房号返回：%@",responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         ICLog_2(@"房号错误：%@",error);
     }];
}



- (void)initializeComponent
{
    // 栋
    _ridgepoleLabel = [[UILabel alloc] init];
    _ridgepoleLabel.text = @"楼栋";
    _ridgepoleLabel.font = UIFontNormal;
    [self.view addSubview:_ridgepoleLabel];
    [_ridgepoleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(35);
        make.right.mas_offset(-35);
        make.top.offset(64 + 42);
        make.height.offset(30);
    }];
    
    
    // 选择几栋
    _ridgepoleTF = [[UITextField alloc] init];
    _ridgepoleTF.text = @"1";
    _ridgepoleTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_ridgepoleTF];
    [_ridgepoleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_ridgepoleLabel);
        make.top.equalTo(_ridgepoleLabel.mas_bottom).offset(16);
        make.height.mas_offset(35);
    }];
    
    
    // 单元
    _unitLabel = [[UILabel alloc] init];
    _unitLabel.text = @"单元";
    _unitLabel.font = UIFontNormal;
    [self.view addSubview:_unitLabel];
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ridgepoleLabel.mas_left);
        make.top.equalTo(_ridgepoleTF.mas_bottom).offset(42);
        make.width.equalTo(_ridgepoleLabel.mas_width);
        make.height.equalTo(_ridgepoleLabel.mas_height);
    }];
    
    
    // 选择几单元
    _unitTF = [[UITextField alloc] init];
    _unitTF.text = @"1";
    _unitTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_unitTF];
    [_unitTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_ridgepoleLabel);
        make.top.equalTo(_unitLabel.mas_bottom).mas_offset(16);
        make.height.equalTo(_ridgepoleTF.mas_height);
    }];
    
    
    
    // 房号
    _roomNumberLabel = [[UILabel alloc] init];
    _roomNumberLabel.text = @"房号";
    _roomNumberLabel.font = UIFontNormal;
    [self.view addSubview:_roomNumberLabel];
    [_roomNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ridgepoleLabel.mas_left);
        make.top.equalTo(_unitTF.mas_bottom).offset(42);
        make.width.equalTo(_ridgepoleLabel.mas_width);
        make.height.equalTo(_ridgepoleLabel.mas_height);
    }];
    
    
    // 选择几号房
    _roomNumTF = [[UITextField alloc] init];
    _roomNumTF.text = @"1";
    _roomNumTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_roomNumTF];
    [_roomNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_ridgepoleLabel);
        make.top.equalTo(_roomNumberLabel.mas_bottom).offset(16);
        make.height.equalTo(_ridgepoleTF.mas_height);
    }];
    
    
    // 下一步
    _nextStepButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _nextStepButton.backgroundColor = HexColor(0x04c5a1);
    [_nextStepButton setTitle:@"下一步" forState:(UIControlStateNormal)];
    _nextStepButton.layer.cornerRadius = 5.0;
    [self.view addSubview:_nextStepButton];
    [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-44 + 21);
        make.height.offset(49);
    }];
    
    
    // 添加下一步的点击事件
    [_nextStepButton addTarget:self action:@selector(nextStepAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

// 下一步的点击事件
- (void)nextStepAction
{
    HouseAuthorityTelNumberVC *houseAuthorityTelNumberVC = [[HouseAuthorityTelNumberVC alloc] init];
    [self.navigationController pushViewController:houseAuthorityTelNumberVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
