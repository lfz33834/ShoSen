//
//  SSCirclePublishVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/24.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCirclePublishVC.h"
//#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
#import "SSCircleViewModel.h"
#import "HXDatePhotoToolManager.h"

@interface SSCirclePublishVC ()<HXPhotoViewDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;

@property (nonatomic,strong) SSCircleViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, copy) NSString *photoArrayString;
@property (nonatomic, copy) NSString *locationString;

@property (nonatomic, strong) UIButton *publish_button;

@end

@implementation SSCirclePublishVC
-  (SSCircleViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSCircleViewModel alloc]init];
    }
    return _viewModel;
}

- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.openCamera = YES;
        _manager.configuration.lookLivePhoto = NO;
        _manager.configuration.photoMaxNum = 9;
         _manager.configuration.maxNum = 9;
        _manager.configuration.clarityScale = 7;
         _manager.configuration.saveSystemAblum = NO;
         _manager.configuration.showDateSectionHeader = NO;
        _manager.configuration.cameraCellShowPreview = YES;
        _manager.configuration.selectTogether = NO;
        
//        _manager.configuration.downloadICloudAsset = YES;
        _manager.configuration.filtrationICloudAsset = NO;
        __weak typeof(self) weakSelf = self;
         _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
               //设置最长摄像时间
             imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"动态"];
    
    UIButton * rightBtn = [UIButton itemWithFream:CGRectMake(0.0, 0.0, 50.0f, 30.0f) withbackGroundColor:[UIColor clearColor] withTitle:@"发布" withTitleColor:kColor(@"999999") withTitleSize:15 withIsBold:NO];
    rightBtn.enabled = NO;
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.publish_button = rightBtn;
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    CGFloat width = self.view.frame.size.width;
    HXPhotoView *photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(15, 0, width - 30, kheight) WithManager:self.manager];
    photoView.delegate = self;
    photoView.outerCamera = YES;
    photoView.block = ^(NSString *location) {
        self.locationString = location;
    };
    photoView.contentBlock = ^(NSString *content) {
        [self changeStatusWithContent:content images:nil];
    };
    photoView.backgroundColor = [UIColor whiteColor];
    self.photoView = photoView;
    [self.view addSubview:photoView];
}

- (void)changeStatusWithContent:(NSString*)content images:(NSString *)images
{
    if (content && content.length > 0) {
        [self.publish_button setTitleColor:kColor(@"ffffff") forState:UIControlStateNormal];
        self.publish_button.enabled = YES;
    }else if (images && images.length > 0)
    {
        [self.publish_button setTitleColor:kColor(@"ffffff") forState:UIControlStateNormal];
        self.publish_button.enabled = YES;
    }else{
        [self.publish_button setTitleColor:kColor(@"999999") forState:UIControlStateNormal];
        self.publish_button.enabled = NO;
    }
}

- (void)rightBtnAction
{
    WEAKSELF
    [self.viewModel addMessageWithContent:self.photoView.headerview.content_textview.text location:self.locationString picture:self.photoArrayString callBack:^(id obj) {
        NSLog(@"%@",obj);
        [ProgressHUD showSuccess:@"发布成功"];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"REFRESHCIRCLE" object:nil];
    }];
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    NSSLog(@"所有:%@ - 照片:%@ - 视频:%@",allList,photos,videos);
    if (photos.count > 0) {
        [FZUploadImageTool uploadImageWithPath:UserCircleUploadImageViewArray photos:photos params:nil success:^(id Json) {
            self.photoArrayString = Json[@"data"][@"url"];
            [self changeStatusWithContent:nil images:self.photoArrayString];
            [ProgressHUD showSuccess:@"上传成功"];
        } failure:^{
        }];
    }
}

- (void)photoViewUpdateFrame:(CGRect)frame WithView:(UIView *)view
{
    NSLog(@"%@",NSStringFromCGRect(frame));
}

- (NSMutableArray *)photoArray
{
    if (_photoArray == nil) {
        _photoArray = [[NSMutableArray alloc]init];
    }
    return _photoArray;
}

@end
