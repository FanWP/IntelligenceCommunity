//
//  FreeArticleHeaderView.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleHeaderView.h"

#import "SmartCommunityPhotosView.h"

#import "FreeArticleDetailTableVC.h"

#import <AFNetworking.h>

#import "FreeArticleModel.h"


@interface FreeArticleHeaderView ()


//用户头像
@property(nonatomic,strong) UIImageView *userImageView;
//用户名
@property(nonatomic,strong) UILabel *userNameLabel;
//发布时间
@property(nonatomic,strong) UILabel *uploadTimeLabel;
//是否支持物物交换
@property(nonatomic,assign) BOOL isSupportBarter;

@property(nonatomic,strong) UILabel *isSupportBarterLabel;

//图片
@property(nonatomic,strong) UIImageView *communityImageView;

//价格
@property(nonatomic,strong) UILabel *priceLabel;
//原价
@property(nonatomic,strong) UILabel *oldPriceLabel;
//点赞、数量
@property(nonatomic,strong) UIButton *thumbUpButton;
@property(nonatomic,strong) UILabel *thumbUpCountLabel;
//评论、数量

@property(nonatomic,strong) UILabel *commentCountLabel;

//物品信息
@property(nonatomic,strong) UILabel *communityContentLabel;

/** 已售 */
@property (nonatomic,weak) UIImageView *alreadySell;

@end
@implementation FreeArticleHeaderView


-(instancetype)initWithFrame:(CGRect)frame
{

    if ([super initWithFrame:frame]) {
        
        //用户头像
        //    @property(nonatomic,strong) UIImageView *userImageView;
        _userImageView = [[UIImageView alloc] init];
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
        [self addSubview:_userImageView];
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.left.mas_offset(10);
            make.width.height.mas_offset(45);
        }];
        //    //用户名
        //    @property(nonatomic,strong) UILabel *userNameLabel;
        _userNameLabel = [[UILabel alloc] init];
//        _userNameLabel.text = @"咖啡小猫";
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = UIFontLarge;
        [self addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userImageView).offset(0);
            make.left.equalTo(_userImageView.mas_right).offset(10);
            make.width.mas_offset(80);
            make.height.mas_offset(20);
        }];
        //    //发布时间
        //    @property(nonatomic,strong) UILabel *uploadTimeLabel;
        _uploadTimeLabel = [[UILabel alloc] init];
//        _uploadTimeLabel.text = @"1分钟前";
        _uploadTimeLabel.textColor = [UIColor grayColor];
        _uploadTimeLabel.textAlignment = NSTextAlignmentLeft;
        _uploadTimeLabel.font = UIFontNormal;
        [self addSubview:_uploadTimeLabel];
        [_uploadTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userNameLabel).offset(0);
            make.bottom.equalTo(_userImageView.mas_bottom).offset(0);
            make.width.mas_offset(180);
            make.height.mas_offset(20);
        }];
        //    //是否支持物物交换
        //    @property(nonatomic,assign) BOOL isSupportBarter;
        //    @property(nonatomic,strong) UIImageView *isSupportBarterImageView;
        //    @property(nonatomic,strong) UILabel *isSupportBarterLabel;
        _isSupportBarterLabel = [[UILabel alloc] init];
        _isSupportBarterLabel.text = @"支持物物交换";
        _isSupportBarterLabel.textColor = MJRefreshColor(239, 143, 88);
        _isSupportBarterLabel.textAlignment = NSTextAlignmentRight;
        _isSupportBarterLabel.font = UIFont13;
        [self addSubview:_isSupportBarterLabel];
        [_isSupportBarterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_userImageView.mas_centerY);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
        
        
        //    //图片
//        
//        _communityImageView = [[SmartCommunityPhotosView alloc] initWithFrame:CGRectMake(10, 65, 80, 80)];
//        [self addSubview:_communityImageView];
        
        //    @property(nonatomic,strong) UIImageView *communityImageView;
        _communityImageView = [[UIImageView alloc] init];
        _communityImageView.contentMode = UIViewContentModeScaleAspectFill;
        _communityImageView.image = [UIImage imageNamed:@"3.jpg"];
        _communityImageView.clipsToBounds = YES;
        [self addSubview:_communityImageView];
        [_communityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userImageView.mas_bottom).offset(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(202);
        }];
        
        
        //已售
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"halt sales"]];
        img.mj_x = KWidth - 10 - img.width;
        img.mj_y = 60;
        self.alreadySell = img;
        [self addSubview:img];
