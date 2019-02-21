//
//  SSMineShopOrderDetailVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineShopOrderDetailVC.h"
#import "SSMineShopOrderDetailCell.h"
#import "SSMineShopOrderDetailFooterView.h"
#import "SSShopOrderListViewModel.h"
#import "SSShopOrderDetailHeaderView.h"
#import "SSShopOrderDetailFooterView.h"
#import "SSShopOrderListModel.h"
#import "SSShopOrderDetailCancelView.h"
#import "KDCShopVC.h"
#import "SSPayOrderVC.h"
#import "SSShopDeleteView.h"

@interface SSMineShopOrderDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) SSShopOrderInfoModel *orderInfoModel;
@property (nonatomic, strong) UITableView      *mine_table;
@property (nonatomic, strong) SSMineShopOrderDetailFooterView *footerView;
@property (nonatomic, strong) SSShopOrderDetailHeaderView *orderDetailHeader;
@property (nonatomic, strong) SSShopOrderDetailFooterView *orderDetailFooter;
@property (nonatomic, strong) SSShopOrderListViewModel *viewModel;
@property (nonatomic, strong) SSShopOrderDetailCancelView *cancel_view;
@property (nonatomic, strong) SSShopDeleteView *shopDeleteView;
@property (nonatomic, strong) UIButton *buy_Button;
@property (nonatomic, assign) int button_type;

@end

@implementation SSMineShopOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"商品详情"];
    
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.view addSubview:self.mine_table];

    [self feltOrderDetail];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newbacks)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];

    int status = [self.orderModel.orderStatus intValue];
    if (status == 101) {//待支付
        self.orderDetailHeader.paystatus_label.text = @"待支付";
        self.orderDetailHeader.status_label.hidden = YES;
        self.orderDetailHeader.paystatus_label.hidden = NO;
        self.orderDetailHeader.time_label.hidden = NO;
        self.footerView.viewType = ShopOrderDetaiTypePay;
        [self.view addSubview:self.footerView];
    }else if (status == 401 || status == 402 ||  status == 501)//已完成
    {
        self.orderDetailHeader.status_label.text = @"已完成";
        [self.buy_Button setTitle:@"再次购买" forState:UIControlStateNormal];
        self.button_type = 1;
        self.mine_table.frame = CGRectMake(0, 0, kwidth, kheight - kTopHeight);
//        [self.view addSubview:self.buy_Button];
    }else if (status == 102  ||status == 103)//已取消
    {
        self.orderDetailHeader.status_label.text = @"已取消";
        self.footerView.viewType = ShopOrderDetaiTypeCancel;
        [self.view addSubview:self.footerView];
    }else if (status == 301)//卖家已发货
    {
        self.orderDetailHeader.status_label.text = @"卖家已发货";
        [self.buy_Button setTitle:@"确认收货" forState:UIControlStateNormal];
        self.button_type = 2;
        [self.view addSubview:self.buy_Button];
    }else if (status == 201)//买家已付款
    {
        self.orderDetailHeader.status_label.text = @"买家已付款";
        [self.buy_Button setTitle:@"再次购买" forState:UIControlStateNormal];
        self.button_type = 1;
        self.mine_table.frame = CGRectMake(0, 0, kwidth, kheight - kTopHeight);
//        [self.view addSubview:self.buy_Button];
    }
}

- (void)newbacks
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSMineShopOrderDetailCell *cell = [SSMineShopOrderDetailCell cellWithTableView:tableView];
    SSShopOrderGoodsListModel *goodsModel = self.data_array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if([self.orderInfoModel.orderType isEqualToString:@"integral"]){
        [cell initCellWithModel:goodsModel cellType:SSMineShopOrderDetailCellTypeJiFen];
    }else{
        [cell initCellWithModel:goodsModel cellType:SSMineShopOrderDetailCellTypeYue];
    }
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
     [self.orderDetailHeader initViewWithModel:self.orderInfoModel];
      return self.orderDetailHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 220;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableView *)mine_table
{
    if (!_mine_table) {
        _mine_table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - kTopHeight - kTabBarHeight) style:UITableViewStylePlain];
        _mine_table.delegate = self;
        _mine_table.dataSource = self;
        _mine_table.backgroundColor = kColor(@"f8f8f8");
        _mine_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mine_table;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.footerView.frame = CGRectMake(0, kheight - kTopHeight - 55, kwidth, 55);
}

- (SSMineShopOrderDetailFooterView *)footerView
{
    if (_footerView == nil) {
        WEAKSELF
        _footerView = [[NSBundle mainBundle]loadNibNamed:@"SSMineShopOrderDetailFooterView" owner:self options:nil].lastObject;
        _footerView.block = ^(ShopOrderDetaiButtonTapType buttonType) {
            if (buttonType == ShopOrderDetaiButtonTapTypeDelete) {
                [weakSelf.shopDeleteView initViewWithType:SSShopDeleteViewTypeDelete];
                [weakSelf.shopDeleteView showView];
            }else if (buttonType == ShopOrderDetaiButtonTapTypeCancel)
            {
                [weakSelf.cancel_view showCancelView];
            }else if (buttonType == ShopOrderDetaiButtonTapTypeBuy){
                [weakSelf againBuyGoods];
            }else if (buttonType == ShopOrderDetaiButtonTapTypePay){
                [weakSelf orderPay];
            }
        };
    }
    return _footerView;
}

