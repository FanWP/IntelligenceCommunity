//
//  SettingTableVC.m
//  IntelligenceCommunity
//
//  Created by Beibei on 16/12/20.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "SettingTableVC.h"

#import "SignatureVC.h"// 签名
#import "ChangePWDVC.h"// 修改密码

#import "SettingHeaderPictureCell.h"// 设置头像的cell
#import "SettingCell.h"// 设置的cell

@interface SettingTableVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NSArray *leftTitleArray;// 左边设置的数字
@property (nonatomic,strong) UIView *exitView;
@property (nonatomic,strong) UIButton *exitButton;// 退出
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) SettingHeaderPictureCell *settingHeaderPictureCell;

@property (nonatomic,strong) UIImage *image;

@end

@implementation SettingTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    _leftTitleArray = @[@"名称",@"性别",@"生日",@"签名"];
    
    [self creatExitButton];
    
    [self rightItemSave];
}


- (void)rightItemSave
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(settingSaveAction)];
}
- (void)settingSaveAction
{
//    upload/update/userinfo
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"sessionId"] = SessionID;
//    parameters[@"account"] = @"";
    parameters[@"username"] = @"蓓蓓";
    parameters[@"id"] = @"1";
//    parameters[@"nickname"] = @"";
    parameters[@"type"] = @"0";
    parameters[@"sex"] = @"1";
//    parameters[@"address"] = @"";
//    parameters[@"email"] = @"";
//    parameters[@"identity"] = @"";
    parameters[@"referee"] = @"123";
//    parameters[@"headimage"] = @"";
//    parameters[@"description"] = @"234567876543";
    
    ICLog_2(@"编辑资料参数：%@",parameters);
    
    NSString *urlString = [NSString stringWithFormat:@"%@smart_community/upload/update/userinfo",Smart_community_URL];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
//        NSData *data = UIImageJPEGRepresentation(self.settingHeaderPictureCell.imageView.image, 0.5);
//        
//        if (data != nil)
//        {
//            [formData appendPartWithFileData:data name:@"headimage" fileName:@"img.jpg" mimeType:@"image/jpeg"];
//        }

        NSData *data = UIImageJPEGRepresentation(_image, 0.5);
        
        if (data != nil)
        {
            [formData appendPartWithFileData:data name:@"headimage" fileName:@"img.jpg" mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        ICLog_2(@"编辑资料返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            [HUD showSuccessMessage:@"编辑资料成功"];
        }
        else
        {
            [HUD showErrorMessage:@"编辑资料失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [HUD showErrorMessage:@"编辑资料失败"];
        
        ICLog_2(@"编辑资料失败：%@",error);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return _leftTitleArray.count;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 70;
    }
    else if (indexPath.section == 1)
    {
        return 44;
    }
    else
    {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
    {
        static NSString *identifier = @"cell";
        
        self.settingHeaderPictureCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (self.settingHeaderPictureCell == nil)
        {
            self.settingHeaderPictureCell = [[SettingHeaderPictureCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        
        self.settingHeaderPictureCell.settingHeaderLabel.text = @"头像";
        
        self.settingHeaderPictureCell.settingHeaderImageView.image = _image;
        
        return self.settingHeaderPictureCell;
    }
    else if (indexPath.section == 1)
    {
        static NSString *identifier1 = @"cell1";
        
        SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (cell == nil)
        {
            cell = [[SettingCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier1];
        }
        
        if (indexPath.row == 3)
        {
            cell.settingContentTF.hidden = YES;
        }
        
        cell.settingTitleLabel.text = _leftTitleArray[indexPath.row];
        
        return cell;
    }
    else
    {
        
        static NSString *identifier2 = @"cell2";
        
        SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        
        if (cell == nil)
        {
            cell = [[SettingCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier2];
        }
        
        cell.settingContentTF.enabled = NO;
        
        cell.settingTitleLabel.text = @"修改密码";

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相册中选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self getPhotoLibraryImage];
        }];
        
        UIAlertAction *photoLibiaryAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self getCameraImage];
        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        
        [alert addAction:cameraAction];
        [alert addAction:photoLibiaryAction];
        [alert addAction:cancleAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 3)
        {
            SignatureVC *signatureVC = [[SignatureVC alloc] init];
            [self.navigationController pushViewController:signatureVC animated:YES];
        }
    }
    else
    {
        ChangePWDVC *changePWDVC = [[ChangePWDVC alloc] init];
        [self.navigationController pushViewController:changePWDVC animated:YES];
    }
}

// 获取照相机图片
- (void)getCameraImage
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    [self.imagePicker setSourceType:(UIImagePickerControllerSourceTypeCamera)];
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
// 获取相册图片
- (void)getPhotoLibraryImage
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    [self.imagePicker setSourceType:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)];
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}
// 从照片中获取调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    self.settingHeaderPictureCell.settingHeaderImageView.image = image;
    _image = image;
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = nil;
    if (error)
    {
        message = @"失败";
    }
    else
    {
        message = @"成功";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:action1];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 退出
- (void)creatExitButton
{
    _exitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    _exitView.backgroundColor = [UIColor whiteColor];
    
    _exitButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _exitButton.frame = CGRectMake(0, 0, _exitView.width, _exitView.height);
    _exitButton.backgroundColor = [UIColor whiteColor];
    _exitButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_exitButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [_exitButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_exitView addSubview:_exitButton];
    
    self.tableView.tableFooterView = _exitView;
    
}

@end
