#warning 原价、点赞、评论系列控件以[价格]的中心线为基准对齐
        //    //价格
        //    @property(nonatomic,strong) UILabel *priceLabel;
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"￥210元";
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = UIFontLargest;
        [self addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_communityImageView.mas_bottom).offset(5);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        //    //原价
        //    @property(nonatomic,strong) UILabel *oldPriceLabel;
        _oldPriceLabel = [[UILabel alloc] init];
        _oldPriceLabel.text = @"原价￥300元";
        _oldPriceLabel.textColor = [UIColor grayColor];
        _oldPriceLabel.textAlignment = NSTextAlignmentCenter;
        _oldPriceLabel.font = UIFontNormal;
        [self addSubview:_oldPriceLabel];
        [_oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_priceLabel.mas_centerY);
            make.left.equalTo(_priceLabel.mas_right).offset(5);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor grayColor];
        [_oldPriceLabel addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_oldPriceLabel.mas_centerY);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
#warning 评论按钮、数量、点赞按钮的大小以点赞数量控件为基准动态改变
        //    //评论按钮、评论数量
        //    @property(nonatomic,strong) UIButton *commentsButton;
        //    @property(nonatomic,strong) UILabel *commentCountLabel;
        _communityContentLabel = [[UILabel alloc] init];
        _communityContentLabel.text = @"108";
        _communityContentLabel.textColor = [UIColor grayColor];
        _communityContentLabel.textAlignment = NSTextAlignmentCenter;
        _communityContentLabel.font = UIFontSmallest;
        [self addSubview:_communityContentLabel];
        [_communityContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_priceLabel.mas_centerY);
            make.right.mas_equalTo(-20);
            make.width.height.mas_equalTo(30);
        }];
        
        
        _commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentsButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_commentsButton addTarget:self action:@selector(commentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commentsButton];
        [_commentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_oldPriceLabel.mas_centerY);
            make.right.equalTo(_communityContentLabel.mas_left).offset(-2);
            make.width.height.mas_equalTo(_communityContentLabel);
        }];
        
        
        //点赞、数量
        //    @property(nonatomic,strong) UIButton *thumbUpButton;
        //    @property(nonatomic,strong) UILabel *thumbUpCountLabel;
        _thumbUpCountLabel = [[UILabel alloc] init];
        _thumbUpCountLabel.text = @"88";
        _thumbUpCountLabel.textColor = [UIColor grayColor];
        _thumbUpCountLabel.textAlignment = NSTextAlignmentCenter;
        _thumbUpCountLabel.font = UIFontSmallest;
        [self addSubview:_thumbUpCountLabel];
        [_thumbUpCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_priceLabel.mas_centerY);
            make.right.equalTo(_commentsButton.mas_left).offset(-5);
            make.width.height.mas_equalTo(_communityContentLabel);
        }];
        
        
        _thumbUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thumbUpButton setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
        [_thumbUpButton setImage:[UIImage imageNamed:@"praise2"] forState:UIControlStateSelected];
        [_thumbUpButton addTarget:self action:@selector(thumbUpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_thumbUpButton];
        
        [_thumbUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_priceLabel.mas_centerY);
            make.right.equalTo(_thumbUpCountLabel.mas_left).offset(-2);
            make.width.height.mas_equalTo(_communityContentLabel);
        }];
        //    //物品信息
        //    @property(nonatomic,strong) UILabel *communityContentLabel;
        _communityContentLabel = [[UILabel alloc] init];
        _communityContentLabel.text = @"八成新的自行车准备转手-八成新的自行车准备转手-八成新的自行车准备转手";
        _communityContentLabel.textColor = [UIColor grayColor];
        _communityContentLabel.numberOfLines = 0;
        _communityContentLabel.textAlignment = NSTextAlignmentLeft;
        _communityContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _communityContentLabel.font = UIFont15;
        
    
        

        
        [self addSubview:_communityContentLabel];
        [_communityContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        //给详情添加手势
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLableTap)];
        _communityContentLabel.userInteractionEnabled = YES;
        [self.communityContentLabel addGestureRecognizer:tap];
        

    }

    return self;
}



