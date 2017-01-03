//
//  HelpCenterViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/1.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "HelpCenterViewCell.h"
#import "HelpCenterModel.h"


NSString *const HelperCenterViewCellIdentifier = @"helperCenterViewCellIdentifier";

@interface HelpCenterViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray <HelpCenterModel *>*helpCenterListMArray;

@end

@implementation HelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"帮助中心";
    [self defaultViewStyle];

    
    
    if (!_helpCenterListMArray) {
        _helpCenterListMArray = [NSMutableArray new];
    }
    
    [self initializeComponent];
    
    [self dataRequest];
}
-(void)initializeComponent{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0,0, 0);
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[HelpCenterViewCell class] forCellReuseIdentifier:HelperCenterViewCellIdentifier];
}
-(void)dataRequest{
    
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary new];
    [parametersDictionary setValue:@"1" forKey:@"pageSize"];
    [parametersDictionary setValue:@"5" forKey:@"pageNum"];
    
    User *user = [User currentUser];
    [parametersDictionary setValue:user.sessionId forKey:@"sessionId"];

    [HUD showProgress:@"正在加载数据"];
    [[RequestManager manager] SessionRequestWithType:Smart_community requestWithURLString:@"find/help/center" requestType:RequestMethodPost requestParameters:parametersDictionary success:^(id  _Nullable responseObject) {
        ICLog_2(@"%@",responseObject);
        [HUD dismiss];
        for (NSDictionary *dic in responseObject[@"body"]) {
            
            HelpCenterModel *model = [[HelpCenterModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_helpCenterListMArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });

    } faile:^(NSError * _Nullable error) {
        ICLog_2(@"%@",error);
        [HUD dismiss];
    }];
    
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _helpCenterListMArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpCenterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HelperCenterViewCellIdentifier forIndexPath:indexPath];
    
    HelpCenterModel *model = _helpCenterListMArray[indexPath.row];
    if (model.question && model.question.length > 0) {
        
        cell.titleLabel.text = model.question;
    }
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = view;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
