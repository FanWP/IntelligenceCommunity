//
//  neiborhoodSendAppointVC.m
//  IntelligenceCommunity
//
//  Created by youyousiji on 16/12/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "neiborhoodSendAppointVC.h"
#import "YYPlaceholderTextView.h"
#import "UWDatePickerView.h"
#import "DateTimePickerView.h"
//添加附件
#import "SectionModel.h"
#import "HouseImageCell.h"
#import "WUAlbum.h"
#import "UIImage+Aspect.h"
#import "UIImage+FixOrientation.h"

@interface neiborhoodSendAppointVC ()<UITextFieldDelegate,UWDatePickerViewDelegate,DateTimePickerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HouseImageCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WUAlbumDelegate,WUImageBrowseViewDelegate,UIViewControllerPreviewingDelegate>

/** 标题的输入框 */
@property (nonatomic,weak) UITextField *titleText;
/** 活动详情和的输入框 */
@property (nonatomic,weak) YYPlaceholderTextView *contentTextView;
/** 活动地点 */
@property (nonatomic,weak) UITextField *addressText;
/** 活动日期 */
@property (nonatomic,weak) UITextField *dateText;
/** 活动时间 */
@property (nonatomic,weak) UITextField *timeText;

/** 日期选择器 */
@property (nonatomic,weak) UWDatePickerView *dateView;
/** 时间选择器 */
@property (nonatomic,weak) DateTimePickerView *dateTimeView;



//添加附件
/** 加载图片的输入框 */
@property (nonatomic,weak) UIView *photosView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray<SectionModel*> *dataArray;
@property(nonatomic,assign) NSInteger currentSection;       //当前操作的组
@property(nonatomic,strong) UIImage *plusImage;
@property (nonatomic,strong) SectionModel *s0;

@property (nonatomic,strong) NSMutableArray *repairImagesArray;// 发布动态的图片数组


@end

@implementation neiborhoodSendAppointVC

    NSString *const commImageViewdID = @"HouseImageViewCellIdentifieruyt";

- (void)viewDidLoad {

    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"约活动";
    
    //设置基本控件
    [self setupControls];

    [self creatRepairPictureView];
    
    [self setupRightBar];
    
}

- (void)setupRightBar
{
   UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [sendBtn addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTitle:@"发布" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
}


-(void)rightBarClick
{
    MJRefreshLog(@"发布");
    //判断时间
        NSString *time = nil;
    if (_dateText.text.length > 0 && _timeText.text.length > 0) {//时间和日期都在
        time = [NSString stringWithFormat:@"%@ %@:00",_dateText.text,_timeText.text];
    }else{
        [HUD showErrorMessage:@"数据输入不全，请核对！"];
        return;
    }
    
    //判断内容
    if (!(_contentTextView.text.length > 0 && _titleText.text.length > 0 && _addressText.text.length > 0)) {
        [HUD showErrorMessage:@"数据输入不全，请核对！"];
        return;
    }
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"sessionId"] = SessionID;
    parameters[@"userId"] = UserID;
    parameters[@"title"] = _titleText.text;
    parameters[@"actionTime"] = time;
    
    parameters[@"address"] = _addressText.text;
    parameters[@"content"] = _contentTextView.text;
    parameters[@"type"] = @"1";
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@smart_community/save/update/upload/friendsCircle",Smart_community_URL];
    
    ICLog_2(@"约发布：%@ URL---:%@",parameters,urlString);

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
                
                if (data != nil){
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
        
        ICLog_2(@"约请求返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            ICLog_2(@"约发布请求成功：");
            
            [HUD showSuccessMessage:@"约发布请求成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            

            //清空数据
            
            [_photosView removeFromSuperview];
            
            [self creatRepairPictureView];
            
        }
        else
        {
            [HUD showErrorMessage:@"约发布失败"];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ICLog_2(@"约发布请求失败：%@",error);
    }];

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark======== 初始化输入控件================
- (void)setupControls
{
    //标题
    UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(16, 76 - 64, KWidth - 32, 35)];
    titleText.placeholder = @" 输入标题";
//    titleText.backgroundColor = [UIColor redColor];
    titleText.layer.borderColor = graryColor174.CGColor;
    titleText.layer.cornerRadius = 5;
    titleText.layer.masksToBounds = YES;
    titleText.layer.borderWidth = 1;
    self.titleText = titleText;
    [self.view addSubview:titleText];
    
    //活动详情输入框
    YYPlaceholderTextView *view = [[YYPlaceholderTextView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleText.frame) + 12, KWidth - 32, 130)];
    view.backgroundColor = [UIColor whiteColor];
    view.placeholder = @"说点什么...";
    view.layer.borderColor = graryColor174.CGColor;
    view.layer.borderWidth = 1;
    view.placeholderColor = graryColor174;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    self.contentTextView = view;
    [self.view addSubview:view];
    
    
    //活动地点
    UITextField *addressText = [[UITextField alloc] initWithFrame:CGRectMake(16, 430 - 64, KWidth - 32, 35)];
    addressText.placeholder = @" 输入活动地点";
    //    titleText.backgroundColor = [UIColor redColor];
    addressText.layer.borderColor = graryColor174.CGColor;
    addressText.layer.cornerRadius = 5;
    addressText.layer.masksToBounds = YES;
    addressText.layer.borderWidth = 1;
    self.addressText = addressText;
    [self.view addSubview:addressText];
    
    
    //选择日期
    UITextField *dateText = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(addressText.frame) + 12, KWidth - 32, 35)];
    dateText.placeholder = @" 选择日期";
    //    titleText.backgroundColor = [UIColor redColor];
    dateText.layer.borderColor = graryColor174.CGColor;
    dateText.layer.cornerRadius = 5;
    dateText.layer.masksToBounds = YES;
    dateText.layer.borderWidth = 1;
    dateText.delegate = self;
    self.dateText = dateText;
    [self.view addSubview:dateText];
    
    //选择时间
    UITextField *timeText = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(dateText.frame) + 12, KWidth - 32, 35)];
    timeText.placeholder = @" 选择时间";
    //    titleText.backgroundColor = [UIColor redColor];
    timeText.layer.borderColor = graryColor174.CGColor;
    timeText.layer.cornerRadius = 5;
    timeText.layer.masksToBounds = YES;
    timeText.layer.borderWidth = 1;
    timeText.delegate = self;
    self.timeText = timeText;
    [self.view addSubview:timeText];

}



