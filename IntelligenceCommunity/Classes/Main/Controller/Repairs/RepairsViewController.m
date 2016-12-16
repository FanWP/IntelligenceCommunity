//
//  RepairsViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RepairsViewController.h"

#import "RepairStatusTableVC.h"// 报修状态

@interface RepairsViewController ()

@property (nonatomic,strong) UILabel *householdInfoLabel;// 住户信息
@property (nonatomic,strong) UILabel *repairContentLabel;// 报修内容描述
@property (nonatomic,strong) YYTextView *repairContentTextView;// 输入报修内容
@property (nonatomic,strong) UILabel *attachmentLabel;// 附件
@property (nonatomic,strong) UITextField *cameraAndPhotoLibraryBottomTF;// 图片附件底部的框
@property (nonatomic,strong) UIView *repairPictureView;// 报修图片的view
@property (nonatomic,strong) UIButton *handButton;// 提交
@property (nonatomic,strong) UILabel *propertyTelNumLabel;// 物业电话

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation RepairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"报修";
    
    [self initializeComponent];// 初始化
    
    [self dataRequest];// 报修数据
    
    [self rightItemRepairStatusList];// 报修状态
    
}



// 进入报修状态的按钮
- (void)rightItemRepairStatusList
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"News"] style:(UIBarButtonItemStylePlain) target:self action:@selector(repairStatusList)];
}



// 进入报修状态的点击事件
- (void)repairStatusList
{
    RepairStatusTableVC *repairStatusTableVC = [[RepairStatusTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    [self.navigationController pushViewController:repairStatusTableVC animated:YES];
}



// 初始化
- (void)initializeComponent
{
    // 住户信息
    _householdInfoLabel = [[UILabel alloc] init];
    //    _householdInfoLabel.text = [NSString stringWithFormat:@"住户信息：%@",];
    _householdInfoLabel.text = @"住户信息：龙湖水晶郦城1号楼2011室";
    _householdInfoLabel.font = UIFont15;
    _householdInfoLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_householdInfoLabel];
    [_householdInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16 + 64);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
    }];
    
    
    
    // 报修内容描述
    _repairContentLabel = [[UILabel alloc] init];
    _repairContentLabel.text = @"报修内容描述";
    _repairContentLabel.font = UIFont15;
    [self.view addSubview:_repairContentLabel];
    [_repairContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_householdInfoLabel.mas_bottom).offset(16);
        make.left.equalTo(_householdInfoLabel.mas_left);
        make.right.equalTo(_householdInfoLabel.mas_right);
        make.height.equalTo(_householdInfoLabel.mas_height);
    }];
    
    
    
    // 输入报修内容
    _repairContentTextView = [[YYTextView alloc] init];
    _repairContentTextView.placeholder = @"   请描述报修内容...";
    _repairContentTextView.font = UIFontSmall;
    _repairContentTextView.layer.cornerRadius = 5.0;
    _repairContentTextView.layer.borderWidth = 1.0;
    _repairContentTextView.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    [self.view addSubview:_repairContentTextView];
    [_repairContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_repairContentLabel.mas_left);
        make.top.equalTo(_repairContentLabel.mas_bottom).offset(13);
        make.right.equalTo(_repairContentLabel.mas_right);
        make.height.mas_offset(151);
    }];
    
    
    
    // 附件
    _attachmentLabel = [[UILabel alloc] init];
    _attachmentLabel.text = @"附件";
    _attachmentLabel.font = UIFont15;
    [self.view addSubview:_attachmentLabel];
    [_attachmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_householdInfoLabel.mas_left);
        make.top.equalTo(_repairContentTextView.mas_bottom).offset(16);
        make.right.equalTo(_attachmentLabel.mas_right);
        make.height.mas_offset(30);
    }];
    
    
    
    // 拍照底部的框
    _cameraAndPhotoLibraryBottomTF = [[UITextField alloc] init];
    _cameraAndPhotoLibraryBottomTF.userInteractionEnabled = NO;
    _cameraAndPhotoLibraryBottomTF.borderStyle = 3;
    _cameraAndPhotoLibraryBottomTF.backgroundColor = [UIColor whiteColor];
    _cameraAndPhotoLibraryBottomTF.layer.cornerRadius = 5.0;
    [self.view addSubview:_cameraAndPhotoLibraryBottomTF];
    [_cameraAndPhotoLibraryBottomTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_householdInfoLabel.mas_left);
        make.top.equalTo(_attachmentLabel.mas_bottom).offset(13);
        make.right.equalTo(_householdInfoLabel.mas_right);
        make.height.equalTo(_repairContentTextView.mas_height);
    }];
    
    
    
    // 报修图片的view
    _repairPictureView = [[UIView alloc] init];
    [self.view addSubview:_repairPictureView];
    
    
    
    
    
    
    // 提交
    //    _handButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    _handButton.backgroundColor = HexColor(0x04c5a1);
    //    [_handButton setTitle:@"提交" forState:(UIControlStateNormal)];
    //    _handButton.layer.cornerRadius = 48 / 2;
    //    [self.view addSubview:_handButton];
    //    [_handButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_offset(20);
    //        make.top.equalTo(_photoLibraryButton.mas_bottom).offset(37.5);
    //        make.right.mas_offset(-20);
    //        make.height.mas_offset(48);
    //    }];
    
    
    
    
    // 添加提交的点击事件
    [_handButton addTarget:self action:@selector(repairHandAction) forControlEvents:(UIControlEventTouchUpInside)];
}



- (void)repairCameraAction
{
}



- (void)repairPhoioLibraryAction
{
}



- (void)repairHandAction
{
}



- (void)dataRequest
{    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"description"] = _repairContentTextView.text;
    parameters[@"images"] = @"";
    parameters[@"userId"] = @"1";
    
    NSString *urlString = @"save/update/repair";
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ICLog_2(@"报修请求返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            ICLog_2(@"报修请求成功：");
        }
        else
        {
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ICLog_2(@"报修请求失败：%@",error);
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
