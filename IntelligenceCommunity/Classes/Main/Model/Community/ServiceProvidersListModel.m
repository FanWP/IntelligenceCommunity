//
//  ServiceProvidersListModel.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "ServiceProvidersListModel.h"

@implementation ServiceProvidersListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        self.serviceProviderDescription = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.serviceProviderID = value;
    }
}
@end
