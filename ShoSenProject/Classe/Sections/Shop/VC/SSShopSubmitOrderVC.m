//
//  SSShopSubmitOrderVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopSubmitOrderVC.h"
#import "SSShopOrderCell.h"
#import "SSShopOrderFooterView.h"
#import "SSShopOrderHeaderView.h"
#import "SSShopViewModel.h"
#import "SSShopOrderPayView.h"
#import "SSShopLocationManagerVC.h"
#import "SSShopDeleteView.h"
#import "SSLocationModel.h"
#import "ShopModel.h"
#import "SSShopOrderPaySuccessVC.h"
#import "SSPayOrderVC.h"
#import "SSShopOrderListModel.h"
#import "SSPaySuccessVC.h"

@interface SSShopSubmitOrderVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SSShopOrderHeaderView *headerView;
@property (nonatomic, strong) SSShopOrderFooterView *footerView;
@property (nonatomic, strong) SSShopOrderPayView *bottomView;
@property (nonatomic, strong) UITableView      *orderListTable;
@property (nonatomic, strong) SSShopViewModel *viewModel;

@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, strong) SSShopDeleteView *shopDeleteView;

@property (nonatomic, strong) SSLocationModel *locationModel;

@property (nonatomic, copy) NSString *jifenString;
@property (nonatomic, copy) NSString *yueString;
@property (nonatomic, copy) NSString *actualPriceString;

@property (nonatomic, assign) int goodsCount;


@end

@implementation SSShopSubmitOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self setTitle:@"提交订单"];
    [self.view addSubview:self.orderListTable];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newbacks)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];

    
    self.goodsCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"GOODSCOUNT"] intValue];
    
    if(self.orderType == SSShopSubmitOrderVCYuE)
    {
        [self.view addSubview:self.footerView];
        [self.bottomView initViewWithTyp:SSShopOrderPayViewTypeYuE moddel:self.bottomModel];
        self.yueString = @"0";
        self.actualPriceString = [NSString stringWithFormat:@"%.2f",self.bottomModel.totalMoney];
        
        self.footerView.money_label.text = [NSString stringWithFormat:@"￥%.2f", self.bottomModel.totalMoney];
        self.orderListTable.tableFooterView = self.bottomView;
        
        [self updateUserInfo];
        
    }else if (self.orderType == SSShopSubmitOrderVCJiFen){
        
        [self.view addSubview:self.bottomButton];
        [self.bottomView initViewWithTyp:SSShopOrderPayViewTypeJiFen moddel:self.bottomModel];
        self.orderListTable.tableFooterView = self.bottomView;
        self.jifenString = [NSString stringWithFormat:@"￥%.2f", self.bottomModel.totalMoney];
    }
    
    [self locationData];
}

- (void)locationData
{
    [self.viewModel locationListCallback:^(id  _Nonnull object) {
        NSMutableArray *location_array = [SSLocationModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        [location_array enumerateObjectsUsingBlock:^(SSLocationModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj.isDefault){
                self.locationModel = obj;
                self.headerView.locationModel = obj;
            }
        }];
    }];
}

- (void)newbacks
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSShopOrderCell *cell = [SSShopOrderCell cellWithTableView:tableView];
    ShopModel *model = self.data_array[indexPath.row];
    if(self.orderType == SSShopSubmitOrderVCYuE)
    {
        [cell initCellWithModel:model cellType:SSShopOrderCellTypeYue];
    }else{
        [cell initCellWithModel:model cellType:SSShopOrderCellTypeJiFen];
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.footerView.frame = CGRectMake(0, kheight - kTopHeight - 50, kwidth, 50);
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - kTopHeight - kTabBarHeight) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.rowHeight = 80;
        _orderListTable.backgroundColor = kColor(@"f8f8f8");
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (SSShopOrderHeaderView *)headerView
{
    if (_headerView == nil) {
        WEAKSELF
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSShopOrderHeaderView" owner:self options:nil].lastObject;
        _headerView.block = ^{
            SSShopLocationManagerVC *location = [[SSShopLocationManagerVC alloc]init];
            location.block = ^(SSLocationModel * _Nonnull locationModel) {
                weakSelf.locationModel = locationModel;
                weakSelf.headerView.locationModel = locationModel;
             };
            [weakSelf.navigationController pushViewController:location animated:YES];
        };
    }
    return _headerView;
}

