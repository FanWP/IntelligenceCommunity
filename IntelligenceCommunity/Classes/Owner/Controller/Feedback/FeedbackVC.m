//
//  FeedbackVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()

@property (nonatomic,strong) YYPlaceholderTextView *feedbackContentTextView;// 输入意见内容
@property (nonatomic,strong) UIButton *handFeedbackButton;// 提交意见

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"意见反馈";
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initializeComponent];
}

- (void)dataHandFeedback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = UserID;
    parameters[@"receive"] = _feedbackContentTextView.text;
    parameters[@"sessionId"] = SessionID;
    
    ICLog_2(@"提交意见参数：%@",parameters);
    
    NSString *url = [NSString stringWithFormat:@"%@smart_community/save/update/suggestion",Smart_community_URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"提交意见返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            _feedbackContentTextView.text = @"";
            
            [HUD showSuccessMessage:@"提交成功"];
        }
        else
        {
            [HUD showErrorMessage:@"提交失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [HUD showErrorMessage:@"提交失败"];
        
        ICLog_2(@"提交意见错误：%@",error);
    }];
}

- (void)initializeComponent
{
    // 输入意见内容
    _feedbackContentTextView = [[YYPlaceholderTextView alloc] init];
    _feedbackContentTextView.placeholder = @"  请输入要反馈的意见内容...";
    _feedbackContentTextView.font = UIFontSmall;
    _feedbackContentTextView.layer.cornerRadius = 5.0;
    _feedbackContentTextView.layer.borderWidth = 1.0;
    _feedbackContentTextView.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    [self.view addSubview:_feedbackContentTextView];
    [_feedbackContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(64 + 10);
        make.right.mas_offset(-15);
        make.height.mas_offset(150);
    }];
    
    
    // 提交意见
    _handFeedbackButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _handFeedbackButton.backgroundColor = HexColor(0x04c5a1);
    [_handFeedbackButton setTitle:@"提交意见" forState:(UIControlStateNormal)];
    _handFeedbackButton.layer.cornerRadius = 5.0;
    [self.view addSubview:_handFeedbackButton];
    [_handFeedbackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.equalTo(_feedbackContentTextView.mas_bottom).offset(20);
        make.right.mas_offset(-20);
        make.height.mas_offset(44);
    }];
    
    
    // 添加提交意见的点击事件
    [_handFeedbackButton addTarget:self action:@selector(handFeedbackAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)handFeedbackAction
{
    [self dataHandFeedback];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
