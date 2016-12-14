//
//  PopTableViewCustom.m
//  DoubleTableView
//
//  Created by apple on 16/12/3.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "PopTableViewCustom.h"
#import "ShoppingCartModel.h"

#import "CommodityListViewController.h"
#import "ShoppingCartBottomView.h"  

//双表M、V
#import "ProListModel.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"

NSString *const LeftTableViewCellIdentifier = @"leftTableViewCellIdentifier";
NSString *const RightTableViewCellIdentifier = @"rightTableViewCellIdentifier";

//CAAnimationDelegate          动画
//RightTableViewCellDelegate   添加商品/减少商品按钮状态
@interface PopTableViewCustom ()<UIGestureRecognizerDelegate,UIScrollViewDelegate,CAAnimationDelegate,RightTableViewCellDelegate>


@end

@implementation PopTableViewCustom
{
    CALayer *_layer;
    NSInteger _currentSelectIndex;
}
-(id)initWithFrame:(CGRect)frame leftArray:(NSArray *)leftArray rightArray:(NSArray *)rightArray{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    [self leftTableViewInit];
    [self rightTableViewInit];
    
    if (!_orderMArray) {
        _orderMArray = [NSMutableArray new];
    }
}
#pragma mark--tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == _rightTableView) {
        return _leftMArray.count;
    }else{
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _leftTableView) {     //左边
        
        return _leftMArray.count;
    }else{
        return [_leftMArray[section] count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _leftTableView) {      //左边
        
        
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftTableViewCellIdentifier forIndexPath:indexPath];
        ProListModel *model = [_leftMArray[indexPath.row] firstObject];
        cell.titleLabel.text = model.productTypeName;
        return cell;
    }else{                                  //右边
        
        RightTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:RightTableViewCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        
        ProListModel *model = _leftMArray[indexPath.section][indexPath.row];
        model.indexPath = indexPath;
        cell.commodityNameLabel.text = model.productname;   //商品名字
        cell.commodityPriceLabel.text = [NSString stringWithFormat:@"￥%@元/件",[model.price stringValue]];
        cell.commodityCountLabel.text = model.orderCount;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == _leftTableView) {
        
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        _selectIndex = indexPath.row;
    }else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectTableView:indexPath:)]) {
            [_delegate didSelectTableView:tableView indexPath:indexPath];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == _rightTableView) {
        return 10.0f;
    }else{
        return .1f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _rightTableView) {
        return 140.f;
    }
    return 50;
}
#pragma mark--scrollViewDelegate 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_leftTableView.tracking) {
        
    }else if (_rightTableView.tracking){
        
        NSIndexPath *indexPath = [_rightTableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
        if (indexPath) {
            
            //同步左边目录
            [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            _selectIndex = indexPath.section;
            
        }
        
    }
}
#pragma mark--加减按钮
-(void)tableViewCell:(RightTableViewCell *)rightTableViewCell buttonWithTag:(NSInteger)tag{
    
    NSIndexPath *indexPath = [_rightTableView indexPathForCell:rightTableViewCell];
    if (tag == 1) {        //添加
        NSLog(@"添加");
        
        int commodityNumber = [rightTableViewCell.commodityCountLabel.text intValue];
        commodityNumber++;
        
        //更新购物车数据
        [self updateShoppingCart:indexPath];
        
        //更新商品数量
        [self setNumber:commodityNumber tableViewCell:rightTableViewCell];
        
    }else if (tag == 2){    //删除
        NSLog(@"删除");
        int commodityNumber = [rightTableViewCell.commodityCountLabel.text intValue];
        if (commodityNumber == 0) {
            return;
        }else{
            commodityNumber--;
        }
        
        //更新商品数量
        [self setNumber:commodityNumber tableViewCell:rightTableViewCell];
        
        //更新购物车
        [self deleteShoppingCart:indexPath];
        
    }
}
-(void)setNumber:(int)number tableViewCell:(RightTableViewCell *)rightTableViewCell{
    
    rightTableViewCell.commodityCountLabel.text = [NSString stringWithFormat:@"%d",number];
    
    NSIndexPath *indexPath = [_rightTableView indexPathForCell:rightTableViewCell];
    
    //修改该商品模型的数量
    ProListModel *model = _leftMArray[indexPath.section][indexPath.row];
    model.orderCount = [@(number) stringValue];
    
    
    CGRect parentRectA = [rightTableViewCell convertRect:rightTableViewCell.commodityCountLabel.frame toView:_ViewController.view];
    
    [self startAnimationWithRect:parentRectA ImageView:self.redView];
}

-(void)updateShoppingCart:(NSIndexPath *)indexPath{
    
    ProListModel *model = self.leftMArray[indexPath.section][indexPath.row];
    
    if (self.orderMArray.count != 0){
        BOOL flage = YES;           //用于判断当前添加的 数据  是否在购物车中
        for (ProListModel *tempModel in self.orderMArray){
            if (tempModel.commodityID == model.commodityID){
                flage = NO;         //说明该商品在购物车中已经存在
                break;
            }
        }
        if (flage){                 //如果不存在，则添加
            
            [self.orderMArray addObject:model];
        }   //遍历购物车
    }else{
        
        [self.orderMArray addObject:model];
        
    }
    
    NSLog(@"---%lu",(unsigned long)self.orderMArray.count);
}
-(void)deleteShoppingCart:(NSIndexPath *)indexPath{
    
    ProListModel *model = self.leftMArray[indexPath.section][indexPath.row];
    
    if (self.orderMArray.count) {
        BOOL flage = YES;
        for (ProListModel *tempModel in _orderMArray) {
            if (tempModel.commodityID == model.commodityID) {
                if ([model.orderCount intValue] == 0) {
                    flage = NO;
                }
                break;
            }
        }
        //如果该商品的数量为0的时候，从购物车删除
        if (!flage) {
            [_orderMArray removeObject:model];
        }
    }
    
}
#pragma mark--左边目录
-(void)leftTableViewInit{
    
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/4,0) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        _leftTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:LeftTableViewCellIdentifier];
        [self addSubview:_leftTableView];
    }
}
//数据源
-(void)setLeftMArray:(NSMutableArray *)leftMArray{
    
    _leftMArray = leftMArray;
    
    [_leftTableView reloadData];
    [_rightTableView reloadData];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    _leftTableView.frame = CGRectMake(0, 0, self.frame.size.width/4,self.bounds.size.height);
    _rightTableView.frame = CGRectMake(CGRectGetMaxX(_leftTableView.frame), CGRectGetMinY(_leftTableView.frame),ScreenWidth - CGRectGetWidth(_leftTableView.frame),self.bounds.size.height);
}
#pragma mark--右边目录
-(void)rightTableViewInit{
        
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftTableView.frame), 0, ScreenWidth-CGRectGetWidth(_leftTableView.frame), 0) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.showsHorizontalScrollIndicator = NO;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_rightTableView];
        
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:RightTableViewCellIdentifier];
        
    }
}
-(UIImageView *)redView{
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
        _redView.layer.masksToBounds = YES;
    }
    return _redView;
}
-(void)setViewController:(UIViewController *)ViewController{
    
    _ViewController = ViewController;
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
        _layer.position = CGPointMake(rect.origin.x, CGRectGetMidY(rect)-64-80);
        //        [_tableView.layer addSublayer:_layer];
        [self.layer addSublayer:_layer];
        
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:_layer.position];
        //        (SCREEN_WIDTH - 60), 0, -50, 50)
        //toPoint:落点        //controlPoint:控制点
        [path addQuadCurveToPoint:CGPointMake(38, ScreenHeight - 40) controlPoint:CGPointMake(ScreenWidth/4,rect.origin.y-80)];
        //        [_path addLineToPoint:CGPointMake(SCREEN_WIDTH-40, 30)];
        [self groupAnimation:(path)];
    }
}
-(void)groupAnimation:(UIBezierPath*)path{
    _rightTableView.userInteractionEnabled = NO;
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
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (anim == [_layer animationForKey:@"group"]) {
        _rightTableView.userInteractionEnabled = YES;
        //        _btn.enabled = YES;
        [_layer removeFromSuperlayer];
        _layer = nil;
        _currentSelectIndex++;
        CommodityListViewController *VC=(CommodityListViewController *) _ViewController;
        if (_currentSelectIndex) {
            VC.shoppingCartBottomView.commodityCountLabel.hidden = NO;
        }
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
        
        //设置商品数量
        VC.shoppingCartBottomView.commodityCountLabel.text = [NSString stringWithFormat:@"%ld",(long)[ShoppingCartModel getShoppingCartCommodityCount:self.orderMArray]];
        [VC.shoppingCartBottomView setCommodityCountLabel:VC.shoppingCartBottomView.commodityCountLabel];
        [VC.shoppingCartBottomView.layer addAnimation:animation forKey:nil];
        
        
        //设置商品价格
        VC.shoppingCartBottomView.commodityTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[ShoppingCartModel getShoppingCartCommodityTotalPrice:self.orderMArray]];
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [VC.shoppingCartBottomView.shoppingCartButton.layer addAnimation:shakeAnimation forKey:nil];
    }
}


@end
