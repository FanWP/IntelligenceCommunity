//
//
//  FreeArticleHeaderView.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/17.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SmartCommunityPhotosView.h"
#import "WUImageBrowseView.h"



#define HWStatusPhotoWH (KWidth - 40) / 3
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)


@interface SmartCommunityPhotosView ()<WUImageBrowseViewDelegate>

@end

@implementation SmartCommunityPhotosView
// 9

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        UIImageView *photoView = [[UIImageView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
//            photoView.photo = photos[i];
            [photoView load:[NSString stringWithFormat:@"%@%@",Smart_community_picURL,photos[i]] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTouch:)];
            
            [photoView addGestureRecognizer:tap];
            
            
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = HWStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
    }
}
+ (CGSize)sizeWithCount:(NSUInteger)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = HWStatusPhotoMaxCol(count);
    
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}


-(void)photoTouch:(UIGestureRecognizer *)index
{
    MJRefreshLog(@"%ld",index.view.tag);

    NSMutableArray *imageArray = [NSMutableArray array];
//    for(int i = 1 ; i <=  self.photos.count; i++){
////        //获取图片在应用程序包中的路径
////        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"test%d",i] ofType:@".jpg"];
////        //根据路径获取图片
////        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
//        
//        UIImage *image = [UIImage imageNamed:@"halt sales"];
//
//        [imageArray addObject:image];
//    }
    
    imageArray =  @[
                    @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                    @"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
                    @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                    @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                    @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
                    @"http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
                    ];

    
    
    WUImageBrowseView *vc = [[WUImageBrowseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    vc.images = (NSArray *)imageArray;
    vc.delegate = self;
    vc.currentPage = index.view.tag;
    CGRect startFrame = CGRectMake(100, 300, 50, 50);
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    [vc show:[self viewController].navigationController.view startFrame:startFrame foregroundImage:image];
 
}


- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



@end
