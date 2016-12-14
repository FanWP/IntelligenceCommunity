//
//  ServiceProvidersListViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <UIKit/UIKit.h>


//商品、便民、美食、娱乐具体模块的服务商列表
@interface ServiceProvidersListViewController : UIViewController

//商品-commodity  方便--convenient  美食--delicacy  娱乐--entertainment
//@property(nonatomic,assign) CommunityServiceType communityServiceType;

//服务类型ID:用于请求商家列表时候的参数
@property(nonatomic,strong) NSNumber *serviceTypeID;


@end
