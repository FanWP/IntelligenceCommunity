//
//  NoticeCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NoticeCell.h"

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
    _noticeCellImageView.contentMode = UIViewContentModeScaleAspectFit;
    _noticeCellImageView.image = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    [self addSubview:_noticeCellImageView];
    [_noticeCellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(50);
    }];
    
    _noticeCellLabel = [[UILabel alloc] init];
    _noticeCellLabel.text = @"公告";
    _noticeCellLabel.textAlignment = NSTextAlignmentCenter;
    _noticeCellLabel.textColor = [UIColor grayColor];
    [self addSubview:_noticeCellLabel];
    [_noticeCellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noticeCellImageView.mas_top);
        make.bottom.equalTo(_noticeCellImageView.mas_bottom);
        make.left.equalTo(_noticeCellImageView.mas_right).offset(5);
        make.width.mas_equalTo(50);
    }];

    _noticeCellContentLabel = [[UILabel alloc] init];
    if (!_noticeCellContentString.length) {
        _noticeCellContentString = @"及时知晓小区最新通知";
    }
    _noticeCellContentLabel.text = _noticeCellContentString;
    _noticeCellContentLabel.textAlignment = NSTextAlignmentCenter;
    _noticeCellContentLabel.textColor = [UIColor grayColor];
    [self addSubview:_noticeCellContentLabel];
    [_noticeCellContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noticeCellImageView.mas_top);
        make.left.equalTo(_noticeCellLabel.mas_right).offset(20);
        make.right.mas_equalTo(-20);
        make.bottom.equalTo(_noticeCellImageView.mas_bottom);
    }];
    
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
