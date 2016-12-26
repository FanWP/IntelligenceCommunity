//
//  ShoppingCartBottomView.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ShoppingCartView.h"

#import "PopTableViewCustom.h"

#import "ProListModel.h"
#import "ShoppingCartViewCell.h"

NSString *const ShoppingCartViewCellIdentifier = @"shoppingCartViewCellIdentifier";
@implementation ShoppingCartView

-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setShoppingCartMArray:(NSMutableArray *)shoppingCartMArray{
    
    if (!_lableText) {
        _lableText = [[UILabel alloc]init];
        _lableText.frame = CGRectMake(0, CGRectGetHeight(self.tableView.frame)/2, ScreenWidth, 40);
        _lableText.textAlignment = NSTextAlignmentCenter;
        _lableText.textColor = [UIColor lightGrayColor];
        _lableText.font = [UIFont systemFontOfSize:12];
        _lableText.numberOfLines = 0;
        [_tableView addSubview:_lableText];
        
    }
    
    _shoppingCartMArray = shoppingCartMArray;
    if (_shoppingCartMArray.count == 0) {
        _lableText.text = @"当前购物车为空快去选购吧！";
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    
    if (!_tableView) {
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 200, ScreenWidth, 200) style:UITableViewStyleGrouped];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, self.bounds.size.height) style:UITableViewStyleGrouped];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"ShoppingCartCell" bundle:nil] forCellReuseIdentifier:@"ShoppingCartCell"];
        [_tableView registerClass:[ShoppingCartViewCell class] forCellReuseIdentifier:ShoppingCartViewCellIdentifier];
        [self addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _shoppingCartMArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShoppingCartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCartViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    ProListModel *model = _shoppingCartMArray[indexPath.row];
    cell.commodityNameLabel.text = model.productname;
    cell.commodityPriceLabel.text = [NSString stringWithFormat:@"￥%@/件",[model.price stringValue]];
    cell.commodityCountLabel.text = model.orderCount;
    
    return cell;
    
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *vc = [UIView new];
    vc.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 30)];
    lable.text = @"购物车";
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = [UIColor grayColor];
    lable.font = [UIFont systemFontOfSize:16];
    [vc addSubview:lable];
    return vc;
}
- (void)addShoppingCartView:(UIViewController *)vc{
    _viewController = vc;
    [vc.view addSubview:self];
}
- (void)removeSubView:(UIViewController *)vc{
    UIView * v = [vc.view viewWithTag:111];
    [v removeFromSuperview];
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FootView" object:nil];
    [self removeSubView:_viewController];
}

#pragma markl -- 加加
-(void)shoppingCartViewCell:(ShoppingCartViewCell *)shoppingCartViewCell buttonWithTag:(NSInteger)tag{
    if (tag == 1) {
        [self updateCommodityNumberWithCell:shoppingCartViewCell addOrDelete:YES];
    }else if (tag == 2){
        [self updateCommodityNumberWithCell:shoppingCartViewCell addOrDelete:NO];
    }
    
}
-(void)updateCommodityNumberWithCell:(ShoppingCartViewCell *)shoppingCartViewCell addOrDelete:(BOOL)isAdd{
    NSIndexPath *indexPath = [_tableView indexPathForCell:shoppingCartViewCell];
    int commodityNumber = [shoppingCartViewCell.commodityCountLabel.text intValue];
    if (isAdd) {
        commodityNumber++;
    }else{
        commodityNumber--;
    }
    shoppingCartViewCell.commodityCountLabel.text = [NSString stringWithFormat:@"%d",commodityNumber];
    
    //修改该商品模型的数量
    ProListModel *model = _shoppingCartMArray[indexPath.row];
    model.orderCount = [@(commodityNumber) stringValue];
    
    
    if (commodityNumber == 0) {
        
        [_shoppingCartMArray removeObject:_shoppingCartMArray[indexPath.row]];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
    }
    
    if (self.shoppingCartMArray.count == 0) {
        
        self.lableText.text = @"当前购物车为空快去选购吧！";
    }
    _block(self.shoppingCartMArray,model);
    
}

@end

