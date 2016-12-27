//
//  NeiborhoodHeaderView.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/22.
//  Copyright © 2016年 mumu. All rights reserved.
//
#import "RSA.h"//加密

#import "NeiborhoodHeaderView.h"
#import "SmartCommunityPhotosView.h"


#import "NeighborhoodModel.h"


@interface NeiborhoodHeaderView ()

//用户头像
@property(nonatomic,strong) UIImageView *userImageView;
//用户名
@property(nonatomic,strong) UILabel *userNameLabel;
//发布时间
@property(nonatomic,strong) UILabel *uploadTimeLabel;

/** 活动的主题 */
@property (nonatomic,weak) UILabel *titleLable;

//对话按钮
@property(nonatomic,strong) UIButton *dialogueButton;
//动态内容
@property(nonatomic,strong) UILabel *dynamicLabel;
//活动时间
@property(nonatomic,strong) UILabel *actionTimeLabel;
//活动地点
@property(nonatomic,strong) UILabel *addressLabel;

// 删除 、点赞、评论
/** 删除点赞评论的容器 */
@property (nonatomic,weak) UIView *commentBtnView;
@property(nonatomic,strong) UIButton *thumbUpButton;
/** 点赞的个数 */
@property (nonatomic,strong) UILabel *thumbUpCountLabel;

/** 中间的头像view  根据图像的个数计算尺寸 */
@property (nonatomic,strong) SmartCommunityPhotosView *photosView;


@end

