//
//  FreeArticleDetailTableViewImagesCell.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleDetailTableViewImagesCell.h"

@implementation FreeArticleDetailTableViewImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization cod
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, KWidth - 20, 202)];
        self.images = images;
        [self.contentView addSubview:images];
    }
    return self;
}

@end
