//
//  HouseListTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "HouseListTableVC.h"

#import "HouseListCell.h"

@interface HouseListTableVC ()

@end

@implementation HouseListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    HouseListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[HouseListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    cell.houseNumberLabel.text = @"1栋1单元1202";
    cell.identifierLabel.text = @"业主";

    return cell;
}




@end
