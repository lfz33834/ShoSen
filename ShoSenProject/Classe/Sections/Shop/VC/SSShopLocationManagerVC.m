//
//  SSShopLocationManagerVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopLocationManagerVC.h"
#import "SSShopViewModel.h"
#import "SSShopManagerCell.h"
#import "SSLocationModel.h"
#import "SSShopAddAdressVC.h"

@interface SSShopLocationManagerVC ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) UITableView      *orderListTable;
@property (nonatomic, strong) SSShopViewModel *viewModel;
@property (nonatomic, strong) UIButton *bottomButton;

@end

@implementation SSShopLocationManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self setTitle:@"地址管理"];
    [self.view addSubview:self.orderListTable];
    [self.view addSubview:self.bottomButton];
    [self feltData];
    
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

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSShopManagerCell *cell = [SSShopManagerCell cellWithTableView:tableView];
    SSLocationModel *model = self.data_array[indexPath.row];
    [cell initCellWithModel:model];
    cell.block = ^{
        SSShopAddAdressVC *addAddressVC = [[SSShopAddAdressVC alloc]init];
        addAddressVC.locationModel = model;
        addAddressVC.vcType = SSShopAddAdressVCTypeEdit;
        addAddressVC.block = ^{
            [self feltData];
        };
        [self.navigationController pushViewController:addAddressVC animated:YES];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data_array.count;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSLocationModel *model = self.data_array[indexPath.row];

    if (self.block) {
        self.block(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"mine_order_null"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无地址";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (void)feltData
{
    [self.viewModel locationListCallback:^(id  _Nonnull object) {
        self.data_array = [SSLocationModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        [self.orderListTable reloadData];
    }];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - kTopHeight - 64) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.rowHeight = 80;
        _orderListTable.emptyDataSetSource = self;
        _orderListTable.emptyDataSetDelegate = self;
        _orderListTable.backgroundColor = kColor(@"f8f8f8");
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (UIButton *)bottomButton
{
    if (_bottomButton == nil) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"添加新地址" forState:UIControlStateNormal];
        [_bottomButton setBackgroundImage:[UIImage imageNamed:@"shop_detail_buy_bg"] forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(addAddressButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _bottomButton.frame = CGRectMake(0, kheight - kTopHeight - 55, kwidth, 55);
    }
    return _bottomButton;
}

- (void)addAddressButtonTapAction
{
    SSShopAddAdressVC *addAddressVC = [[SSShopAddAdressVC alloc]init];
    addAddressVC.vcType = SSShopAddAdressVCTypeAdd;
    addAddressVC.block = ^{
        [self feltData];
    };
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

- (SSShopViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopViewModel alloc]init];
    }
    return _viewModel;
}

- (NSMutableArray *)data_array
{
    if (_data_array == nil) {
        _data_array = [[NSMutableArray alloc]init];
    }
    return _data_array;
}

@end