//设置数据
-(void)setFreeArticleModel:(FreeArticleModel *)freeArticleModel
{
    _freeArticleModel = freeArticleModel;
    
    [self.userImageView load:freeArticleModel.images placeholderImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    self.userNameLabel.text = freeArticleModel.nickname;
    self.uploadTimeLabel.text = freeArticleModel.createTime;
    
    //是否支持交换
    if (freeArticleModel.change == 1) {
        self.isSupportBarterLabel.hidden = NO;
    }else
    {
        self.isSupportBarterLabel.hidden = YES;
    }
    
    //判断是否是已经停售
    if (freeArticleModel.saleStatus == 1) {
        self.alreadySell.hidden = NO;
    }else
    {
        self.alreadySell.hidden = YES;
    }

    
    self.communityContentLabel.text = freeArticleModel.content;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",freeArticleModel.price];
    self.oldPriceLabel.text = [NSString stringWithFormat:@"原价%@",freeArticleModel.srcPrice];
    
    //设置点赞数据
    self.thumbUpCountLabel.text = [NSString stringWithFormat:@"%ld",(long)freeArticleModel.number];
    
    NSString *str = [NSString stringWithFormat:@",%@,",UserID];
    
    //判断当前用户是否点赞
    if ([self.freeArticleModel.likeUserid rangeOfString:str].location != NSNotFound) {
        
        self.thumbUpButton.selected = YES;
    }else
    {
        self.thumbUpButton.selected = NO;
    }
    
    self.commentCountLabel.text = @"43r";

    NSString *strurl = [NSString stringWithFormat:@"%@%@",Smart_community_picURL,[freeArticleModel.imagesArr firstObject]];

    [self.communityImageView load:strurl placeholderImage:[UIImage imageNamed:@"3.jpg"]];

//    self.communityImageView.size = [SmartCommunityPhotosView sizeWithCount:freeArticleModel.imagesArr.count];
//    self.communityImageView.photos = freeArticleModel.imagesArr;
    

    /*
     //用户头像
     @property(nonatomic,strong) UIImageView *userImageView;
     //用户名
     @property(nonatomic,strong) UILabel *userNameLabel;
     //发布时间
     @property(nonatomic,strong) UILabel *uploadTimeLabel;
     //是否支持物物交换
     @property(nonatomic,assign) BOOL isSupportBarter;
     @property(nonatomic,strong) UIImageView *isSupportBarterImageView;
     @property(nonatomic,strong) UILabel *isSupportBarterLabel;
     //图片
     @property(nonatomic,strong) UIImageView *communityImageView;
     @property(nonatomic,strong) MaterialsAreadlySaleView *areadlySaleView;
     //价格
     @property(nonatomic,strong) UILabel *priceLabel;
     //原价
     @property(nonatomic,strong) UILabel *oldPriceLabel;
     //点赞、数量
     @property(nonatomic,strong) UIButton *thumbUpButton;
     @property(nonatomic,strong) UILabel *thumbUpCountLabel;
     //评论、数量
     @property(nonatomic,strong) UIButton *commentsButton;
     @property(nonatomic,strong) UILabel *commentCountLabel;
     //物品信息
     @property(nonatomic,strong) UILabel *communityContentLabel;
     
     */
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];

}




//设置点赞,取消还是点击点赞
- (void)thumbUpButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected)
    {
        self.freeArticleModel.number += 1;
    }else
    {
        self.freeArticleModel.number -= 1;
    
    }
    //设置点赞数据
    self.thumbUpCountLabel.text = [NSString stringWithFormat:@"%ld",(long)self.freeArticleModel.number];

    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userId"] = UserID;
    parmas[@"sessionId"] = SessionID;
    parmas[@"id"] = self.freeArticleModel.ID;
    NSString*url = @"likes/cancel/fabulous";
    NSString*AFurl = [NSString stringWithFormat:@"%@smart_community/likes/cancel/fabulous",Smart_community_URL];
    
    
    MJRefreshLog(@"%@url---:%@",parmas,url);

    [[AFHTTPSessionManager manager]POST:AFurl parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           MJRefreshLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          MJRefreshLog(@"%@",error);
    }];
    
    
//    [[RequestManager manager] JSONRequestWithType:Smart_community urlString:url method:RequestMethodPost timeout:20 parameters:parmas success:^(id  _Nullable responseObject) {
//            MJRefreshLog(@"%@",responseObject);
//    } faile:^(NSError * _Nullable error) {
//          MJRefreshLog(@"%@",error);
//    }];
    
    
}

//回复
-(void)commentsButtonClick
{
    
}

//点击文字的时候进行跳转
-(void)contentLableTap
{
    FreeArticleDetailTableVC *vc = [[FreeArticleDetailTableVC alloc] init];
    vc.model = self.freeArticleModel;
    [self.nav pushViewController:vc animated:YES];
}

@end
