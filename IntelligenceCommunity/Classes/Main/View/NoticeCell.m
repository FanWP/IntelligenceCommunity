//
//  NoticeCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NoticeCell.h"

@interface NoticeCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation NoticeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
            [self initializeComponent];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
-(void)initializeComponent{
    _noticeCellImageView = [[UIImageView alloc] init];
    _noticeCellImageView.contentMode = UIViewContentModeCenter;
    _noticeCellImageView.clipsToBounds = YES;
    _noticeCellImageView.image = [UIImage imageNamed:@"Public notice"];
    [self addSubview:_noticeCellImageView];
    [_noticeCellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(30);
    }];
    
    _noticeCellLabel = [[UILabel alloc] init];
    _noticeCellLabel.text = @"公告";
    _noticeCellLabel.textAlignment = NSTextAlignmentCenter;
    _noticeCellLabel.textColor = [UIColor blackColor];
    [self addSubview:_noticeCellLabel];
    [_noticeCellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noticeCellImageView.mas_top);
        make.bottom.equalTo(_noticeCellImageView.mas_bottom);
        make.left.equalTo(_noticeCellImageView.mas_right).offset(0);
        make.width.mas_equalTo(50);
    }];

    _noticeCellContentLabel = [[UILabel alloc] init];
    if (!_noticeCellContentString.length) {
        _noticeCellContentString = @"及时知晓小区最新通知";
    }
    _noticeCellContentLabel.text = _noticeCellContentString;
    _noticeCellContentLabel.textAlignment = NSTextAlignmentRight;
    _noticeCellContentLabel.textColor = [UIColor blackColor];
    _noticeCellContentLabel.font = UIFontNormal;
    [self addSubview:_noticeCellContentLabel];
    [_noticeCellContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noticeCellImageView.mas_top);
        make.left.equalTo(_noticeCellLabel.mas_right).offset(0);
        make.right.mas_equalTo(-40);
        make.bottom.equalTo(_noticeCellImageView.mas_bottom);
    }];
    
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
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
