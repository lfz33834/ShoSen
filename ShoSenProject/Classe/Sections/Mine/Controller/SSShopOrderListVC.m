//
//  SSShopOrderListVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderListVC.h"
#import "SSShopOrderListCell.h"
#import "SSMineShopOrderDetailVC.h"
#import "SSShopOrderListModel.h"
#import "SSShopOrderListViewModel.h"
#import "KDCShopVC.h"
#import "SSPayOrderVC.h"
#import "SSShopOrderDetailCancelView.h"
#import "SSShopDeleteView.h"

@interface SSShopOrderListVC ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) UITableView      *mine_table;
@property (nonatomic, strong) SSShopOrderListViewModel *viewModel;
@property (nonatomic, strong) SSShopOrderDetailCancelView *cancel_view;
@property (nonatomic, copy) NSString *cancelOrderId;
@property (nonatomic, strong) SSShopDeleteView *shopDeleteView;
@property (nonatomic, strong) SSShopOrderListModel *deleteModel;

@end

@implementation SSShopOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"商品订单"];

    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.view addSubview:self.mine_table];
    [self feltData:self.type];
    
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
    SSShopOrderListCell *cell = [SSShopOrderListCell cellWithTableView:tableView];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SSShopOrderListModel *model = self.data_array[indexPath.row];
    [cell initViewWithModel:model];
    cell.block = ^(SSShopOrderListCellType type) {
        if (type == SSShopOrderListCellTypeCancel){
            self.cancelOrderId = model.ID;
            [self.cancel_view showCancelView];
        }else if (type == SSShopOrderListCellTypeBuy){
            KDCShopVC *shopvc = [[KDCShopVC alloc]init];
            [self.navigationController pushViewController:shopvc animated:YES];
        }else if (type == SSShopOrderListCellTypePay){
            [self orderPayWithModel:model];
        }else if (type == SSShopOrderListCellTypeDelete){
        
            self.deleteModel = model;
            [self.shopDeleteView initViewWithType:SSShopDeleteViewTypeDelete];
            [self.shopDeleteView showView];
        }
    };
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = kColor(@"f8f8f8");
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 195;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSMineShopOrderDetailVC *detailVC = [[SSMineShopOrderDetailVC alloc]init];
    SSShopOrderListModel *model = self.data_array[indexPath.row];
    detailVC.orderId = model.ID;
    detailVC.orderModel = model;
    detailVC.block = ^(NSString *contectStr) {
        [self feltData:self.type];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"mine_order_null"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无订单";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UITableView *)mine_table
{
    if (!_mine_table) {
        _mine_table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
        _mine_table.delegate = self;
        _mine_table.dataSource = self;
        _mine_table.emptyDataSetSource = self;
        _mine_table.emptyDataSetDelegate = self;
        _mine_table.backgroundColor = kColor(@"f8f8f8");
        _mine_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mine_table;
}

- (void)feltData:(NSInteger )type
{
    [self.viewModel getShopOrderListWithType:type callback:^(id  _Nonnull object) {
        self.data_array = [SSShopOrderListModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        [self.mine_table reloadData];
    }];
}

//重新购买
- (void)againBuyGoods
{
//    [self.viewModel addCarWithUserId:account.uid goodsId:infoModel.ID num:@"1" productId:productMdoel.ID countCallback:^(id  _Nonnull object) {
//        [ProgressHUD showSuccess:@"添加购物车成功"];
//        [self carNum];
//    }];
}

//取消订单
- (void)cancelOrderWithOrderID:(NSString *)orderID reason:(NSString *)reason
{
    [self.viewModel cancelOrderWithOrderID:orderID cancelDescrip:reason callback:^(id  _Nonnull object) {
        [self feltData:self.type];
        [ProgressHUD showError:@"取消成功"];
    }];
  
}

//删除订单
- (void)deleteOrderWithOrderId:(NSString *)orderID
{
    [self.viewModel deleteOrderWithId:orderID callback:^(id  _Nonnull object) {
        [self feltData:self.type];
        [ProgressHUD showError:@"删除成功"];
    }];
}

//支付订单
- (void)orderPayWithModel:(SSShopOrderListModel *)listModel
{
    SSPayOrderVC *payVC = [[SSPayOrderVC alloc]init];
    payVC.viewType = SSPayOrderVCTypeShopOrder;
    payVC.orderModel = listModel;
    [self.navigationController pushViewController:payVC animated:YES];
}


- (SSShopOrderListViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopOrderListViewModel alloc]init];
    }
    return _viewModel;
}

- (SSShopOrderDetailCancelView *)cancel_view
{
    if (_cancel_view == nil) {
        WEAKSELF
        _cancel_view = [[NSBundle mainBundle]loadNibNamed:@"SSShopOrderDetailCancelView" owner:self options:nil].lastObject;
        _cancel_view.frame = CGRectMake(0, 0, kwidth, kheight);
        _cancel_view.block = ^(NSString * _Nonnull title) {
            [weakSelf cancelOrderWithOrderID:weakSelf.cancelOrderId reason:title];
        };
    }
    return _cancel_view;
}

- (SSShopDeleteView *)shopDeleteView
{
    if (_shopDeleteView == nil) {
        WEAKSELF
        _shopDeleteView = [[NSBundle mainBundle]loadNibNamed:@"SSShopDeleteView" owner:self options:nil].lastObject;
        _shopDeleteView.frame = CGRectMake(0, 0, kwidth, kheight);
        _shopDeleteView.block = ^(SSShopDeleteViewType viewType) {
            //删除事件。多个删除直接重新请求数据！
            [weakSelf deleteOrderWithOrderId:weakSelf.deleteModel.ID];
        };
    }
    return _shopDeleteView;
}

- (NSMutableArray *)data_array
{
    if (_data_array == nil) {
        _data_array = [[NSMutableArray alloc]init];
    }
    return _data_array;
}

@end
