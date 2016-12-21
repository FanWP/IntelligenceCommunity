//
//  NeighborhoodCircleCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodCircleCell.h"

#import "NeighborhoodModel.h"



@interface NeighborhoodCircleCell ()


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
    
    [self addSubview:_userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(10);
        make.width.height.mas_offset(50);
    }];
//    //用户名
//    @property(nonatomic,strong) UILabel *userNameLabel;
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.text = @"咖啡小猫";
    _userNameLabel.textColor = [UIColor grayColor];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNameLabel.font = UIFontNormal;
    [self addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImageView.mas_top);
        make.left.equalTo(_userImageView.mas_right).offset(20);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
//    //发布时间
//    @property(nonatomic,strong) UILabel *uploadTimeLabel;
    _uploadTimeLabel = [[UILabel alloc] init];
    _uploadTimeLabel.text = @"1分钟前";
    _uploadTimeLabel.textColor = [UIColor grayColor];
    _uploadTimeLabel.textAlignment = NSTextAlignmentLeft;
    _uploadTimeLabel.font = UIFontNormal;
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
    _dialogueButton.backgroundColor = [UIColor greenColor];
    _dialogueButton.layer.masksToBounds = YES;
    _dialogueButton.layer.cornerRadius = 10;
    _dialogueButton.layer.borderWidth = 1;
    _dialogueButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self addSubview:_dialogueButton];
    [_dialogueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_userImageView.mas_centerY);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
//    //图片
//    @property(nonatomic,strong) UIImageView *imageView_1;
//    @property(nonatomic,strong) UIImageView *imageView_2;
//    @property(nonatomic,strong) UIImageView *imageView_3;
    _imageView_1 = [[UIImageView alloc] init];
    _imageView_1.contentMode = UIViewContentModeScaleAspectFill;
    _imageView_1.image = [UIImage imageNamed:@"3.jpg"];
    _imageView_1.clipsToBounds = YES;
    [self addSubview:_imageView_1];
    [_imageView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo((ScreenWidth -40)/3);
    }];
    
    _imageView_2 = [[UIImageView alloc] init];
    _imageView_2.contentMode = UIViewContentModeScaleAspectFill;
    _imageView_2.image = [UIImage imageNamed:@"3.jpg"];
    _imageView_2.clipsToBounds = YES;
    [self addSubview:_imageView_2];
    [_imageView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_imageView_1);
        make.left.equalTo(_imageView_1.mas_right).offset(10);
    }];
    
    _imageView_3 = [[UIImageView alloc] init];
    _imageView_3.contentMode = UIViewContentModeScaleAspectFill;
    _imageView_3.clipsToBounds = YES;
    _imageView_3.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_imageView_3];
    [_imageView_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.mas_equalTo(_imageView_1);
        make.left.equalTo(_imageView_2.mas_right).offset(10);
    }];
//    //动态内容
//    @property(nonatomic,strong) UILabel *dynamicLabel;
    _dynamicLabel = [[UILabel alloc] init];
    _dynamicLabel.text = @"家里新买的栀子花终于开了";
    _dynamicLabel.textColor = [UIColor grayColor];
    _dynamicLabel.textAlignment = NSTextAlignmentLeft;
    _dynamicLabel.font = UIFontNormal;
    _dynamicLabel.numberOfLines = 1;
    _dynamicLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:_dynamicLabel];
    [_dynamicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView_1.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(30);
    }];
//    //点赞、评论
//    @property(nonatomic,strong) UIButton *thumbUpButton;
    //    @property(nonatomic,strong) UIButton *commentsButton;
    _commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentsButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    [self addSubview:_commentsButton];
    [_commentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(_dynamicLabel.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    //点赞
    _thumbUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_thumbUpButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    [self addSubview:_thumbUpButton];
    [_thumbUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_dynamicLabel.mas_centerY);
        make.right.equalTo(_commentsButton.mas_left).offset(-5);
        make.width.height.mas_equalTo(_commentsButton);
    }];
    

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


@end
