//
//  FeedbackVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()

@property (nonatomic,strong) UILabel *suggestionDescribeLabel;// 意见描述
@property (nonatomic,strong) YYPlaceholderTextView *feedbackContentTextView;// 输入意见内容
@property (nonatomic,strong) UIButton *handFeedbackButton;// 提交意见

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"意见反馈";

    [self initializeComponent];
}

- (void)initializeComponent
{
    // 意见描述
    _suggestionDescribeLabel = [[UILabel alloc] init];
    _suggestionDescribeLabel.font = UIFontNormal;
    _suggestionDescribeLabel.text = @"意见描述";
    [self.view addSubview:_suggestionDescribeLabel];
    [_suggestionDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10 + 64);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
    }];
    
    
    // 输入意见内容
    _feedbackContentTextView = [[YYPlaceholderTextView alloc] init];
    _feedbackContentTextView.placeholder = @"  请输入要反馈的意见内容...";
    _feedbackContentTextView.font = UIFontSmall;
    _feedbackContentTextView.layer.cornerRadius = 5.0;
    _feedbackContentTextView.layer.borderWidth = 1.0;
    _feedbackContentTextView.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    [self.view addSubview:_feedbackContentTextView];
    [_feedbackContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_suggestionDescribeLabel.mas_left);
        make.top.equalTo(_suggestionDescribeLabel.mas_bottom).offset(10);
        make.right.equalTo(_suggestionDescribeLabel.mas_right);
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
