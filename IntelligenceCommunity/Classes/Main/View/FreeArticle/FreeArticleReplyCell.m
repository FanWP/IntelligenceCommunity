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

    }
    return self;

}



-(void)setReplyModel:(FreeArticleReplyModel *)replyModel
{
    _replyModel = replyModel;

    //设置内容
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, KWidth - 20, replyModel.contentH)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view];
    
    UILabel *commentLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, view.width - 16, 30)];
    commentLable.numberOfLines = 0;
    commentLable.font = UIFont13;
    commentLable.attributedText = replyModel.attrText;
    self.commentLable = commentLable;
    [view addSubview:commentLable];

    
}

@end
