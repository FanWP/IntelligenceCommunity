//
//  DeterminePayToCommodityDetailVC.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "DeterminePayToCommodityDetailVC.h"
#import "CommodityDetailTopViewCell.h"
#import "CommodityDetailBottomViewCell.h"


NSString *const TopViewCellIdentifier = @"commodityDetailTopViewCellIdentifier";
NSString *const BottomViewCellIdentifier = @"commodityDetailBottomViewCellIdentifier";


@interface DeterminePayToCommodityDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation DeterminePayToCommodityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];
    if (_model.productname && _model.productname.length > 0) {
        
        self.navigationItem.title = _model.productname;
    }else{
        self.navigationItem.title = @"商品详情";
    }
    
    [self initializeComponent];
}
-(void)initializeComponent{
    
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CommodityDetailTopViewCell class] forCellReuseIdentifier:TopViewCellIdentifier];
    [_tableView registerClass:[CommodityDetailBottomViewCell class] forCellReuseIdentifier:BottomViewCellIdentifier];
    
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 320;
    }else if (indexPath.row == 1){
        //        NSString *string = @"玩转简书的第一步，从这个专题开始。想上首页热门榜么？好内容想被更多人看到么？来投稿吧！如果被拒也不要灰心哦～入选文章会进一个队列挨个上首页，请耐心等待。投稿必须原创。如果发现有非原创类内容投稿，经网友举报、举证，确认后视情节轻重进行处罚，严重者将列入黑名单，再不采用。为了确保用户阅读体验，对于首页文章的格式，提出以下规范：";
        if (_model.introduction && _model.introduction.length > 0) {
            
            NSString *string = _model.introduction;
            CGRect rect = [string boundingRectWithSize:CGSizeMake(ScreenWidth-60, 0) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
            
            return rect.size.height+kGetVerticalDistance(450);
        }else{
            return kGetVerticalDistance(380+44);
        }
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        CommodityDetailTopViewCell *topCell = [tableView dequeueReusableCellWithIdentifier:TopViewCellIdentifier forIndexPath:indexPath];
        if (_model) {
            //名称
            if (_model.productname && _model.productname.length) {
                
                topCell.commodityNameLabel.text = [NSString stringWithFormat:@"名称: %@",_model.productname];
            }
            //价格
            if (_model.price) {
                topCell.commodityPriceLabel.text = [NSString stringWithFormat:@"￥ %@ 元",[_model.price stringValue]];
            }
            //数量
            if (_model.orderCount && _model.orderCount.length) {
                topCell.commodityCountLabel.text = _model.orderCount;
            }
            topCell.deleteCommodityButton.hidden = YES;
            topCell.commodityCountLabel.hidden = YES;
            topCell.addCommodityButton.hidden = YES;
            topCell.bottomImageView.hidden = YES;
            
        }
        return topCell;
    }else{
        
        CommodityDetailBottomViewCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:BottomViewCellIdentifier forIndexPath:indexPath];
        //        bottomCell.commodityDetailLabel.text = @"玩转简书的第一步，从这个专题开始。想上首页热门榜么？好内容想被更多人看到么？来投稿吧！如果被拒也不要灰心哦～入选文章会进一个队列挨个上首页，请耐心等待。投稿必须原创。如果发现有非原创类内容投稿，经网友举报、举证，确认后视情节轻重进行处罚，严重者将列入黑名单，再不采用。为了确保用户阅读体验，对于首页文章的格式，提出以下规范：";
        
        if (_model.introduction && _model.introduction.length > 0) {
            
            bottomCell.commodityDetailLabel.text = _model.introduction;
        }
        return bottomCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
