//
//  PropertyFeeBillingVC.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyFeeBillingVC : UIViewController

@property(nonatomic,strong) NSNumber *paymentId;//支付记录ID，查看详情用

@property(nonatomic,assign) FeeType feetype;  //费用类型

@end
