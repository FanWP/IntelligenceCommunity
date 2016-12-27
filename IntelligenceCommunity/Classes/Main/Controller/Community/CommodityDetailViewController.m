//
//  CommodityDetailViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "CommodityDetailTopViewCell.h"
#import "CommodityDetailBottomViewCell.h"

#import "ProListModel.h"
#import "PopTableViewCustom.h"      //双表
#import "ShoppingCartBottomView.h"  //购物车按钮、总价栏
#import "ShoppingCartView.h"        //购物车列表
#import "ShoppingCartModel.h"       //购物车数据模型
#import "DeterminePayViewController.h"  //支付界面

NSString *const CommodityDetailTopViewCellIdentifier = @"commodityDetailTopViewCellIdentifier";
NSString *const CommodityDetailBottomViewCellIdentifier = @"commodityDetailBottomViewCellIdentifier";

//CommodityDetailTopViewCellDelegate  对当前商品的添加/减少操作
//CAAnimationDelegate  动画
@interface CommodityDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CommodityDetailTopViewCellDelegate,CAAnimationDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation CommodityDetailViewController
{
    CALayer *_layer;
    NSInteger _currentSelectIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商品详情";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = HexColor(0xeeeeee);
    
    
    
    [self initializeComponent];
    
    //更新购物车的相关信息
    [self updateShoppingCartWithMArray:self.popTableView.orderMArray model:nil];
}
-(void)initializeComponent{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CommodityDetailTopViewCell class] forCellReuseIdentifier:CommodityDetailTopViewCellIdentifier];
    [_tableView registerClass:[CommodityDetailBottomViewCell class] forCellReuseIdentifier:CommodityDetailBottomViewCellIdentifier];
    
    //底部菜单
    _shoppingCartBottomView = [[ShoppingCartBottomView alloc] initWithFrame:CGRectMake(0,ScreenHeight-64-50, ScreenWidth, 50)];
    //购物车列表
    [_shoppingCartBottomView.shoppingCartButton addTarget:self action:@selector(showshoppingCartlist:) forControlEvents:UIControlEventTouchUpInside];
    //去结算
    [_shoppingCartBottomView.goSettlementButton addTarget:self action:@selector(goSettlementButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shoppingCartBottomView];
    
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
        _redView.layer.masksToBounds = YES;
    }
}
#pragma mark -- 购物车按钮
- (void)showshoppingCartlist:(UIButton *)button{
    
    __weak typeof(self) weakSelf = self;
    button.selected = !button.selected;
    if (button.selected) {
        self.shoppingCartView =[[ShoppingCartView alloc]init];
        self.shoppingCartView.frame =CGRectMake(0, (ScreenHeight-50), ScreenWidth,ScreenWidth);
        
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,self.view.bounds.size.height-CGRectGetHeight(self.shoppingCartBottomView.frame))];
        bgView.alpha = .7;
        bgView.tag = 111;
        bgView.backgroundColor =[UIColor lightGrayColor];
        [self.view addSubview:bgView];
        self.shoppingCartView.block = ^(NSMutableArray *darasArr,ProListModel *model){
            
            [weakSelf updateShoppingCartWithMArray:darasArr model:model];
        };
        
        [self.shoppingCartView addShoppingCartView:self];
        [UIView animateWithDuration:.3 animations:^{
            
            self.shoppingCartView.frame =CGRectMake(0, (ScreenHeight-CGRectGetHeight(self.shoppingCartBottomView.frame)-ScreenWidth), ScreenWidth,ScreenWidth);
            self.shoppingCartView.shoppingCartMArray = self.popTableView.orderMArray;
        } completion:^(BOOL finished){
            
            
        }];
        
    }else{
        [self.shoppingCartView removeSubView:self];
    }
    
}
#pragma mark -- 更新 数量 价钱
- (void)updateShoppingCartWithMArray:(NSMutableArray *)darasArr model:(ProListModel *)model{
    
    __weak typeof(self) weakSelf = self;
    ICLog_2(@"%ld-%ld",model.indexPath.section,model.indexPath.row);
    //数量
    weakSelf.shoppingCartBottomView.commodityCountLabel.text  = [NSString stringWithFormat:@"%ld",(long)[ShoppingCartModel getShoppingCartCommodityCount:darasArr]];
    //总价
    weakSelf.shoppingCartBottomView.commodityTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[ShoppingCartModel getShoppingCartCommodityTotalPrice:darasArr]];
    
    if (model) {
        
        [weakSelf.popTableView.rightTableView reloadRowsAtIndexPaths:@[model.indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
//    [weakSelf.popTableView.rightTableView reloadData];
}
-(void)goSettlementButtonAction:(UIButton *)button{
    
    ICLog_2(@"去结算");
    DeterminePayViewController *VC = [[DeterminePayViewController alloc] init];
    VC.orderMArray = self.popTableView.orderMArray;
    [self.navigationController pushViewController:VC animated:YES];
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
        return kGetHorizontalDistance(424);
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
        
        CommodityDetailTopViewCell *topCell = [tableView dequeueReusableCellWithIdentifier:CommodityDetailTopViewCellIdentifier forIndexPath:indexPath];
        topCell.delegate = self;
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
        }
        return topCell;
    }else{
        
        CommodityDetailBottomViewCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:CommodityDetailBottomViewCellIdentifier forIndexPath:indexPath];
        
        if (_model.introduction && _model.introduction.length > 0) {
            
            bottomCell.commodityDetailLabel.text = _model.introduction;
        }
//        bottomCell.commodityDetailLabel.text = @"玩转简书的第一步，从这个专题开始。想上首页热门榜么？好内容想被更多人看到么？来投稿吧！如果被拒也不要灰心哦～入选文章会进一个队列挨个上首页，请耐心等待。投稿必须原创。如果发现有非原创类内容投稿，经网友举报、举证，确认后视情节轻重进行处罚，严重者将列入黑名单，再不采用。为了确保用户阅读体验，对于首页文章的格式，提出以下规范：";
        return bottomCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark--更新当前商品数量、数据源、购物车信息
-(void)commodityDetailTopViewCell:(CommodityDetailTopViewCell *)cell buttonWithTag:(NSInteger)tag{
    if (tag == 1) {
        ICLog_2(@"增加");
        
        //1、更新购物车
        if (_popTableView.orderMArray.count != 0) {
            BOOL flage = YES;
            for (ProListModel *tempModel in _popTableView.orderMArray) {
                if (tempModel.commodityID == _model.commodityID) {
                    flage = NO;         //说明该商品在购物车中已经存在
                    break;
                }
            }
            if (flage) {                //如果不存在，则添加
                [_popTableView.orderMArray addObject:_model];
            }
        }else{
            [_popTableView.orderMArray addObject:_model];
        }
        
        //2、更新该商品的数据源
        int commodityNumber = [_model.orderCount intValue];
        commodityNumber++;
        cell.commodityCountLabel.text = [NSString stringWithFormat:@"%d",commodityNumber];
        ProListModel *model = _popTableView.leftMArray[_model.indexPath.section][_model.indexPath.row];
        model.orderCount =[@(commodityNumber) stringValue];
        
        //3、更新当前商品数量
        if ([model isEqual:_model]) {
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        
    }else if (tag == 2){
        ICLog_2(@"减少");
        //1、更新该商品的数据源
        int commodityNumber = [_model.orderCount intValue];
        if (commodityNumber == 0) {
            return;
        }else{
            commodityNumber--;
        }
            //更新UI
        cell.commodityCountLabel.text = [NSString stringWithFormat:@"%d",commodityNumber];
            //更新数据源
        ProListModel *model = _popTableView.leftMArray[_model.indexPath.section][_model.indexPath.row];
        model.orderCount =[@(commodityNumber) stringValue];
        
        
        //2、更新购物车
        if (self.popTableView.orderMArray.count) {
            BOOL flage = YES;
            for (ProListModel *tempModel in _popTableView.orderMArray) {
                if (tempModel.commodityID == _model.commodityID) {
                    if ([_model.orderCount intValue] == 0) {
                        flage = NO;
                    }
                    break;
                }
            }
            //如果该商品的数量为0的时候，从购物车删除
            if (!flage) {
                [_popTableView.orderMArray removeObject:_model];
            }
        }
        
        //3、更新当前商品数量
        if ([model isEqual:_model]) {
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    
   
#pragma mark--动画
    CGRect parentRect = [cell convertRect:cell.commodityCountLabel.frame toView:self.view];
    
    [self startAnimationWithRect:parentRect ImageView:_redView];
}
#pragma mark--动画

-(void)startAnimationWithRect:(CGRect)rect ImageView:(UIImageView *)imageView
{
    if (!_layer) {
        //        _btn.enabled = NO;
        _layer = [CALayer layer];
        _layer.contents = (id)imageView.layer.contents;
        
        _layer.contentsGravity = kCAGravityResizeAspectFill;
        _layer.bounds = rect;
        //        [_layer setCornerRadius:CGRectGetHeight([_layer bounds]) / 2];
        _layer.masksToBounds = YES;
        // 导航64
        _layer.position = CGPointMake(rect.origin.x, CGRectGetMidY(rect));
        //        [_tableView.layer addSublayer:_layer];
        [self.view.layer addSublayer:_layer];
        
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:_layer.position];
        //        (SCREEN_WIDTH - 60), 0, -50, 50)
        [path addQuadCurveToPoint:CGPointMake(50, ScreenHeight - 40) controlPoint:CGPointMake(ScreenWidth/4,rect.origin.y-80)];
        //        [_path addLineToPoint:CGPointMake(SCREEN_WIDTH-40, 30)];
        [self groupAnimation:(path)];
    }
}
-(void)groupAnimation:(UIBezierPath*)path{
    _tableView.userInteractionEnabled = NO;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.1f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:1.3f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.1;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.3f];
    narrowAnimation.duration = 0.4f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.3f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (anim == [_layer animationForKey:@"group"]) {
        _tableView.userInteractionEnabled = YES;
        //        _btn.enabled = YES;
        [_layer removeFromSuperlayer];
        _layer = nil;
        _currentSelectIndex++;
        if (_currentSelectIndex) {
            self.shoppingCartBottomView.commodityCountLabel.hidden = NO;
        }
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
        
#pragma mark--更新底部购物车栏的商品数量、价格
        self.shoppingCartBottomView.commodityCountLabel.text = [NSString stringWithFormat:@"%ld",[ShoppingCartModel getShoppingCartCommodityCount:_popTableView.orderMArray]];
        self.shoppingCartBottomView.commodityTotalPriceLabel.text = [NSString stringWithFormat:@"%.2f",[ShoppingCartModel getShoppingCartCommodityTotalPrice:_popTableView.orderMArray]];
 
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [self.shoppingCartBottomView.commodityCountLabel.layer addAnimation:shakeAnimation forKey:nil];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
