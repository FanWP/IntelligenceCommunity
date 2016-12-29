//
//  OwnerViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "OwnerViewCell.h"

@interface OwnerViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation OwnerViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initializeComponent];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)initializeComponent{
    
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.contentMode = UIViewContentModeCenter;
//    _leftImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(40);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"test";
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = UIFontNormal;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_leftImageView.mas_centerY);
        make.left.equalTo(_leftImageView.mas_right);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = HexColor(0xeeeeee).CGColor;
    [self.contentView.layer addSublayer:_lineLayer];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _lineLayer.frame = CGRectMake(0, self.height-1, ScreenWidth, 1);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
