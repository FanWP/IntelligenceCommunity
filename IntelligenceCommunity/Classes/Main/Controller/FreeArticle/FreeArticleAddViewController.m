//
//  FreeArticleAddViewController.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/19.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "FreeArticleAddViewController.h"


//添加附件
#import "SectionModel.h"
#import "HouseImageCell.h"
#import "WUAlbum.h"
#import "UIImage+Aspect.h"
#import "UIImage+FixOrientation.h"




@interface FreeArticleAddViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HouseImageCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WUAlbumDelegate,WUImageBrowseViewDelegate,UIViewControllerPreviewingDelegate>


/** 标题的输入框 */
@property (nonatomic,weak) UITextField *titleText;

/** 闲置物品详情的描述 */
@property (nonatomic,weak) YYPlaceholderTextView *detailText;



/** 价格和物品交换的输入框 */
@property (nonatomic,weak) UIView *priceView;

/** 商品价格 */
@property (nonatomic,weak) UITextField *priceText;

/** 商品价格 */
@property (nonatomic,weak) UITextField *originPriceText;

/** 是否支持物品交换按钮 */
@property (nonatomic,weak) UIButton *exchangBtn;

//添加附件
/** 加载图片的输入框 */
@property (nonatomic,weak) UIView *photosView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray<SectionModel*> *dataArray;
@property(nonatomic,assign) NSInteger currentSection;       //当前操作的组
@property(nonatomic,strong) UIImage *plusImage;
@property (nonatomic,strong) SectionModel *s0;


@property (nonatomic,strong) NSMutableArray *repairImagesArray;// 报修图片数组



@end
NSString *const commImageViewID = @"HouseImageViewCellIdentifier";

@implementation FreeArticleAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"闲置物品添加";

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self creatRepairPictureView];

    //设置基本控件
    [self setupControls];
    
    //右上角的发布按钮
    [self setupRightBar];
}

-(void)setupRightBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
}

-(void)rightBarClick
{
    MJRefreshLog(@"发布");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"sessionId"] = SessionID;
    parameters[@"userId"] = UserID;
    parameters[@"price"] = _priceText.text;
    parameters[@"title"] = _titleText.text;
    parameters[@"srcPrice"] = _originPriceText.text; //原价
    parameters[@"change"] = @(self.exchangBtn.selected ? 1 : 0);         //0 不支持 1支持
    parameters[@"content"] = _detailText.text;  //物品描述

    ICLog_2(@"闲置物品：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@smart_community/save/update/upload/sellingThings",Smart_community_URL];
    
    ICLog_2(@"闲置物品接口：%@",urlString);
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        _repairImagesArray = [NSMutableArray arrayWithArray:[self getImagesWithSection:0]];
        
        if(_repairImagesArray && _repairImagesArray.count > 0) {
            for (id item in _repairImagesArray) {
                NSData *data;
                if([self isAsset:item]) {
                    data = [item dataWithCompressionQualityDefault];
                } else {
                    data = UIImageJPEGRepresentation(item, 1);
                }
                
                if (data != nil)
                {
                    if (data.length > 300 * 1024) {
                        UIImage *newImg = [UIImage imageWithData:data];
                        data = [UIImage reSizeImageData:newImg maxImageSize:420 maxSizeWithKB:300];
                    }
                    [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
                }
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ICLog_2(@"提交报修请求返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            ICLog_2(@"增加闲置物品请求成功：");
            
            [HUD showSuccessMessage:@"增加闲置物品请求成功"];
            
            [self clearTextAndImg];
            
            [_photosView removeFromSuperview];
            
            [self creatRepairPictureView];
            
        }
        else
        {
            [HUD showErrorMessage:@"提交报修失败"];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ICLog_2(@"提交报修请求失败：%@",error);
    }];

}



- (void)clearTextAndImg
{
    self.detailText.text = nil;
    self.priceText.text = nil;
    self.originPriceText.text = nil;
    self.titleText.text = nil;
    self.exchangBtn.selected = NO;
}

- (void)creatRepairPictureView
{
    // 闲置物品的view
    CGFloat bottomX = 17;
    CGFloat bottomY = 253 + 12;
    CGFloat bottomWidth = KWidth - 2 * bottomX;
    CGFloat bottomHeight = 200;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(bottomX,bottomY, bottomWidth, bottomHeight)];
    //    view.backgroundColor = [UIColor redColor];
    //   view.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    //   view.layer.borderWidth = 1.0;
    
    self.photosView = view;
    [self.view addSubview:self.photosView];
    [self createData];
    [self.photosView addSubview:self.collectionView];
}