- (SSShopDeleteView *)shopDeleteView
{
    if (_shopDeleteView == nil) {
        WEAKSELF
        _shopDeleteView = [[NSBundle mainBundle]loadNibNamed:@"SSShopDeleteView" owner:self options:nil].lastObject;
        _shopDeleteView.frame = CGRectMake(0, 0, kwidth, kheight);
        _shopDeleteView.block = ^(SSShopDeleteViewType viewType){
            //删除事件。多个删除直接重新请求数据！
            [weakSelf deleteOrderWithOrderId:weakSelf.orderId];
        };
    }
    return _shopDeleteView;
}

- (SSShopOrderDetailFooterView *)orderDetailFooter
{
    if (_orderDetailFooter == nil) {
        _orderDetailFooter = [[NSBundle mainBundle]loadNibNamed:@"SSShopOrderDetailFooterView" owner:self options:nil].lastObject;
     }
    return _orderDetailFooter;
}

- (SSShopOrderDetailHeaderView *)orderDetailHeader
{
    if (_orderDetailHeader == nil) {
        _orderDetailHeader = [[NSBundle mainBundle]loadNibNamed:@"SSShopOrderDetailHeaderView" owner:self options:nil].lastObject;
     }
    return _orderDetailHeader;
}

- (SSShopOrderDetailCancelView *)cancel_view
{
    if (_cancel_view == nil) {
        WEAKSELF
        _cancel_view = [[NSBundle mainBundle]loadNibNamed:@"SSShopOrderDetailCancelView" owner:self options:nil].lastObject;
        _cancel_view.frame = CGRectMake(0, 0, kwidth, kheight);
        _cancel_view.block = ^(NSString * _Nonnull title) {
            [weakSelf cancelOrderWithOrderID:weakSelf.orderId reason:title];
        };
    }
    return _cancel_view;
}

- (UIButton *)buy_Button
{
    if (_buy_Button == nil) {
        _buy_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buy_Button setBackgroundImage:[UIImage imageNamed:@"shop_detail_buy_bg"] forState:UIControlStateNormal];
        [_buy_Button setTitle:@"再次购买" forState:UIControlStateNormal];
        [_buy_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buy_Button.titleLabel.font = [UIFont systemFontOfSize:16];
        [_buy_Button addTarget:self action:@selector(buyButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
        _buy_Button.frame = CGRectMake(0, kheight - kTopHeight - kTabBarHeight, kwidth, kTabBarHeight);
    }
    return _buy_Button;
}

- (void)buyButtonTapAction
{
    if(self.button_type == 1)//再次购买
    {
        [self againBuyGoods];
    }else if (self.button_type == 2)//确认收货
    {
        [self confirmReceiveingOrderID:self.orderId];
    }
}

- (void)againBuyGoods
{
    KDCShopVC *shopvc = [[KDCShopVC alloc]init];
    [self.navigationController pushViewController:shopvc animated:YES];
}

//取消订单
- (void)cancelOrderWithOrderID:(NSString *)orderID reason:(NSString *)reason
{
    [self.viewModel cancelOrderWithOrderID:orderID cancelDescrip:reason callback:^(id  _Nonnull object) {
        [self.navigationController popViewControllerAnimated:YES];
        self.block(@"");
        [ProgressHUD showError:@"取消成功"];
    }];
    
}

//删除订单
- (void)deleteOrderWithOrderId:(NSString *)orderID
{
    [self.viewModel deleteOrderWithId:orderID callback:^(id  _Nonnull object) {
        [self.navigationController popViewControllerAnimated:YES];
        self.block(@"");
        [ProgressHUD showError:@"删除成功"];
    }];
}

//确认收货
- (void)confirmReceiveingOrderID:(NSString *)orderID
{
    [self.viewModel confirmReceiveGoodsWithId:orderID callback:^(id  _Nonnull object) {
        [self.navigationController popViewControllerAnimated:YES];
        [ProgressHUD showError:@"收货成功"];
    }];
}

//支付订单
- (void)orderPay
{
    SSPayOrderVC *payVC = [[SSPayOrderVC alloc]init];
    payVC.viewType = SSPayOrderVCTypeShopOrder;
    payVC.orderModel = self.orderModel;
    [self.navigationController pushViewController:payVC animated:YES];
}

- (SSShopOrderListViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopOrderListViewModel alloc]init];
    }
    return _viewModel;
}

- (SSShopOrderInfoModel *)orderInfoModel
{
    if (_orderInfoModel == nil) {
        _orderInfoModel = [[SSShopOrderInfoModel alloc]init];
    }
    return _orderInfoModel;
}

- (void)feltOrderDetail
{
    [self.viewModel orderDetailWithOrderID:self.orderId callback:^(id  _Nonnull object) {
        self.orderInfoModel = [SSShopOrderInfoModel mj_objectWithKeyValues:object[@"data"][@"orderInfo"]];
        self.data_array = [SSShopOrderGoodsListModel mj_objectArrayWithKeyValuesArray:object[@"data"][@"orderGoods"]];
        [self.orderDetailFooter initViewWithModel:self.orderInfoModel orderModel:self.orderModel];
        self.mine_table.tableFooterView = self.orderDetailFooter;
        
        int status = [self.orderModel.orderStatus intValue];

        if(status == 101){
            [[SSTimerTool share] createTimer:[self.orderInfoModel.countDownStamp intValue]/1000 isTimeType:@"3" isTime:YES  resultBlock:^(NSString *paramStr) {
                self.orderDetailHeader.time_label.text = [NSString stringWithFormat:@"剩余%@自动关闭",paramStr];
            }];
        }
        [self.mine_table reloadData];
    }];
}

@end