@implementation NeiborhoodHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithReuseIdentifier:reuseIdentifier]) {
        [self initializeComponent];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



+(instancetype)headerWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    NeiborhoodHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil)
    {
        header = [[NeiborhoodHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

-(void)initializeComponent{
    
    //用户头像
    //    @property(nonatomic,strong) UIButton *userImageView;
    _userImageView = [[UIImageView alloc] init];
    _userImageView.contentMode = UIViewContentModeScaleAspectFill;
    _userImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    _userImageView.layer.cornerRadius = 23;
    _userImageView.layer.masksToBounds = YES;
    [self addSubview:_userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(12);
        make.left.mas_offset(16);
        make.width.height.mas_offset(45);
    }];
    //    //用户名
    //    @property(nonatomic,strong) UILabel *userNameLabel;
    _userNameLabel = [[UILabel alloc] init];
    //    _userNameLabel.text = @"咖啡小猫";
    _userNameLabel.textColor = [UIColor blackColor];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNameLabel.font = UIFontLarge;
    [self addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImageView.mas_top);
        make.left.equalTo(_userImageView.mas_right).offset(12);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
    //    //发布时间
    //    @property(nonatomic,strong) UILabel *uploadTimeLabel;
    _uploadTimeLabel = [[UILabel alloc] init];
    //   _uploadTimeLabel.text = @"1分钟前";
    _uploadTimeLabel.textColor = MJRefreshColor(132, 132, 132); //32 195 162
    _uploadTimeLabel.textAlignment = NSTextAlignmentLeft;
    _uploadTimeLabel.font = UIFontSmall;
    [self addSubview:_uploadTimeLabel];
    [_uploadTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLabel.mas_left);
        make.bottom.equalTo(_userImageView.mas_bottom);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
    //    //对话按钮
    //    @property(nonatomic,strong) UIButton *dialogueButton;
    _dialogueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dialogueButton setTitle:@"对话" forState:UIControlStateNormal];
    [_dialogueButton addTarget:self action:@selector(dialogueButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _dialogueButton.backgroundColor = [UIColor clearColor];
    _dialogueButton.layer.masksToBounds = YES;
    _dialogueButton.layer.cornerRadius = 5;
    _dialogueButton.layer.borderWidth = 1;
    _dialogueButton.layer.borderColor = GreenColer.CGColor;
    [_dialogueButton setTitleColor:GreenColer forState:UIControlStateNormal];
    [self addSubview:_dialogueButton];
    [_dialogueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_userImageView.mas_centerY);
        make.right.mas_equalTo(-16);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    //主题
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.y = 69;
    titleLable.x = 16;
    titleLable.width = KWidth - 32;
    titleLable.height = 20;
    titleLable.font = UIFont15;
    titleLable.numberOfLines = 0;
    //    titleLable.text = @"标题";
    //    titleLable.backgroundColor = [UIColor redColor];
    self.titleLable = titleLable;
    [self addSubview:titleLable];
    
    
    //    //图片
    SmartCommunityPhotosView *photosView = [[SmartCommunityPhotosView alloc] init];
    self.photosView = photosView;
    [self addSubview:photosView];
    
    
    //    //动态内容
    //    @property(nonatomic,strong) UILabel *dynamicLabel;
    _dynamicLabel = [[UILabel alloc] init];
    //   _dynamicLabel.text = @"家里新买的栀子花终于开了";
    _dynamicLabel.textColor = [UIColor grayColor];
    _dynamicLabel.textAlignment = NSTextAlignmentLeft;
    _dynamicLabel.font = UIFontNormal;
    _dynamicLabel.numberOfLines = 0;
    _dynamicLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:_dynamicLabel];
    
    /*
     @property(nonatomic,strong) UILabel *actionTimeLabel;
     @property(nonatomic,strong) UILabel *addressLabel;
     */
    //时间
    UILabel *actionTimeLabel = [[UILabel alloc] init];
    actionTimeLabel.numberOfLines = 0;
    actionTimeLabel.font = UIFontNormal;
    self.actionTimeLabel = actionTimeLabel;
    [self addSubview:actionTimeLabel];
    
    //地点
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.numberOfLines = 0;
    addressLabel.font = UIFontNormal;
    self.addressLabel = addressLabel;
    [self addSubview:addressLabel];
    
    
    
    //    // 删除 点赞、评论
    //    @property(nonatomic,strong) UIButton *thumbUpButton;
    //    @property(nonatomic,strong) UIButton *commentsButton;
    UIView *commentBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 35)];
    self.commentBtnView = commentBtnView;
    [self addSubview:commentBtnView];
    
    //评论
    _commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentsButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    _commentsButton.width = 30;
    _commentsButton.x = KWidth - 16 - _commentsButton.width;
    _commentsButton.height = 35;
    _commentsButton.y = 0;
    [commentBtnView addSubview:_commentsButton];
    
    _thumbUpCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_commentsButton.x - 30, 0, 30, 35)];
    _thumbUpCountLabel.textAlignment = NSTextAlignmentCenter;
    _thumbUpCountLabel.font = UIFontNormal;
    _thumbUpCountLabel.textColor = [UIColor redColor];
    [commentBtnView addSubview:_thumbUpCountLabel];
    
    
    //点赞
    _thumbUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_thumbUpButton setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
    [_thumbUpButton setImage:[UIImage imageNamed:@"praise2"] forState:UIControlStateSelected];
    [_thumbUpButton addTarget:self action:@selector(thumbUpButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _thumbUpButton.width = 30;
    _thumbUpButton.x = KWidth - 16 - _commentsButton.width - 60;
    _thumbUpButton.height = 35;
    _thumbUpButton.y = 0;
    [commentBtnView addSubview:_thumbUpButton];
    
    
    //删除
    _deleteteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteteButton setTitle:@"删除" forState:UIControlStateNormal];
    _deleteteButton.width = 90;
    _deleteteButton.x = 0;//239 143 88
    _deleteteButton.height = 35;
    _deleteteButton.y = 0;
    [_deleteteButton setTitleColor:MJRefreshColor(239, 143, 88) forState:UIControlStateNormal];
    _deleteteButton.titleLabel.font = UIFont15;
    [_deleteteButton addTarget:self action:@selector(deleteteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [commentBtnView addSubview:_deleteteButton];

}





//传值
-(void)setNeiborhoodModel:(NeighborhoodModel *)neiborhoodModel
{
    _neiborhoodModel = neiborhoodModel;
    //头像
    [self.userImageView load:neiborhoodModel.headImage placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    //昵称
    self.userNameLabel.text = neiborhoodModel.userNickName;
    //发布时间
    self.uploadTimeLabel.text = neiborhoodModel.createtime;
    //对话按钮
    
    //标题计算位置
    self.titleLable.y = 69;
    self.titleLable.x = 16;
    self.titleLable.size = neiborhoodModel.titlewSize;
    if (neiborhoodModel.type == 2) {//生活分享
        self.titleLable.text = neiborhoodModel.content;
    }else{
        self.titleLable.text = neiborhoodModel.title;
    }


    
    //计算图片的尺寸
    self.photosView.x = 8;
    self.photosView.size = neiborhoodModel.photosSize;
    self.photosView.y = CGRectGetMaxY(_titleLable.frame) + 12;
    NSArray *arr = [neiborhoodModel.images componentsSeparatedByString:@","];
    self.photosView.photos = arr;

    //计算内容尺寸
    _dynamicLabel.size = neiborhoodModel.commenSize;
    _dynamicLabel.x = 16;
    _dynamicLabel.y = CGRectGetMaxY(_photosView.frame) + 12;
    //动态内容
    self.dynamicLabel.text = neiborhoodModel.content;

    //时间
    self.actionTimeLabel.size = neiborhoodModel.actionTimeSize;
    self.actionTimeLabel.x = 16;
    self.actionTimeLabel.y = CGRectGetMaxY(_dynamicLabel.frame) + 8;
    if (self.actionTimeLabel) {
        self.actionTimeLabel.text = [NSString stringWithFormat:@"时间：%@",neiborhoodModel.actionTime];
    }
    
    //地点
    self.addressLabel.size = neiborhoodModel.addressSize;
    self.addressLabel.x = 16;
    self.addressLabel.y = CGRectGetMaxY(_actionTimeLabel.frame) + 8;
    self.addressLabel.text = [NSString stringWithFormat:@"地点：%@",neiborhoodModel.address];
    
    //设置点赞数据
    self.thumbUpCountLabel.text = [NSString stringWithFormat:@"%ld",(long)self.neiborhoodModel.number];
    
    if (neiborhoodModel.type == 2) {//约
        self.dynamicLabel.hidden = YES;
        self.actionTimeLabel.hidden = YES;
        self.addressLabel.hidden = YES;
        
        //删除、点赞，评论
        _commentBtnView.x = 0;
        _commentBtnView.y = CGRectGetMaxY(_photosView.frame);
        
    }else if (neiborhoodModel.type == 3){//生活分享
        self.actionTimeLabel.hidden = YES;
        self.addressLabel.hidden = YES;
        
        //删除、点赞，评论
        _commentBtnView.x = 0;
        _commentBtnView.y = CGRectGetMaxY(_dynamicLabel.frame);
    
    }else
    {
        self.dynamicLabel.hidden = NO;
        self.actionTimeLabel.hidden = NO;
        self.addressLabel.hidden = NO;
        
        //删除、点赞，评论
        _commentBtnView.x = 0;
        _commentBtnView.y = CGRectGetMaxY(_addressLabel.frame);

    }
    
    
    //判断删除按钮的隐藏还是显示
    if ([neiborhoodModel.userid isEqualToString:UserID]) {//判断是否是当前用户发的动态
        _deleteteButton.hidden = NO;
    }else
    {
        _deleteteButton.hidden = YES;
    }
    
    //判断点赞按钮是否是已经点赞
    NSString *userId = [NSString stringWithFormat:@",%@,",UserID];
    if ([neiborhoodModel.likeUserid containsString:userId]) {
        _thumbUpButton.selected = YES;
    }else{
        _thumbUpButton.selected = NO;
    }
    
    
    
    
    
//    //删除、点赞，评论
//    _commentBtnView.x = 0;
//    _commentBtnView.y = CGRectGetMaxY(_addressLabel.frame);
    
    
    
    /*
     //用户头像
     @property(nonatomic,strong) UIImageView *userImageView;
     //用户名
     @property(nonatomic,strong) UILabel *userNameLabel;
     //发布时间
     @property(nonatomic,strong) UILabel *uploadTimeLabel;
     //对话按钮
     @property(nonatomic,strong) UIButton *dialogueButton;
     //图片
     @property(nonatomic,strong) UIImageView *imageView_1;
     @property(nonatomic,strong) UIImageView *imageView_2;
     @property(nonatomic,strong) UIImageView *imageView_3;
     
     //动态内容
     @property(nonatomic,strong) UILabel *dynamicLabel;
     
     //点赞、评论
     @property(nonatomic,strong) UIButton *thumbUpButton;
     @property(nonatomic,strong) UIButton *commentsButton;
     */
    
}

//点赞的点击事件
-(void)thumbUpButtonBtnClick:(UIButton *)button
{
    MJRefreshLog(@"点赞");
    button.selected = !button.selected;
    if (button.selected)
    {
        self.neiborhoodModel.number += 1;
    }else
    {
        self.neiborhoodModel.number -= 1;
        
    }
    //设置点赞数据
    self.thumbUpCountLabel.text = [NSString stringWithFormat:@"%ld",(long)self.neiborhoodModel.number];
    
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userId"] = UserID;
    parmas[@"sessionId"] = SessionID;
    parmas[@"id"] = self.neiborhoodModel.ID;
    NSString*AFurl = [NSString stringWithFormat:@"%@smart_community/likes/fabulous/friendsCircle",Smart_community_URL];
    
    
    MJRefreshLog(@"%@url---:%@",parmas,AFurl);
    
    [[AFHTTPSessionManager manager]POST:AFurl parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MJRefreshLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MJRefreshLog(@"%@",error);
    }];

}

//对话按钮的点击事件
- (void)dialogueButtonClick
{
    MJRefreshLog(@"对话");

    //获取公钥
    
    /*
     pubKey = MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDoKNwoOrJQguazWyH+apdVlq6zJDx7bVDV5Fq2pxs9uPuGCeTH803TSA+pOguNCZ1Og6+XuP/FkqyN3etdu9qFQqkSsNDZzPBWhwG9bnNLLpnO/hDS4PVLg0pLNZFl1Pbi/TYhFxg2w+YQU1FW4P/9pWHbgE2YG+gWO+MC9ee2LwIDAQAB

     */
//    NSDictionary *parmas = [NSMutableDictionary dictionary];
//    NSString *url = @"http://192.168.1.23:8080/smart_community/unlogin/sendpubkeyservlet";
//    [[AFHTTPSessionManager manager]POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        MJRefreshLog(@"%@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        MJRefreshLog(@"%@",error);
//        
//    }];
//    
    
    
//    //获取验证码
//    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
//    parmas[@"userPhone"] = @"18092456642";
//    NSString *url1 = @"http://192.168.1.23:8080/smart_community/unlogin/send/check/code";
//    [[AFHTTPSessionManager manager]POST:url1 parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        MJRefreshLog(@"获取验证码---:%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        MJRefreshLog(@"获取验证码--:%@",error);
//    }];

    
//    
    NSString *psw = @"qqq111";
    NSString *pubKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDoKNwoOrJQguazWyH+apdVlq6zJDx7bVDV5Fq2pxs9uPuGCeTH803TSA+pOguNCZ1Og6+XuP/FkqyN3etdu9qFQqkSsNDZzPBWhwG9bnNLLpnO/hDS4PVLg0pLNZFl1Pbi/TYhFxg2w+YQU1FW4P/9pWHbgE2YG+gWO+MC9ee2LwIDAQAB";
//    NSString *password = [RSA encryptString:psw publicKey:pubKey];
    NSString *sessionId = @"";
//
//    //注册
//    NSMutableDictionary *parmas1 = [NSMutableDictionary dictionary];
//    parmas1[@"userPhone"] = @"18092456642";
//    parmas1[@"passWord"] = password;
//    parmas1[@"checkCode"] = @"894094";
//    NSString *url2 = @"http://192.168.1.23:8080/smart_community/unlogin/register";
//    
//    MJRefreshLog(@"parmas1--:%@url--:%@",parmas1,url2);
//    
//    [[AFHTTPSessionManager manager]POST:url2 parameters:parmas1 progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        MJRefreshLog(@"注册成功---:%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        MJRefreshLog(@"注册失败--:%@",error);
//    }];
    
    
    
//    //    //登录
//    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
//    parmas[@"userPhone"] = @"18092456642";
//    parmas[@"passWord"] = password;
//    NSString *url1 = @"http://192.168.1.23:8080/smart_community//unlogin/userlogin";
//        MJRefreshLog(@"parmas--:%@url--:%@",parmas,url1);
//    
//        [[AFHTTPSessionManager manager]POST:url1 parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
//    
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            MJRefreshLog(@"用户登录---:%@",responseObject);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            MJRefreshLog(@"用户登录失败--:%@",error);
//        }];
    
    
    NSString *session = @"2A08B3EA2BB41BE3B914D072D6B94CA795379C34C5477E62818F03FEC887D34F";
//    NSString *sessionId = [RSA encryptString:session publicKey:pubKey];
//    NSString *sessionId = @"";

    
    NSString *RsaSessionID = @"w/u4EKU32dryicnUAMKE9cBUr4bbEGDIRE00ppoWNmTh+R577T1ukKzY/oofyxELwZffoB9gqWpQUZDnIAoJF1D4UAYpRjwUDp+JgwmhdxXwTwF509uN1jLxZmQCfmZsogkFomOrI5kN5M7yztjVw1IsFAhbgAdl6i2noQTSofk=";
    
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userPhone"] = @"18092456642";
//    parmas[@"passWord"] = password;
    NSString *url1 = @"http://192.168.1.23:8080/smart_community//unlogin/userlogin";
    MJRefreshLog(@"parmas--:%@url--:%@",parmas,url1);
    
    [[AFHTTPSessionManager manager]POST:url1 parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MJRefreshLog(@"用户登录---:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MJRefreshLog(@"用户登录失败--:%@",error);
    }];
    
    
    
    
    
    
}

//删除按钮的点击事件
- (void)deleteteButtonClick
{

    MJRefreshLog(@"0000--删除");
}

@end
