//
//  SpecialOffersListViewCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SpecialOffersListViewCell.h"

@implementation SpecialOffersListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
    }
    return self;
}
-(void)initializeComponent{
    
    __weak typeof(self) weakSelf = self;
//    @property(nonatomic,strong) UIImageView *selectimageView;
    
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setImage:[UIImage imageNamed:@"chooseEast"] forState:UIControlStateNormal];
    [_selectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectButton];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY).offset(0);
        make.left.mas_equalTo(60);
        make.width.height.mas_equalTo(30);
    }];
    
    //优惠信息详情
//    @property(nonatomic,strong) UILabel *specialOffersDetailLabel;
    _specialOffersDetailLabel = [[UILabel alloc] init];
    _specialOffersDetailLabel.text = @"优惠信息";
    _specialOffersDetailLabel.textColor = [UIColor redColor];
    _specialOffersDetailLabel.textAlignment = NSTextAlignmentLeft;
    _specialOffersDetailLabel.font = UIFontNormal;
    [self addSubview:_specialOffersDetailLabel];
    [_specialOffersDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectButton.mas_centerY);
        make.left.equalTo(_selectButton.mas_right).offset(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
}
-(void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(userSelectButtonWithSpecialOffersListViewCell:)]) {
        [_delegate userSelectButtonWithSpecialOffersListViewCell:self];
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

@end
