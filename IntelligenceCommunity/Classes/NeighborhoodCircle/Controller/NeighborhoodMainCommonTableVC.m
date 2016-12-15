//
//  NeighborhoodMainCommonTableVC.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/15.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodMainCommonTableVC.h"
#import "NeighborhoodCircleCell.h"



NSString *const NeighborhoodCircleCellID = @"neighborhoodCircleCellIdentifier";


@interface NeighborhoodMainCommonTableVC ()<NeighborhoodCircleCellDelegate>

@end

@implementation NeighborhoodMainCommonTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[NeighborhoodCircleCell class] forCellReuseIdentifier:NeighborhoodCircleCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)neighborhoodCircleCell:(NeighborhoodCircleCell *)neighborhoodCircleCell clickButtonWithTag:(NSInteger)tag{
    if (tag == 1) {
        NSLog(@"点击了对话按钮");
    }else if (tag == 2){
        NSLog(@"点击了点赞按钮");
        neighborhoodCircleCell.thumbUpButton.selected = !neighborhoodCircleCell.thumbUpButton.selected;
        if (neighborhoodCircleCell.thumbUpButton.selected) {
        }else{
        }
    }else if (tag == 3){
        NSLog(@"点击了评论按钮");
    }
    NSIndexPath *indexPath = [self.tableView indexPathForCell:neighborhoodCircleCell];
    NSLog(@"indexPath.row===%ld",indexPath.row);
}

#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 260;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NeighborhoodCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:NeighborhoodCircleCellID  forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row == 0) {
        cell.userNameLabel.text = @"咖啡小猫";
    }else{
        cell.userNameLabel.text = @"咖啡大猫";
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ICLog_2(@"%ld",indexPath.row);
}


@end
