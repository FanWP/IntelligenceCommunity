//
//  CommunityServiceListCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "CommunityServiceListCell.h"

@implementation CommunityServiceListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    _advertiseImageView = [[UIImageView alloc] init];
    _advertiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    _advertiseImageView.clipsToBounds = YES;
    _advertiseImageView.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_advertiseImageView];
    [_advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.bottom.right.mas_equalTo(0);
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
