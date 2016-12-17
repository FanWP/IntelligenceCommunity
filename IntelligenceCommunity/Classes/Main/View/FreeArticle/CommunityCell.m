//
//  CommunityCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommunityCell.h"
#import "MaterialsAreadlySaleView.h"  //已售

#import "FreeArticleModel.h"


@interface CommunityCell ()

@property(nonatomic,strong) CALayer *lineLayer;


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

/** 已售 */
@property (nonatomic,weak) UIImageView *alreadySell;


@end

@implementation CommunityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initializeComponent];
    }
    return self;
}

-(void)initializeComponent{
    
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
//    _userNameLabel.text = @"咖啡小猫";
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
//    _uploadTimeLabel.text = @"1分钟前";
    _uploadTimeLabel.textColor = [UIColor grayColor];
    _uploadTimeLabel.textAlignment = NSTextAlignmentLeft;
    _uploadTimeLabel.font = UIFontNormal;
    [self addSubview:_uploadTimeLabel];
    [_uploadTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLabel).offset(0);
        make.bottom.equalTo(_userImageView.mas_bottom).offset(0);
        make.width.mas_offset(120);
        make.height.mas_offset(20);
    }];
//    //是否支持物物交换
//    @property(nonatomic,assign) BOOL isSupportBarter;
//    @property(nonatomic,strong) UIImageView *isSupportBarterImageView;
//    @property(nonatomic,strong) UILabel *isSupportBarterLabel;
    _isSupportBarterLabel = [[UILabel alloc] init];
    _isSupportBarterLabel.text = @"支持物物交换";
    _isSupportBarterLabel.textColor = MJRefreshColor(239, 143, 88);
    _isSupportBarterLabel.textAlignment = NSTextAlignmentLeft;
    _isSupportBarterLabel.font = UIFont13;
    [self addSubview:_isSupportBarterLabel];
    [_isSupportBarterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_userImageView.mas_centerY);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    

//    //图片
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
    img.mj_y = _communityImageView.mj_y + 60;
    self.alreadySell = img;
    [self addSubview:img];
#warning 原价、点赞、评论系列控件以[价格]的中心线为基准对齐
//    //价格
//    @property(nonatomic,strong) UILabel *priceLabel;
    _priceLabel = [[UILabel alloc] init];
//    _priceLabel.text = @"￥210元";
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
//    _oldPriceLabel.text = @"原价￥300元";
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
    [_thumbUpButton setImage:[UIImage imageNamed:@"praise2"] forState:UIControlStateNormal];
    [self addSubview:_thumbUpButton];
    [_thumbUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_priceLabel.mas_centerY);
        make.right.equalTo(_thumbUpCountLabel.mas_left).offset(-2);
        make.width.height.mas_equalTo(_communityContentLabel);
    }];
//    //物品信息
//    @property(nonatomic,strong) UILabel *communityContentLabel;
    _communityContentLabel = [[UILabel alloc] init];
//    _communityContentLabel.text = @"八成新的自行车准备转手-八成新的自行车准备转手-八成新的自行车准备转手";
    _communityContentLabel.textColor = [UIColor grayColor];
    _communityContentLabel.textAlignment = NSTextAlignmentLeft;
    _communityContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _communityContentLabel.font = UIFont15;
    [self addSubview:_communityContentLabel];
    [_communityContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    //分割线
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.contentView.layer addSublayer:_lineLayer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _lineLayer.frame = CGRectMake(0, self.bounds.size.height-5, self.width, 8);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//设置数据
-(void)setFreeArticleModel:(FreeArticleModel *)freeArticleModel
{
    _freeArticleModel = freeArticleModel;
    
    [self.userImageView load:freeArticleModel.images placeholderImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    self.userNameLabel.text = freeArticleModel.likeUserid;
    self.uploadTimeLabel.text = freeArticleModel.createTime;
    
//    self.isSupportBarterLabel.hidden = freeArticleModel.saleStatus == NO;
//    self.alreadySell
    
//    [self.communityImageView load:freeArticleModel.images placeholderImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    
    self.communityContentLabel.text = freeArticleModel.content;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",freeArticleModel.price];
    self.oldPriceLabel.text = [NSString stringWithFormat:@"原价%@",freeArticleModel.srcPrice];
    
    
    self.thumbUpCountLabel.text = @"iw35tip3qw";
    self.thumbUpCountLabel.text = @"86426";
    
    self.commentCountLabel.text = @"7923";
    
    
    
    
    
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

@end