- (void)setupControls
{
    //设置顶部的标题和物品详情
    //标题的输入框
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(16, 64 + 12, KWidth - 32, 35)];
    titleText.layer.cornerRadius = 5.0;
//    titleText.textColor = [UIColor grayColor];
    titleText.font = UIFontLarge;
    titleText.borderStyle = UITextBorderStyleNone;
    titleText.layer.masksToBounds = YES;
    titleText.layer.borderWidth = 1.0;
    titleText.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    titleText.placeholder = @"  输入标题";
    self.titleText = titleText;
    [self.view addSubview:titleText];
    
    //输入物品详情
    YYPlaceholderTextView *detailText = [[YYPlaceholderTextView alloc] initWithFrame:CGRectMake(16,64 + 59, KWidth - 32, 130)];
    detailText.layer.cornerRadius = 5.0;
    detailText.layer.borderWidth = 1.0;
    detailText.layer.masksToBounds = YES;
    detailText.placeholder = @"  输入物品详情";
    detailText.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    self.detailText = detailText;
    [self.view addSubview:detailText];

    //输入物品价格
    UIView *priceView = [[UIView alloc] initWithFrame:CGRectMake(16, 253 + 24 + 200, KWidth - 32, 123)] ;
//    priceView.backgroundColor = [UIColor orangeColor];
    self.priceView = priceView;
    [self.view addSubview:priceView];
    
    //设置输入价格
    UITextField *priceText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, priceView.width, 35)];
    priceText.layer.cornerRadius = 5.0;
    //    titleText.textColor = [UIColor grayColor];
    priceText.font = UIFontLarge;
    priceText.borderStyle = UITextBorderStyleNone;
    priceText.layer.masksToBounds = YES;
    priceText.layer.borderWidth = 1.0;
    priceText.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    priceText.placeholder = @" 输入物品价格";
    self.priceText = priceText;
    [priceView addSubview:priceText];
    
    
    //设置输入原价
    UITextField *originPriceText = [[UITextField alloc] initWithFrame:CGRectMake(0, 47, priceView.width, 35)];
    originPriceText.layer.cornerRadius = 5.0;
    //    titleText.textColor = [UIColor grayColor];
    originPriceText.font = UIFontLarge;
    originPriceText.borderStyle = UITextBorderStyleNone;
    originPriceText.layer.masksToBounds = YES;
    originPriceText.layer.borderWidth = 1.0;
    originPriceText.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    originPriceText.placeholder = @" 输入物品原价";
    self.originPriceText = originPriceText;
    [priceView addSubview:originPriceText];
    
    //是否支持物品交换
    UILabel *exchange = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(originPriceText.frame) + 17, 100, 16)];
    exchange.text = @" 支持物品交换";
    exchange.textColor = [UIColor grayColor];
    exchange.font = UIFontLarge;
