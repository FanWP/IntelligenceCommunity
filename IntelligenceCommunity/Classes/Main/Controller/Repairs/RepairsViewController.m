//
//  RepairsViewController.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "RepairsViewController.h"

#import "RepairStatusTableVC.h"// 报修状态

#import "UIView+MyExtension.h"
#import "Common.h"
#import "UIViewController+Default.h"
//添加附件
#import "SectionModel.h"
#import "HouseImageCell.h"
#import "WUAlbum.h"
#import "UIImage+Aspect.h"
#import "UIImage+FixOrientation.h"

NSString *const commImageViewCellIdentifier = @"HouseImageViewCellIdentifier";


@interface RepairsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HouseImageCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WUAlbumDelegate,WUImageBrowseViewDelegate,UIViewControllerPreviewingDelegate>

@property (nonatomic,strong) UILabel *householdInfoLabel;// 住户信息
@property (nonatomic,strong) UILabel *repairContentLabel;// 报修内容描述
@property (nonatomic,strong) YYTextView *repairContentTextView;// 输入报修内容
@property (nonatomic,strong) UILabel *attachmentLabel;// 附件
@property (nonatomic,strong) UITextField *repairPictureBottomTF;// 图片附件底部的框
@property (nonatomic,strong) UIView *repairPictureView;// 报修图片的view
@property (nonatomic,strong) UIButton *handButton;// 提交
@property (nonatomic,strong) UILabel *propertyTelNumLabel;// 物业电话

//添加附件
@property (strong, nonatomic) UIView *bottomView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray<SectionModel*> *dataArray;
@property(nonatomic,assign) NSInteger currentSection;       //当前操作的组
@property(nonatomic,strong) UIImage *plusImage;
@property (nonatomic,strong) SectionModel *s0;

@property (nonatomic,strong) NSMutableArray *repairImagesArray;// 报修图片数组


@end

@implementation RepairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultViewStyle];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"报修";
    
    [self initializeComponent];// 初始化
    
    [self rightItemRepairStatusList];// 报修状态
    
}



// 进入报修状态的按钮
- (void)rightItemRepairStatusList
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"News"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(repairStatusList)];
}



// 进入报修状态的点击事件
- (void)repairStatusList
{
    RepairStatusTableVC *repairStatusTableVC = [[RepairStatusTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    [self.navigationController pushViewController:repairStatusTableVC animated:YES];
}



// 初始化
- (void)initializeComponent
{
    // 住户信息
    _householdInfoLabel = [[UILabel alloc] init];
    //    _householdInfoLabel.text = [NSString stringWithFormat:@"住户信息：%@",];
    _householdInfoLabel.text = @"住户信息：龙湖水晶郦城1号楼2011室";
    _householdInfoLabel.font = UIFont15;
    _householdInfoLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_householdInfoLabel];
    [_householdInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16 + 64);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
    }];
    
    
    
    // 报修内容描述
    _repairContentLabel = [[UILabel alloc] init];
    _repairContentLabel.text = @"报修内容描述";
    _repairContentLabel.font = UIFont15;
    [self.view addSubview:_repairContentLabel];
    [_repairContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_householdInfoLabel.mas_bottom).offset(16);
        make.left.equalTo(_householdInfoLabel.mas_left);
        make.right.equalTo(_householdInfoLabel.mas_right);
        make.height.equalTo(_householdInfoLabel.mas_height);
    }];
    
    
    
    // 输入报修内容
    _repairContentTextView = [[YYTextView alloc] init];
    _repairContentTextView.placeholder = @"   请描述报修内容...";
    _repairContentTextView.font = UIFontSmall;
    _repairContentTextView.layer.cornerRadius = 5.0;
    _repairContentTextView.layer.borderWidth = 1.0;
    _repairContentTextView.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    [self.view addSubview:_repairContentTextView];
    [_repairContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_repairContentLabel.mas_left);
        make.top.equalTo(_repairContentLabel.mas_bottom).offset(13);
        make.right.equalTo(_repairContentLabel.mas_right);
        make.height.mas_offset(151);
    }];
    
    
    
    // 附件
    _attachmentLabel = [[UILabel alloc] init];
    _attachmentLabel.text = @"附件";
    _attachmentLabel.font = UIFont15;
    [self.view addSubview:_attachmentLabel];
    [_attachmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_householdInfoLabel.mas_left);
        make.top.equalTo(_repairContentTextView.mas_bottom).offset(16);
        make.right.equalTo(_attachmentLabel.mas_right);
        make.height.mas_offset(30);
    }];
    
    
    
    // 报修图片底部的框
    _repairPictureBottomTF = [[UITextField alloc] init];
    _repairPictureBottomTF.userInteractionEnabled = NO;
    _repairPictureBottomTF.borderStyle = 3;
    _repairPictureBottomTF.backgroundColor = [UIColor whiteColor];
    _repairPictureBottomTF.layer.cornerRadius = 5.0;
    [self.view addSubview:_repairPictureBottomTF];
    [_repairPictureBottomTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_householdInfoLabel.mas_left);
        make.top.equalTo(_attachmentLabel.mas_bottom).offset(13);
        make.right.equalTo(_householdInfoLabel.mas_right);
        make.height.mas_offset(202);
    }];
    
    
    
    // 报修图片的view
    CGFloat bottomX = 17;
    CGFloat bottomY = 380;
    CGFloat bottomWidth = KWidth - 2 * bottomX;
    CGFloat bottomHeight = 200;
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(bottomX,bottomY, bottomWidth, bottomHeight)];
    [self.view addSubview:_bottomView];
    [self createData];
    [self.bottomView addSubview:self.collectionView];

