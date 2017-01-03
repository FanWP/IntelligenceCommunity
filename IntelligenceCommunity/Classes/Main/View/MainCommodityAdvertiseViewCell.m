//
//  MainCommodityAdvertiseViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/29.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MainCommodityAdvertiseViewCell.h"

@interface MainCommodityAdvertiseViewCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation MainCommodityAdvertiseViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initializeComponent{
    
        //地图宣传图
    //    @property(nonatomic,strong) UIImageView *advertiseImageView;
        _advertiseImageView = [[UIImageView alloc] init];
    _advertiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    _advertiseImageView.clipsToBounds = YES;
        _advertiseImageView.image = [UIImage imageNamed:@"3.jpg"];
        [self addSubview:_advertiseImageView];
        [_advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kGetVerticalDistance(16));
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(kGetVerticalDistance(230));
        }];
        //    @property(nonatomic,strong) UILabel *advertiseContentLabel;
        _advertiseContentLabel = [[UILabel alloc] init];
        _advertiseContentLabel.text = @"新鲜牛奶到家";
    _advertiseContentLabel.backgroundColor = [UIColor whiteColor];
    _advertiseContentLabel.textAlignment = NSTextAlignmentLeft;
    _advertiseContentLabel.textColor = HexColor(0x131313);
        _advertiseContentLabel.font = UIFontNormal;
        [self addSubview:_advertiseContentLabel];
        [_advertiseContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_advertiseImageView.mas_bottom).offset(0);
            make.left.mas_equalTo(kGetHorizontalDistance(30));
            make.right.mas_offset(0);
            make.bottom.mas_offset(0);
        }];
    
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = HexColor(0xeeeeee).CGColor;
    [self.contentView.layer addSublayer:_lineLayer];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _lineLayer.frame = CGRectMake(0, 0, ScreenWidth, kGetVerticalDistance(16));
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
