
//
//  SSShopAddAdressVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopAddAdressVC.h"
#import "ChinaPlckerView.h"
#import "SSShopViewModel.h"


@interface SSShopAddAdressVC ()<UITextFieldDelegate>

@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, strong) SSShopViewModel *viewModel;


@end

@implementation SSShopAddAdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name_textfield.delegate = self;
    self.phone_textfield.delegate = self;
    self.location_textfield.delegate = self;
    self.detail_textfield.delegate = self;
    self.type = 0;
    
    self.view.backgroundColor = kColor(@"ffffff");
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.delete_button.layer.cornerRadius = 5;
    if (self.vcType == SSShopAddAdressVCTypeEdit) {
        self.delete_button.hidden = NO;
        self.name_textfield.text = self.locationModel.name;
        self.phone_textfield.text = self.locationModel.mobile;
        self.location_textfield.text = [NSString stringWithFormat:@"%@ %@ %@",self.locationModel.province,self.locationModel.city,self.locationModel.area];
        self.detail_textfield.text = self.locationModel.address;
        if (self.locationModel.isDefault) {
            [self.default_button setBackgroundImage:[UIImage imageNamed:@"shoppingCar_select"] forState:UIControlStateNormal];
            self.type = 1;
        }else{
            [self.default_button setBackgroundImage:[UIImage imageNamed:@"shoppingCar_unselect"] forState:UIControlStateNormal];
            self.type = 0;
        }
        
        self.province = self.locationModel.province;
        self.city = self.locationModel.city;
        self.area = self.locationModel.area;
        
    }else if(self.vcType == SSShopAddAdressVCTypeAdd)
    {
        self.delete_button.hidden = YES;
    }
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newbacks)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];
}

- (void)newbacks
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClicked
{
    if(![self.phone_textfield.text validatePhone])
    {
        [ProgressHUD showError:@"手机号不合法"];
        return;
    }else if (self.name_textfield.text.length < 1)
    {
        [ProgressHUD showError:@"请填写用户姓名"];
        return;
    }
    
    [self.viewModel saveLocationWithID:self.locationModel.ID name:self.name_textfield.text mobile:self.phone_textfield.text provinceId:self.province cityId:self.city areaId:self.area address:self.detail_textfield.text isdefault:self.type callback:^(id  _Nonnull object) {
        [ProgressHUD showSuccess:@"保存成功"];
        if (self.block) {
            self.block();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)chinaPlckerViewDelegateChinaModel:(ChinaArea *)chinaModel{
    self.location_textfield.text = [NSString stringWithFormat:@"%@ %@ %@",chinaModel.provinceModel.NAME,chinaModel.cityModel.NAME,chinaModel.areaModel.NAME];
    self.province = chinaModel.provinceModel.NAME;
    self.city = chinaModel.cityModel.NAME;
    self.area = chinaModel.areaModel.NAME;
}

- (IBAction)deleteButtonTapAction:(UIButton *)sender {
    [self.viewModel delteLocationWithID:self.locationModel.ID callback:^(id  _Nonnull object) {
        self.block();
        [self.navigationController popViewControllerAnimated:YES];
        [ProgressHUD showSuccess:@"删除成功"];
    }];
}
- (IBAction)selectCityButtonTapAction:(UIButton *)sender {
    [ChinaPlckerView customChinaPicker:self superView:self.view];
}

- (IBAction)defaultButtonTapAction:(UIButton *)sender {
    if (self.type == 1) {
        self.type = 0;
        [self.default_button setBackgroundImage:[UIImage imageNamed:@"shoppingCar_unselect"] forState:UIControlStateNormal];
    }else{
        self.type = 1;
        [self.default_button setBackgroundImage:[UIImage imageNamed:@"shoppingCar_select"] forState:UIControlStateNormal];
    }
}

- (SSShopViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopViewModel alloc]init];
    }
    return _viewModel;
}

@end
