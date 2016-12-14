//
//  SpecialOffersListModel.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SpecialOffersListModel.h"

@implementation SpecialOffersListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _specialOffersID = value;
    }
}


@end