- (SSShopOrderPayView *)bottomView//uitableview的footer
{
    if (_bottomView == nil) {
        WEAKSELF
        _bottomView = [[NSBundle mainBundle]loadNibNamed:@"SSShopOrderPayView" owner:self options:nil].lastObject;
        _bottomView.block = ^(BOOL isSelect, NSString *money) {
            if (isSelect) {
                if ([money intValue] > self.bottomModel.totalMoney) {
                    weakSelf.footerView.money_label.text = [NSString stringWithFormat:@"￥ %@",@"0"];
                    weakSelf.yueString = [NSString stringWithFormat:@"%.2f",weakSelf.bottomModel.totalMoney];
                    weakSelf.actualPriceString = @"0";
                }else{
                    CGFloat act_money =  self.bottomModel.totalMoney - [money floatValue];
                    weakSelf.footerView.money_label.text = [NSString stringWithFormat:@"￥ %.2f",act_money];
                    weakSelf.yueString = money;
                    weakSelf.actualPriceString = [NSString stringWithFormat:@"%.2f",act_money];
                }
            }else{
                weakSelf.footerView.money_label.text = [NSString stringWithFormat:@"￥ %.2f",weakSelf.bottomModel.totalMoney];
                weakSelf.yueString = @"0";
                weakSelf.actualPriceString = [NSString stringWithFormat:@"%.2f",weakSelf.bottomModel.totalMoney];
            }
        };
    }
    return _bottomView;
}


- (SSShopOrderFooterView *)footerView//self.view的footer
{
    if (_footerView == nil) {
        WEAKSELF
        _footerView = [[NSBundle mainBundle]loadNibNamed:@"SSShopOrderFooterView" owner:self options:nil].lastObject;
        _footerView.block = ^{
            if([self.yueString intValue] > 0){
                [weakSelf.shopDeleteView initViewWithType:SSShopDeleteViewTypeYueExchange];
                [weakSelf.shopDeleteView showView];
            }else{
                [weakSelf creatOrder];
            }
        };
    }
    return _footerView;
}

- (SSShopViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopViewModel alloc]init];
    }
    return _viewModel;
}

- (UIButton *)bottomButton
{
    if (_bottomButton == nil) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_bottomButton setBackgroundImage:[UIImage imageNamed:@"shop_detail_buy_bg"] forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(jiFenPayButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _bottomButton.frame = CGRectMake(0, kheight - kTopHeight - kTabBarHeight, kwidth, kTabBarHeight);
    }
    return _bottomButton;
}

- (void)jiFenPayButtonTapAction
{
    [self.shopDeleteView initViewWithType:SSShopDeleteViewTypeExchange];
    [self.shopDeleteView showView];
}

- (SSShopDeleteView *)shopDeleteView
{
    if (_shopDeleteView == nil) {
        WEAKSELF
        _shopDeleteView = [[NSBundle mainBundle]loadNibNamed:@"SSShopDeleteView" owner:self options:nil].lastObject;
        _shopDeleteView.frame = CGRectMake(0, 0, kwidth, kheight);
        _shopDeleteView.block = ^(SSShopDeleteViewType viewType){
            if (viewType == SSShopDeleteViewTypeExchange) {
                [weakSelf jiefenCreatOrder];
            }else if (viewType == SSShopDeleteViewTypeYueExchange)
            {
                [weakSelf creatOrder];
            }
        };
    }
    return _shopDeleteView;
}