//    exchange.backgroundColor = [UIColor orangeColor];
    [exchange sizeToFit];
    [priceView addSubview:exchange];
    
    //设置交换按钮
    UIButton *exchangBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(exchange.frame) , exchange.y, 90, 30)];
    exchangBtn.centerY = exchange.centerY;
    [exchangBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [exchangBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [exchangBtn addTarget:self action:@selector(exchangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.exchangBtn = exchangBtn;
    [priceView addSubview:exchangBtn];
}

//物品交换按钮的点击事件
-(void)exchangBtnClick:(UIButton *)button
{
    MJRefreshLog(@"交换");
    button.selected = !button.selected;

}


#pragma mark--添加附件
-(void)createData {
    
    _plusImage = [UIImage imageNamed:@"plus"];
    
    self.s0 = [SectionModel sectionModelWith:@"" cells:nil];
    self.s0.mutableCells = [NSMutableArray array];
    [self.s0.mutableCells addObject:_plusImage];
    _dataArray = @[self.s0];
}
#pragma 附件
- (UICollectionView *)collectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat width = _photosView.width / 3;
    layout.itemSize = CGSizeMake(width, width);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _photosView.width, _photosView.height ) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = YES;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [_collectionView registerClass:[HouseImageCell class] forCellWithReuseIdentifier:commImageViewID];
    
    if(SystemVersion >= 9.0) {
        UILongPressGestureRecognizer *collectionViewLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewLongPress:)];
        [_collectionView addGestureRecognizer:collectionViewLongPress];
        
        [self registerForPreviewingWithDelegate:self sourceView:_collectionView];
    }
    
    return _collectionView;
}
//重排图片
-(void)collectionViewLongPress:(UILongPressGestureRecognizer*)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *selectedIndexPath = [_collectionView indexPathForItemAtPoint:[gesture locationInView:_collectionView]];
            if(selectedIndexPath) {
                [_collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [_collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [_collectionView endInteractiveMovement];
        }
            break;
        default: {
            [_collectionView cancelInteractiveMovement];
        }
            break;
    }
}
#pragma -mark 3D-Touch peek

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:location];
    if(!indexPath || indexPath.section == NSNotFound || indexPath.row == NSNotFound) {
        return nil;
    }
    
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([row isEqual:_plusImage]) {
        return nil;
    }
    
    HouseImageCell *cell = (HouseImageCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    CGRect sourceRect = [cell convertRect:cell.imageView.frame toView:[previewingContext sourceView]];
    [previewingContext setSourceRect:sourceRect];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    UIImage *image;
    if([row isKindOfClass:[WUAlbumAsset class]]) {
        image = [row imageWithSize:bounds.size];
    } else if([row isKindOfClass:[UIImage class]]) {
        image = row;
    } else {
        return nil;
    }
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor clearColor];
    viewController.userInfo = indexPath;
    viewController.view.bounds = self.view.bounds;
    
    CGRect imageRect = [image rectAspectFitRectForSize:CGSizeMake(bounds.size.width - 60, bounds.size.height - 80)];
    imageRect.origin = CGPointMake(self.view.width/2-CGRectGetWidth(imageRect)/2, self.view.height/2-CGRectGetHeight(imageRect)/2 - 64);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
    imageView.image = image;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 10;
    
    [viewController.view addSubview:imageView];
    
    return viewController;
}
//pop
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    NSIndexPath *indexPath = (NSIndexPath*)[viewControllerToCommit userInfo];
    _currentSection = indexPath.section;
    NSArray *images = [self getImagesWithSection:indexPath.section];
    if(images) {
        WUImageBrowseView *bv = [[WUImageBrowseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        bv.images = images;
        bv.delegate = self;
        bv.currentPage = indexPath.row;
        [bv show:self.navigationController.view];
        //        [self setInteractivePopGestureRecognizerEnabled:NO];
    }
    
}
#pragma -mark collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    return s.mutableCells.count;
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([row isEqual:_plusImage]) {
        return NO;
    }
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [self swapData:sourceIndexPath toIndexPath:destinationIndexPath];
    
    SectionModel *s = _dataArray[destinationIndexPath.section];
    //如果目标被移动到最后一个项
    if(destinationIndexPath.row > 0 && destinationIndexPath.row == s.mutableCells.count - 1) {
        id item = s.mutableCells[s.mutableCells.count - 2];
        if([item isEqual:_plusImage]) {
            [self swapData:destinationIndexPath toIndexPath:sourceIndexPath];
            [_collectionView moveItemAtIndexPath:destinationIndexPath toIndexPath:sourceIndexPath];
        }
    }
}
/**
 *  移动数据源
 *
 *  @param sourceIndexPath      源
 *  @param destinationIndexPath 目的
 */
