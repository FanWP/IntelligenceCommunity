//
//  RepairsViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RepairsViewController.h"

@interface RepairsViewController ()

@property (nonatomic,strong) UILabel *householdInfoLabel;// 住户信息
@property (nonatomic,strong) UILabel *repairContentLabel;// 报修内容描述
@property (nonatomic,strong) YYTextView *repairContentTextView;// 输入报修内容
@property (nonatomic,strong) UILabel *attachmentLabel;// 附件
@property (nonatomic,strong) UIButton *cameraButton;// 拍照
@property (nonatomic,strong) UIButton *photoLibraryButton;// 从本地相册选择文件
@property (nonatomic,strong) UIButton *handButton;// 提交

@end

@implementation RepairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];

    self.navigationItem.title = @"报修";
    
    [self dataRequest];// 报修数据
    
}



- (void)initializeComponent
{
    
    
    _householdInfoLabel = [[UILabel alloc] init];
//    _householdInfoLabel.text = [NSString stringWithFormat:@"住户信息：%@",];
    _householdInfoLabel.text = @"住户信息：龙湖水晶郦城1号楼2011室";
    _householdInfoLabel.font = UIFont15;
    
}



- (void)dataRequest
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"description"] = @"水管坏了";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