- (void)updateUserInfo
{
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        [FZHttpTool post:UserInfoUrl parameters:@{@"phone":account.phone} isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
            [[SSAccountTool share]saveAccountData:[json[@"data"]mutableCopy]];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}

- (void)jiefenCreatOrder
{
    NSString *jifen = [NSString stringWithFormat:@"%.2f",self.bottomModel.totalMoney];
    
    SSAccount *account = [SSAccountTool share].account;
    NSMutableArray *productIds = [[NSMutableArray alloc]init];
    [self.data_array enumerateObjectsUsingBlock:^(ShopModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [productIds addObject:obj.productId];
    }];
    WEAKSELF
    [self.viewModel addCarWithUserId:account.uid goodsId:self.bottomModel.infoModel_ID num:@"1" productId:self.bottomModel.productMdoel_ID countCallback:^(id  _Nonnull object) {
        [weakSelf.viewModel selectCheckedWithProductIds:productIds callback:^(id  _Nonnull object) {
            [weakSelf.viewModel creatOrderWithAddressId:weakSelf.locationModel.ID productIds:productIds integralPrice:jifen money:@"0" actualPrice:@"0" isNowBuy:NO callback:^(id  _Nonnull object) {
                [ProgressHUD showSuccess:@"下单成功"];
                SSShopOrderPaySuccessVC *successVC = [[SSShopOrderPaySuccessVC alloc]init];
                [weakSelf.navigationController pushViewController:successVC animated:YES];
            }];
        }];
    }];
}

- (void)creatOrder
{
    SSAccount *account = [SSAccountTool share].account;
    if (!self.locationModel) {
        [ProgressHUD showError:@"请先填写地址,再进行操作"];
        return;
    }else if(self.jifenString.length > 1 && ([account.xProperty floatValue] < [self.jifenString floatValue]))
    {
        [ProgressHUD showError:@"积分不够"];
        return;
    }
    NSMutableArray *productIds = [[NSMutableArray alloc]init];
    [self.data_array enumerateObjectsUsingBlock:^(ShopModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [productIds addObject:obj.productId];
    }];
    
    BOOL isBuyOneNow;
    if (self.isNowBuy) {
        isBuyOneNow = YES;
    }else{
        isBuyOneNow = NO;
    }
    
    if ([self.actualPriceString floatValue] == 0) {
        [self.viewModel selectCheckedWithProductIds:productIds callback:^(id  _Nonnull object) {
            [self.viewModel creatOrderWithAddressId:self.locationModel.ID productIds:productIds integralPrice:@"0" money:self.yueString actualPrice:self.actualPriceString isNowBuy:self.isNowBuy callback:^(id  _Nonnull object) {
                SSPaySuccessVC *suVC = [[SSPaySuccessVC alloc]init];
                suVC.vcType = SSPayOrderVCTypeShopOrder;
                [self.navigationController pushViewController:suVC animated:YES];
            }];
        }];
    }else{
        [self.viewModel selectCheckedWithProductIds:productIds callback:^(id  _Nonnull object) {
            [self.viewModel creatOrderWithAddressId:self.locationModel.ID productIds:productIds integralPrice:@"0" money:self.yueString actualPrice:self.actualPriceString  isNowBuy:isBuyOneNow callback:^(id  _Nonnull object) {
                [ProgressHUD showSuccess:@"下单成功"];
                SSPayOrderVC *payVC = [[SSPayOrderVC alloc]init];
                payVC.viewType = SSPayOrderVCTypeShopOrder;
                SSShopOrderListModel *listModel = [[SSShopOrderListModel alloc]init];
                listModel.ID = object[@"data"][@"orderId"];
                listModel.actualPrice = [NSString stringWithFormat:@"%@",self.actualPriceString];
                payVC.orderModel = listModel;
                [self.navigationController pushViewController:payVC animated:YES];
            }];
        }];
    }
}

@end
