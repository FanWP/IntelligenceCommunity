//
//  SignatureVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SignatureVC.h"

@interface SignatureVC ()

@end

@implementation SignatureVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initializeComponent];
    
    [self rightItemSave];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)rightItemSave
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveSignatureAction)];
}
- (void)saveSignatureAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initializeComponent
{
    _signatureTextView = [[YYPlaceholderTextView alloc] init];
    _signatureTextView.placeholder = @"   请输入签名";
    _signatureTextView.font = UIFontSmall;
    _signatureTextView.layer.borderWidth = 1.0;
    _signatureTextView.layer.cornerRadius = 5.0;
    _signatureTextView.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    [self.view addSubview:_signatureTextView];
    [_signatureTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(64 + 12);
        make.right.mas_offset(-16);
        make.height.mas_offset(120);
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
