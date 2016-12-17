//
//  NoticeVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NoticeVC.h"

#import "NoticeListTableVC.h" // 公告列表

@interface NoticeVC ()

@property (nonatomic,strong) UILabel *noticeTitleLabel; // 公告标题
@property (nonatomic,strong) UILabel *noticeContentLabel; // 公告内容
@property (nonatomic,strong) UILabel *noticeTimeLabel; // 公告时间
@property (nonatomic,strong) UILabel *noticePropertyLabel; // 物业名称

@end

@implementation NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"公告";

    [self initializeComponent];

    [self rightItemNoticeList];
}

- (void)rightItemNoticeList
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"News"] style:(UIBarButtonItemStylePlain) target:self action:@selector(noticeListAction)];
}

- (void)noticeListAction
{
    NoticeListTableVC *noticeListTableVC = [[NoticeListTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    [self.navigationController pushViewController:noticeListTableVC animated:YES];
}

- (void)initializeComponent
{
    // 公告标题
    _noticeTitleLabel = [[UILabel alloc] init];
    _noticeTitleLabel.text = @"停电通知";
//    _noticeTitleLabel.text = [NSString stringWithFormat:@"%@",];
    _noticeTitleLabel.font = UIFontLarge;
    _noticeTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_noticeTitleLabel];
    [_noticeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10 + 64);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
    }];
    
    
    
    // 公告内容
    _noticeContentLabel = [[UILabel alloc] init];
    _noticeContentLabel.font = UIFontNormal;
    _noticeContentLabel.text = @"因地铁施工预计于2016年10月31日00:00-次日00:30停水，望各位业主提前做好准备工作。因地铁施工预计于2016年10月31日00:00-次日00:30停水，望各位业主提前做好准备工作。因地铁施工预计于2016年10月31日00:00-次日00:30停水，望各位业主提前做好准备工作。";
//    _noticeContentLabel.text = [NSString stringWithFormat:@"%@",];
    _noticeContentLabel.numberOfLines = 0;
    _noticeContentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_noticeContentLabel];
    CGFloat height = [UILabel getHeightByWidth:KWidth - 2 * 15 title:_noticeContentLabel.text font:_noticeContentLabel.font];
    [_noticeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.equalTo(_noticeTitleLabel.mas_bottom).offset(20);
        make.right.mas_offset(-15);
        make.height.mas_offset(height);
    }];
    
    
    
    // 公告时间
    _noticeTimeLabel = [[UILabel alloc] init];
    _noticeTimeLabel.font = UIFontSmall;
    _noticeTimeLabel.text = @"2016.12.12";
//    _noticeTimeLabel.text = [NSString stringWithFormat:@"%@",];
    _noticeTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_noticeTimeLabel];
    [_noticeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_noticeContentLabel.mas_left);
        make.top.equalTo(_noticeContentLabel.mas_bottom).offset(20);
        make.right.equalTo(_noticeContentLabel.mas_right);
        make.height.mas_offset(30);
    }];
    
    
    // 物业名称
    _noticePropertyLabel = [[UILabel alloc] init];
    _noticePropertyLabel.font = UIFontSmall;
    _noticePropertyLabel.text = @"智慧社区物业";
//    _noticePropertyLabel.text = [NSString stringWithFormat:@"%@",];
    _noticePropertyLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_noticePropertyLabel];
    [_noticePropertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_noticeTimeLabel.mas_left);
        make.top.equalTo(_noticeTimeLabel.mas_bottom);
        make.right.equalTo(_noticeTimeLabel.mas_right);
        make.height.equalTo(_noticeTimeLabel.mas_height);
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
