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
{
    NSMutableArray *_data;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    
    NSInteger _currentDataIndex;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
}
@property (nonatomic,strong) UILabel *ridgepoleLabel;// 栋
@property (nonatomic,strong) UILabel *unitLabel;// 单元
@property (nonatomic,strong) UILabel *roomNumberLabel;// 房号
@property (nonatomic,strong) UIButton *nextStepButton;// 下一步

@end

@implementation HouseAuthorityVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"添加房屋";
    
    [self initializeComponent];
    
    _data = [NSMutableArray arrayWithObjects:@"1栋", @"2栋", @"3栋", @"4栋", @"5栋", @"6栋", @"7栋", nil];
    _data2 = [NSMutableArray arrayWithObjects:@"1单元", @"2单元", @"3单元", @"4单元", @"5单元", @"6单元", @"7单元", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"1号房", @"2号房", @"3号房", @"4号房", @"5号房", @"6号房", @"7号房", nil];
    
}


- (void)initializeComponent
{
    // 栋
    _ridgepoleLabel = [[UILabel alloc] init];
    _ridgepoleLabel.text = @"楼栋";
    _ridgepoleLabel.font = UIFontNormal;
    [self.view addSubview:_ridgepoleLabel];
    [_ridgepoleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.offset(64 + 40);
        make.width.offset(40);
        make.height.offset(30);
    }];
    
    
//    CGFloat menuX = 90;
//    CGFloat menuWidth = KWidth - 2 * 40 - 40 - 10;
//    CGFloat menuHeight = 30;
    // 选择几栋
//    CGFloat ridgepoleMenuY = 64 + 40;
//    DropDownView *ridgepoleMenu = [[DropDownView alloc] initWithOrigin:CGPointMake(menuX, ridgepoleMenuY) width:menuWidth andHeight:menuHeight];
//    ridgepoleMenu.tag = 111;
//    ridgepoleMenu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
//    ridgepoleMenu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
//    ridgepoleMenu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
//    ridgepoleMenu.dataSource = self;
//    ridgepoleMenu.delegate = self;
//    [self.view addSubview:ridgepoleMenu];

    
    // 单元
    _unitLabel = [[UILabel alloc] init];
    _unitLabel.text = @"单元";
    _unitLabel.font = UIFontNormal;
    [self.view addSubview:_unitLabel];
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ridgepoleLabel.mas_left);
        make.top.equalTo(_ridgepoleLabel.mas_bottom).offset(10);
        make.width.equalTo(_ridgepoleLabel.mas_width);
        make.height.equalTo(_ridgepoleLabel.mas_height);
    }];
    
    
    // 选择几单元
//    CGFloat unitMenuY = ridgepoleMenuY + menuHeight + 10;
//    DropDownView *unitMenu = [[DropDownView alloc] initWithOrigin:CGPointMake(menuX, unitMenuY) width:menuWidth andHeight:menuHeight];
//    unitMenu.tag = 112;
//    unitMenu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
//    unitMenu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
//    unitMenu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
//    unitMenu.dataSource = self;
//    unitMenu.delegate = self;
//    [self.view addSubview:unitMenu];
    
    // 房号
    _roomNumberLabel = [[UILabel alloc] init];
    _roomNumberLabel.text = @"房号";
    _roomNumberLabel.font = UIFontNormal;
    [self.view addSubview:_roomNumberLabel];
    [_roomNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ridgepoleLabel.mas_left);
        make.top.equalTo(_unitLabel.mas_bottom).offset(10);
        make.width.equalTo(_ridgepoleLabel.mas_width);
        make.height.equalTo(_ridgepoleLabel.mas_height);
    }];
    
    
    // 选择几号房
//    CGFloat roomNumberMenuY = unitMenuY + menuHeight + 10;
//    DropDownView *roomNumberMenu = [[DropDownView alloc] initWithOrigin:CGPointMake(menuX, roomNumberMenuY) width:menuWidth andHeight:menuHeight];
//    roomNumberMenu.tag = 113;
//    roomNumberMenu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
//    roomNumberMenu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
//    roomNumberMenu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
//    roomNumberMenu.dataSource = self;
//    roomNumberMenu.delegate = self;
//    [self.view addSubview:roomNumberMenu];
    
    
    // 下一步
    _nextStepButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _nextStepButton.backgroundColor = HexColor(0x04c5a1);
    [_nextStepButton setTitle:@"下一步" forState:(UIControlStateNormal)];
    _nextStepButton.layer.cornerRadius = 5.0;
    [self.view addSubview:_nextStepButton];
    [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.equalTo(_roomNumberLabel.mas_bottom).offset(40);
        make.right.offset(-40);
        make.height.offset(44);
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



//- (NSInteger)numberOfColumnsInMenu:(DropDownView *)menu {
//    
//    return 1;
//}
//
//-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
//    
//    return NO;
//}
//
//-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
//
//    return NO;
//}
//
//-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
//
//    return 1;
//}
//
//-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
//    if (self.view.tag == 111)
//    {
//        return _currentDataIndex;
//    }
//    else if (self.view.tag == 112)
//    {
//        return _currentData2Index;
//    }
//    else if (self.view.tag == 113)
//    {
//        return _currentData3Index;
//    }
//
//    return _currentDataIndex;
//}
//
//- (NSInteger)menu:(DropDownView *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
//    if (self.view.tag == 111)
//    {
//        return _data.count;
//    }
//    else if (self.view.tag == 112)
//    {
//        return _data2.count;
//    }
//    else if (self.view.tag == 113)
//    {
//        return _data3.count;
//    }
//
//    return _data.count;
//}
//
//- (NSString *)menu:(DropDownView *)menu titleForColumn:(NSInteger)column{
//    if (self.view.tag == 111)
//    {
//        return _data[0];
//    }
//    else if (self.view.tag == 112)
//    {
//        return _data[0];
//    }
//    else if (self.view.tag == 113)
//    {
//        return _data[0];
//    }
//
//    return _data[0];
//}
//
//- (NSString *)menu:(DropDownView *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
//    
//    if (self.view.tag == 111)
//    {
//        return _data[indexPath.row];
//    }
//    else if (self.view.tag == 112)
//    {
//        return _data2[indexPath.row];
//    }
//    else if (self.view.tag == 113)
//    {
//        return _data3[indexPath.row];
//    }
//    return _data[indexPath.row];
//}
//
//- (void)menu:(DropDownView *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
//    
//    if (self.view.tag == 111)
//    {
//        _currentDataIndex = indexPath.row;
//    }
//    else if (self.view.tag == 112)
//    {
//        _currentDataIndex = indexPath.row;
//    }
//    else if (self.view.tag == 113)
//    {
//        _currentDataIndex = indexPath.row;
//    }
//
//    _currentDataIndex = indexPath.row;
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
