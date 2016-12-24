//
//  HouseAuthorityVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseAuthorityVC.h"

#import "DMDropDownMenu.h"// 下拉选项
#import "HouseAuthorityTelNumberVC.h"// 添加房屋-输入业主手机号

#import "HouseAuthorityModel.h"

@interface HouseAuthorityVC ()<DMDropDownMenuDelegate>

@property (nonatomic,strong) UILabel *ridgepoleLabel;// 栋
@property (nonatomic,strong) DMDropDownMenu *ridgepoleView;// 选择几栋
@property (nonatomic,strong) UILabel *unitLabel;// 单元
@property (nonatomic,strong) DMDropDownMenu *unitView;// 选择单元
@property (nonatomic,strong) UILabel *roomNumberLabel;// 房号
@property (nonatomic,strong) DMDropDownMenu *roomNumberView;// 选择房号
@property (nonatomic,strong) UIButton *nextStepButton;// 下一步

@property (nonatomic,strong) NSMutableArray *ridgepoleArray;// 楼栋数组
@property (nonatomic,strong) NSMutableArray *unitArray;// 单元数组
@property (nonatomic,strong) NSMutableArray *roomNumberArray;// 房号数组

@property (nonatomic,strong) NSString *selectRidgepoleNumber;// 选中的楼栋号
@property (nonatomic,strong) NSString *selectUnitNumber;// 选中的单元号
@property (nonatomic,strong) NSString *selectRoomNumber;// 选中的房间号

@property (nonatomic,strong) NSArray *nilArray;

@end

@implementation HouseAuthorityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加房屋";
    
    _selectRidgepoleNumber = @"1";
    
    [self dataRidgepole];
    
    [self dataUnit];
    
    [self dataRoom];
    
    [self initializeComponent];
    
    _nilArray = [NSArray array];
    
    _ridgepoleArray = [NSMutableArray array];
    _unitArray = [NSMutableArray array];
    _roomNumberArray = [NSMutableArray array];
    
}



- (void)selectIndex:(NSInteger)index AtDMDropDownMenu:(DMDropDownMenu *)dmDropDownMenu
{
    ICLog_2(@"index:%ld",index);
    if ([dmDropDownMenu isEqual:_ridgepoleView])
    {
        ICLog_2(@"选中楼号：%@",_ridgepoleArray[index]);
        
        _selectRidgepoleNumber = _ridgepoleArray[index];
        
        [self dataUnit];
        
        [self dataRoom];
    }
    else if ([dmDropDownMenu isEqual:_unitView])
    {
        _selectUnitNumber = _unitArray[index];
        
        [self dataRoom];
    }
    
}


- (void)dataRidgepole
{
    [_ridgepoleArray removeAllObjects];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"type"] = @"0";
    parameters[@"sessionId"] = SessionID;
    
    ICLog_2(@"获取楼号参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/house/type/list",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         ICLog_2(@"楼栋号返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             for (NSDictionary *dic in responseObject[@"body"])
             {
                 NSNumber *number = [dic objectForKey:@"number"];
                 
                 NSString *ridgepoleNumber = [NSString stringWithFormat:@"%@",number];
                 
                 [_ridgepoleArray addObject:ridgepoleNumber];
             }
             
             [_ridgepoleView setListArray:_ridgepoleArray];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         _ridgepoleArray = nil;
         
         ICLog_2(@"楼栋号错误：%@",error);
     }];
}



- (void)dataUnit
{
    [_unitArray removeAllObjects];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"type"] = @"1";
    parameters[@"buildNumber"] = _selectRidgepoleNumber;
    parameters[@"sessionId"] = SessionID;
    
    ICLog_2(@"获取单元号参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/house/type/list",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         ICLog_2(@"单元号返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             for (NSDictionary *dic in responseObject[@"body"])
             {
                 NSNumber *number = [dic objectForKey:@"number"];
                 
                 NSString *ridgepoleNumber = [NSString stringWithFormat:@"%@",number];
                 
                 [_unitArray addObject:ridgepoleNumber];
             }
             
             [_unitView setListArray:_unitArray];
         }
         else
         {
             _unitArray = nil;
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         _unitArray = nil;
         
         ICLog_2(@"单元号错误：%@",error);
     }];
}