- (void)creatRepairPictureView
{
    // 闲置物品的view
    CGFloat bottomX = 17;
    CGFloat bottomY = CGRectGetMaxY(_contentTextView.frame) + 10;
    CGFloat bottomWidth = KWidth - 2 * bottomX;
    CGFloat bottomHeight = 150;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(bottomX,bottomY, bottomWidth, bottomHeight)];
    self.photosView = view;
    [self.view addSubview:self.photosView];
    [self createData];
    [self.photosView addSubview:self.collectionView];
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
    
    [_collectionView registerClass:[HouseImageCell class] forCellWithReuseIdentifier:commImageViewdID];
    
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
    HouseImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commImageViewdID forIndexPath:indexPath];
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




#pragma mark===== textField的代理事件====
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if (textField.tag == 1000) {
//        
//        [self setupdateView];
//        return NO;
//        
//    }else{
//        return YES;
//    }
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.dateText]) {//日期
        [self setupdateView];
    }else if ([textField isEqual:self.timeText]){//时间
        [self setupdateTimeView];
    }

}

-(void)setupdateView
{
    [self.dateView removeFromSuperview];
    UWDatePickerView *dateView = [UWDatePickerView instanceDatePickerView];
    dateView.frame = CGRectMake(0, KHeight - 400 - 64, KWidth, 400);
    [self.view addSubview:dateView];
    self.dateView = dateView;
    dateView.delegate = self;
    [self.view endEditing:YES];
}

-(void)setupdateTimeView
{
    [self.dateTimeView removeFromSuperview];
    DateTimePickerView *dateView = [DateTimePickerView initWithDateTimePickerView];
    dateView.frame = CGRectMake(0, KHeight - 400 - 64, KWidth, 400);
    [self.view addSubview:dateView];
    self.dateTimeView = dateView;
    dateView.delegate = self;
    [self.view endEditing:YES];
}

//日期选择器
- (void)getSelectDate:(NSString *)date type:(DateType)type button:(UIButton *)button{
    
    NSLog(@"时间 : %@",date);
    
    if (button.tag != 1) {
        return;
    }
    
    
    switch (type) {
        case DateTypeOfStart:
            // TODO 日期确定选择
            self.dateText.text = [NSString stringWithFormat:@"%@",date];
            break;
            
        case DateTypeOfEnd:
            // TODO 日期取消选择
            break;
        default:
            break;
    }
}

//时间选择器
-(void)getSelectDateTime:(NSString *)date type:(DateTimeType)type button:(UIButton *)button
{
    NSLog(@"时间 : %@",date);
    
    if (button.tag != 1) {
        return;
    }
    
    switch (type) {
        case DateTypeOfStart:
            // TODO 日期确定选择
            self.timeText.text = [NSString stringWithFormat:@"%@",date];
            break;
            
        case DateTypeOfEnd:
            // TODO 日期取消选择
            break;
        default:
            break;
    }


}





@end
