//
//  DropDownView.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "DropDownView.h"

@interface DropDownView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation DropDownView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

@end
