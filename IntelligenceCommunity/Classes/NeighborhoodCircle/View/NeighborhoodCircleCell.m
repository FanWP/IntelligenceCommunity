//
//  NeighborhoodCircleCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodCircleCell.h"

#import "NeighborhoodModel.h"


#import "SmartCommunityPhotosView.h"




@interface NeighborhoodCircleCell ()


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
@property(nonatomic,strong) UIButton *commentsButton;
@property(nonatomic,strong) UIButton *deleteteButton;

/** 中间的头像view  根据图像的个数计算尺寸 */
@property (nonatomic,strong) SmartCommunityPhotosView *photosView;



@end
@implementation NeighborhoodCircleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initializeComponent];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
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

    
    //点赞
    _thumbUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_thumbUpButton setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
    [_thumbUpButton setImage:[UIImage imageNamed:@"praise2"] forState:UIControlStateSelected];
    [_thumbUpButton addTarget:self action:@selector(thumbUpButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _thumbUpButton.width = 30;
    _thumbUpButton.x = KWidth - 16 - _commentsButton.width - 100;
    _thumbUpButton.height = 35;
    _thumbUpButton.y = 0;
    [commentBtnView addSubview:_thumbUpButton];
    
    
    //删除
    _deleteteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteteButton setTitle:@"删除" forState:UIControlStateNormal];
    _deleteteButton.width = 90;
    _deleteteButton.x = 16;//239 143 88
    _deleteteButton.height = 35;
    _deleteteButton.y = 0;
    [_deleteteButton setTitleColor:MJRefreshColor(239, 143, 88) forState:UIControlStateNormal];
    _deleteteButton.titleLabel.font = UIFont17;
    [commentBtnView addSubview:_deleteteButton];

    

    //对话按钮 @property(nonatomic,strong) UIButton *dialogueButton;
    _dialogueButton.tag = 1;
    [_dialogueButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //点赞、评论
    //    @property(nonatomic,strong) UIButton *thumbUpButton;
    _thumbUpButton.tag = 2;
    [_thumbUpButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //    @property(nonatomic,strong) UIButton *commentsButton;
    _commentsButton.tag = 3;
    [_commentsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(neighborhoodCircleCell:clickButtonWithTag:) ]) {
        [_delegate neighborhoodCircleCell:self clickButtonWithTag:button.tag];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    self.uploadTimeLabel.text = neiborhoodModel.createTime;
    //对话按钮
    
    //标题
    
    //计算位置
    self.titleLable.y = CGRectGetMaxY(_userImageView.frame) + 12;
    self.titleLable.x = 16;
    self.titleLable.size = neiborhoodModel.titlewSize;
    self.titleLable.text = neiborhoodModel.title;
    
    //计算图片的尺寸
    self.photosView.x = 16;
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
    self.actionTimeLabel.text = [NSString stringWithFormat:@"时间：%@",neiborhoodModel.actionTime];
    
    //地点
    self.addressLabel.size = neiborhoodModel.addressSize;
    self.addressLabel.x = 16;
    self.addressLabel.y = CGRectGetMaxY(_actionTimeLabel.frame) + 8;
    self.addressLabel.text = [NSString stringWithFormat:@"地点：%@",neiborhoodModel.address];
    
    
    //删除、点赞，评论
    _commentBtnView.x = 0;
    _commentBtnView.y = CGRectGetMaxY(_addressLabel.frame) + 12;
    


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

}


@end
