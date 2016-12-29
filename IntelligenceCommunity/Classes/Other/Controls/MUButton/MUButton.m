
//
//  MUButton.m
//  IntelligenceCommunity
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "MUButton.h"
#import "MULoaderView.h"

@interface MUButton ()

@property(nonatomic,strong) MULoaderView *loaderView;


@end
@implementation MUButton

-(instancetype)init {
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if(CGSizeEqualToSize(frame.size, CGSizeZero)) {
        frame.size = CGSizeMake(280, 44);
    }
    self = [super initWithFrame:frame];
    if(self) {
        [self initializeComponent];
    }
    return self;
}

-(void)initializeComponent {
    
    _loaderView = [[MULoaderView alloc] init];
    _loaderView.hidden = YES;
    [self addSubview:_loaderView];
    
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width - 30;
    CGFloat height = self.frame.size.height;
    NSString *title = self.titleLabel.text;
    CGFloat loaderHeight = height > 24 ? 24 : height;
    if(title && title.length > 0) {
        CGRect titleRect = [title boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
        
        _loaderView.frame = CGRectMake(CGRectGetWidth(self.frame)/2 - CGRectGetWidth(titleRect)/2 - loaderHeight - 5, height/2 - loaderHeight/2, loaderHeight, loaderHeight);
    } else {
        _loaderView.frame = CGRectMake(CGRectGetWidth(self.frame)/2 - loaderHeight / 2, height/2 - loaderHeight/2, loaderHeight, loaderHeight);
    }
}

-(void)startAnimation {
    _loaderView.hidden = NO;
    [_loaderView beginAnimation];
}

-(void)stopAnimation {
    _loaderView.hidden = YES;
    [_loaderView stopAnimation];
}


@end
