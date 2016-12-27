//
//  FreeArticleReplyCell.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleReplyCell.h"
#import "FreeArticleReplyModel.h"


@interface FreeArticleReplyCell ()

/** 回复消息的内容 */
@property (nonatomic,weak) UILabel *commentLable;

/** 设置回复的容器 */
@property (nonatomic,weak) UIView *replyView;

@end

@implementation FreeArticleReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    FreeArticleReplyCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FreeArticleReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        //设置内容
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = MJRefreshColor(223, 227, 224);
        self.replyView = view;
        [self.contentView addSubview:view];
        
        UILabel *commentLable = [[UILabel alloc] init];
        commentLable.centerY = view.height * 0.5;
        commentLable.numberOfLines = 0;
        commentLable.font = UIFont13;
        self.commentLable = commentLable;
        [view addSubview:commentLable];

    }
    return self;

}



-(void)setReplyModel:(FreeArticleReplyModel *)replyModel
{
    _replyModel = replyModel;

    //设置内容
    self.replyView.frame = CGRectMake(10, 0, KWidth - 20, replyModel.contentH + 10);
    self.commentLable.frame = CGRectMake(7, 0, _replyView.width - 12, replyModel.contentH);
    _commentLable.centerY = _replyView.height * 0.5;
    _commentLable.attributedText = replyModel.attrText;
}

@end