- (void)dataRoom
{
    [_roomNumberArray removeAllObjects];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"type"] = @"1";
    parameters[@"buildNumber"] = _selectRidgepoleNumber;
    parameters[@"unitNumber"] = _selectUnitNumber;
    parameters[@"sessionId"] = SessionID;
    
    ICLog_2(@"获取房间号参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@find/house/type/list",URL_17_pro_api];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         ICLog_2(@"房号返回：%@",responseObject);
         
         NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
         
         if (resultCode == 1000)
         {
             for (NSDictionary *dic in responseObject[@"body"])
             {
                 NSNumber *number = [dic objectForKey:@"number"];
                 
                 NSString *ridgepoleNumber = [NSString stringWithFormat:@"%@",number];
                 
                 [_roomNumberArray addObject:ridgepoleNumber];
             }
             
             [_roomNumberView setListArray:_roomNumberArray];
         }
         else
         {
             _roomNumberArray = nil;
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         _roomNumberArray = nil;
         
         ICLog_2(@"房号错误：%@",error);
     }];
}



- (void)initializeComponent
{
    // 栋
    _ridgepoleLabel = [[UILabel alloc] init];
    _ridgepoleLabel.text = @"楼栋";
    _ridgepoleLabel.font = UIFont15;
    [self.view addSubview:_ridgepoleLabel];
    [_ridgepoleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(35);
        make.right.mas_offset(-35);
        make.top.offset(64 + 42);
        make.height.offset(30);
    }];
    
    
    
    
    
    //    // 选择几栋
    NSArray * dmArray1 = [NSArray arrayWithObjects:@"iPhone",@"iMac",@"iTouch",@"MacBook Air 13寸",@"MacBook Air 15 寸",@"MacBook Pro 13 寸",@"MacBook Pro 15 寸", nil];
    NSArray * dmArray2 = [NSArray arrayWithObjects:@"今晚与你记住蒲公英今晚与你记住蒲公英今晚与你记住蒲公英",@"今晚偏偏想起风的清劲",@"今晚偏偏想起风的清劲",@"回忆不在受制于我 我承认",@"回忆也许是你的", nil];
    //
    CGFloat ridgepoleViewY = 64 + 42 + 30 + 16;
    CGFloat width = KWidth - 2 * 35;
    _ridgepoleView = [[DMDropDownMenu alloc] initWithFrame:CGRectMake(35, ridgepoleViewY, width, 35)];
    _ridgepoleView.delegate = self;
    //    [_ridgepoleView setListArray:_ridgepoleArray];
    [self.view addSubview:_ridgepoleView];
    
    
    
    // 单元
    _unitLabel = [[UILabel alloc] init];
    _unitLabel.text = @"单元";
    _unitLabel.font = UIFont15;
    [self.view addSubview:_unitLabel];
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ridgepoleLabel.mas_left);
        make.top.equalTo(_ridgepoleView.mas_bottom).offset(42);
        make.width.equalTo(_ridgepoleLabel.mas_width);
        make.height.equalTo(_ridgepoleLabel.mas_height);
    }];
    
    
    
    // 选择单元
    CGFloat unitViewY = ridgepoleViewY + 35 + 42 + 30 + 16;
    _unitView = [[DMDropDownMenu alloc] initWithFrame:CGRectMake(35, unitViewY, width, 35)];
    _unitView.delegate = self;
    //    [_unitView setListArray:dmArray1];
    [self.view addSubview:_unitView];
    
    
    
    
    // 房号
    _roomNumberLabel = [[UILabel alloc] init];
    _roomNumberLabel.text = @"房号";
    _roomNumberLabel.font = UIFont15;
    [self.view addSubview:_roomNumberLabel];
    [_roomNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ridgepoleLabel.mas_left);
        make.top.equalTo(_unitView.mas_bottom).offset(42);
        make.width.equalTo(_ridgepoleLabel.mas_width);
        make.height.equalTo(_ridgepoleLabel.mas_height);
    }];
    
    
    
    // 选择房号
    CGFloat roomNumberViewY = unitViewY + 35 + 42 + 30 + 16;
    _roomNumberView = [[DMDropDownMenu alloc] initWithFrame:CGRectMake(35, roomNumberViewY, width, 35)];
    _roomNumberView.delegate = self;
    //    [_roomNumberView setListArray:dmArray2];
    [self.view addSubview:_roomNumberView];
    
    
    
    // 下一步
    _nextStepButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _nextStepButton.backgroundColor = HexColor(0x04c5a1);
    [_nextStepButton.titleLabel setFont:UIFontLarge];
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
