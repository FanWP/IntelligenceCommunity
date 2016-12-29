//
//  DeterminePaySendAddressCell.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "DeterminePaySendAddressCell.h"

@interface DeterminePaySendAddressCell ()

@property(nonatomic,strong) CALayer *lineLayer;

@end
@implementation DeterminePaySendAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeComponent];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)initializeComponent{
    
//    __weak typeof(self) weakSelf = self;
    //图标
//    @property(nonatomic,strong) UIImageView *addressImageView;
    _addressImageView = [[UIImageView alloc] init];
    _addressImageView.contentMode = UIViewContentModeCenter;
    _addressImageView.image = [UIImage imageNamed:@"address"];
    [self.contentView addSubview:_addressImageView];
    [_addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.mas_offset(10);
        make.width.height.mas_offset(50);
    }];
//    //姓名   地址    电话
//    @property(nonatomic,strong) UILabel *nameLabel;
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"收件人: 王麻子";
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = UIFontNormal;
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.equalTo(_addressImageView.mas_right).offset(5);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
//    @property(nonatomic,strong) UILabel *phoneLabel;
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = @"电话:32974932847";
    _phoneLabel.textColor = [UIColor grayColor];
    _phoneLabel.textAlignment = NSTextAlignmentRight;
    _phoneLabel.font = UIFontNormal;
    [self.contentView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_nameLabel.mas_centerY);
        make.right.mas_offset(-5);
        make.width.mas_offset(200);
    }];
    
//    @property(nonatomic,strong) UILabel *addressLabel;
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.text = @"收货地址: 陕西省/西安市/高新区/科技四路/南窑头东区 ";
    _addressLabel.textColor = [UIColor grayColor];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    _addressLabel.font = UIFontNormal;
    _addressLabel.numberOfLines = 2;
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_nameLabel);
        make.right.mas_offset(-10);
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLabel.mas_bottom).offset(5);
        make.left.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    //送达时间      尽快送达
//    @property(nonatomic,strong) UILabel *sendTimeLabel;
//    @property(nonatomic,strong) UILabel *fastSendLabel;
    _sendTimeLabel = [[UILabel alloc] init];
    _sendTimeLabel.text = @"送达时间";
    _sendTimeLabel.textColor = [UIColor grayColor];
    _sendTimeLabel.textAlignment = NSTextAlignmentLeft;
    _sendTimeLabel.font = UIFontNormal;
    [self.contentView addSubview:_sendTimeLabel];
    [_sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(10);
        make.left.mas_offset(20);
        make.width.mas_offset(100);
    }];
    
//    arrow
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.contentMode = UIViewContentModeCenter;
    _rightImageView.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_sendTimeLabel.mas_centerY).offset(0);
        make.right.mas_offset(-10);
    }];
    _fastSendLabel = [[UILabel alloc] init];
    _fastSendLabel.text = @"尽快送达";
    _fastSendLabel.textColor = HexColor(0x0dceac);
    _fastSendLabel.textAlignment = NSTextAlignmentRight;
    _fastSendLabel.font = UIFontNormal;
    [self.contentView addSubview:_fastSendLabel];
    [_fastSendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_sendTimeLabel.mas_centerY).offset(0);
        make.right.equalTo(_rightImageView.mas_left).offset(-10);
    }];
    
    
    
    
    _lineLayer = [[CALayer alloc] init];
    _lineLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:_lineLayer];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _lineLayer.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
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