//    _bottomView = [[UIView alloc] init];
//    _bottomView.userInteractionEnabled = YES;
//    _bottomView.backgroundColor = [UIColor redColor];
//    [self createData];
//    [_repairPictureBottomTF addSubview:_bottomView];
//    [_bottomView addSubview:_collectionView];
//    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_repairPictureBottomTF.mas_left).offset(6);
//        make.top.equalTo(_repairPictureBottomTF.mas_top).offset(3);
//        make.right.equalTo(_repairPictureBottomTF.mas_right).offset(-6);
//        make.bottom.equalTo(_repairPictureBottomTF.mas_bottom).offset(-3);
//    }];
    
    
    
    // 提交
    _handButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _handButton.backgroundColor = HexColor(0x04c5a1);
    [_handButton setTitle:@"提交" forState:(UIControlStateNormal)];
    _handButton.layer.cornerRadius = 48 / 2;
    [self.view addSubview:_handButton];
    [_handButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(21);
        make.top.equalTo(_repairPictureBottomTF.mas_bottom).offset(7);
        make.right.mas_offset(-21);
        make.height.mas_offset(43.5);
    }];
    
    
    
    // 物业电话
    _propertyTelNumLabel = [[UILabel alloc] init];
    _propertyTelNumLabel.text = @"物业电话：187-8949-4209";
//    _propertyTelNumLabel.text = [NSString stringWithFormat:@"物业电话：%@",];
    _propertyTelNumLabel.backgroundColor = HexColor(0xeeeeee);
    _propertyTelNumLabel.textAlignment = NSTextAlignmentCenter;
    _propertyTelNumLabel.font = UIFontNormal;
    [self.view addSubview:_propertyTelNumLabel];
    [_propertyTelNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.height.mas_offset(30);
    }];
    
    
    
    // 添加提交的点击事件
    [_handButton addTarget:self action:@selector(repairHandAction) forControlEvents:(UIControlEventTouchUpInside)];
}



- (void)repairHandAction
{
    [self dataHandRepair];// 提交报修
}



- (void)dataHandRepair
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"description"] = _repairContentTextView.text;
    parameters[@"sessionId"] = @"sessionId";
    parameters[@"userId"] = @"1";
    
    ICLog_2(@"提交报修参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@pro_api/save/update/upload/repair",Smart_community_URL];
    
    ICLog_2(@"提交报修接口：%@",urlString);
    
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
            ICLog_2(@"提交报修请求成功：");
        }
        else
        {
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ICLog_2(@"提交报修请求失败：%@",error);
    }];
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
    CGFloat width = _bottomView.width / 3;
    layout.itemSize = CGSizeMake(width, width);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _bottomView.width, _bottomView.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = YES;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    
    [_collectionView registerClass:[HouseImageCell class] forCellWithReuseIdentifier:commImageViewCellIdentifier];
    
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
    HouseImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commImageViewCellIdentifier forIndexPath:indexPath];
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