-(void)swapData:(NSIndexPath*)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    SectionModel *s = _dataArray[destinationIndexPath.section];
    SectionModel *sourceSection = _dataArray[sourceIndexPath.section];
    id sourceItem = sourceSection.mutableCells[sourceIndexPath.row];
    [sourceSection.mutableCells removeObject:sourceItem];
    [s.mutableCells insertObject:sourceItem atIndex:destinationIndexPath.row];
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HouseImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commImageViewID forIndexPath:indexPath];
    cell.delegate = self;
    
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([self isAsset:row]) {
        cell.imageView.image = nil;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.layer.borderWidth = 0;
        cell.showDelete = YES;
        WUAlbumAsset *asset = (WUAlbumAsset*)row;
        __weak typeof(cell) weakCell = cell;
        CGSize size = CGSizeMake(cell.width * 2, cell.height * 2);
        [asset requestImageWithSize:size complete:^(UIImage *image) {
            if(weakCell) {
                __strong typeof(weakCell) strongCell = weakCell;
                strongCell.imageView.image = image;
            }
        }];
    } else if([row isEqual:_plusImage]) {
        cell.imageView.image = row;
        cell.imageView.layer.borderWidth = 1;
        cell.imageView.contentMode = UIViewContentModeCenter;
        cell.showDelete = NO;
    } else if([row isKindOfClass:[UIImage class]]) {
        cell.imageView.image = row;
        cell.imageView.layer.borderWidth = 0;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.showDelete = YES;
    }
    
    return cell;
}

/**
 *  判断是否为相册资源类型
 */
-(BOOL)isAsset:(id)value {
    if([value isKindOfClass:[WUAlbumAsset class]]) {
        return YES;
    }
    return NO;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentSection = indexPath.section;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    
    if([row isEqual:_plusImage]) {
        [WUAlbum showPickerMenu:self delegate:self];
    } else {
        
        NSArray *images = [self getImagesWithSection:_currentSection];
        if(images) {
            WUImageBrowseView *bv = [[WUImageBrowseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            bv.images = images;
            bv.delegate = self;
            bv.currentPage = indexPath.row;
            CGRect startFrame = [cell convertRect:cell.bounds toView:self.navigationController.view];
            
            UIImage *image;
            if([self isAsset:row]) {
                image = [row imageWithSize:[[UIScreen mainScreen] bounds].size];
            } else if([row isKindOfClass:[UIImage class]]) {
                image = row;
            } else if([row isKindOfClass:[NSString class]]) {
                //http 请求
            }
            
            [bv show:self.navigationController.view startFrame:startFrame foregroundImage:image];
            //            [self setInteractivePopGestureRecognizerEnabled:NO];
        }
    }
}

/**
 *  获取选择的图片
 */
-(NSArray*)getImagesWithSection:(NSInteger)index {
    SectionModel *s = _dataArray[index];
    if(s.mutableCells.count == 0) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:s.mutableCells];
    if([s.mutableCells.lastObject isEqual:_plusImage]) {
        [array removeLastObject];
    }
    
    return [NSArray arrayWithArray:array];
}

/**
 *  获取所有图片
 */
-(NSArray*)getAllImages {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _dataArray.count; i++) {
        NSArray *images = [self getImagesWithSection:i];
        if(images || images.count > 0) {
            [array addObject:images];
        }
    }
    
    return [NSArray arrayWithArray:array];
}

#pragma -mark imageBrowseView delegate

-(CGRect)imageBrowseView:(WUImageBrowseView *)view willCloseAtIndex:(NSInteger)index {
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:_currentSection]];
    CGRect endFrame = [cell convertRect:cell.bounds toView:self.navigationController.view];
    //    [self setInteractivePopGestureRecognizerEnabled:YES];
    return endFrame;
}

#pragma -mark HouseImageCell delegate

-(void)houseImageCellWillDeleteCell:(HouseImageCell *)cell {
    cell.imageView.image = nil;
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    SectionModel *s = _dataArray[indexPath.section];
    [s.mutableCells removeObjectAtIndex:indexPath.row];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}

//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info[UIImagePickerControllerOriginalImage] fixOrientation];
    
    WUAlbumAsset *asset = [WUAlbum savePhotoWithImage:image];
    if(asset) {
        [self insertDataArray:@[asset] atSection:_currentSection];
    } else {
        //压缩图片
        NSData *data = [WUAlbumAsset compressionWithImage:image];
        UIImage *image = [UIImage imageWithData:data];
        [self insertDataArray:@[image] atSection:_currentSection];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  完成相册选择
 *
 *  @param assets 图片资源
 */
-(void)albumFinishedSelected:(NSArray<WUAlbumAsset *> *)assets {
    [self insertDataArray:assets atSection:_currentSection];
}

/**
 *  插入到数据集
 */
-(void)insertDataArray:(NSArray*)array atSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    [s.mutableCells insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:(NSRange){s.mutableCells.count - 1,array.count}]];
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
