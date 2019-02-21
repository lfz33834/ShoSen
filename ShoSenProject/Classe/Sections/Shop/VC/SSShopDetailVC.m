//
//  SSShopDetailVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopDetailVC.h"
#import "SSShopDetailFooterView.h"
#import "SSShopDetailHeaderView.h"
#import "SSShopViewModel.h"
#import "SSShopDetailModel.h"
#import "ShoppingCarViewController.h"
#import "SSShopSubmitOrderVC.h"
#import "SSShopSubmitOrderVC.h"
#import "BottomModel.h"
#import "ShopModel.h"
#import "SSShopSubmitOrderVC.h"
#import "SSShopCarModel.h"

@interface SSShopDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SSShopDetailHeaderView *headerView;
@property (nonatomic, strong) SSShopDetailFooterView *footerView;
@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) UITableView      *orderListTable;
@property (nonatomic, strong) SSShopViewModel *viewModel;
@property (nonatomic, strong) SSShopDetailModel *detailModel;
@property (nonatomic, strong) UIButton *bottomButton;

@end

@implementation SSShopDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setTitle:@"商品详情"];
    [self.view addSubview:self.orderListTable];
    [self feltData];
    [self updateUserInfo];
    
    if (self.vcType == SSShopDetailVCTypeJiFen) {
        [self.view addSubview:self.bottomButton];
    }else{
        [self.view addSubview:self.footerView];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self carNum];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 700 + 140;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (void)feltData
{
    [self.viewModel feltShopDetailDataWithID:self.goodID Callback:^(id  _Nonnull object) {
        self.detailModel = [SSShopDetailModel mj_objectWithKeyValues:object[@"data"]];
        if (self.vcType == SSShopDetailVCTypeJiFen) {
            [self.headerView initCellWithModel:self.detailModel.info viewType:SSShopDetailHeaderViewTypeJiFen];
        }else{
            [self.headerView initCellWithModel:self.detailModel.info viewType:SSShopDetailHeaderViewTypeMoney];
        }
        [self.orderListTable reloadData];
    }];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.footerView.frame = CGRectMake(0, kheight - kTopHeight - 55, kwidth, 55);
    self.bottomButton.frame = CGRectMake(0, kheight - kTopHeight - 55, kwidth, 55);
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - kTopHeight - kTabBarHeight) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"f8f8f8");
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
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
    SSAccount *account = [SSAccountTool share].account;
    if(account){
        
        SSProductListModel *procuct = self.detailModel.productList[0];
        if ([procuct.number intValue] == 0) {
            [ProgressHUD showError:@"当前库存不足"];
            return;
        }
        
        if([self.detailModel.info.retailPrice intValue] > [account.xProperty intValue])
        {
            [ProgressHUD showError:@"当前积分不足,暂无法兑换!"];
        }else{
            SSGoodSInfoModel *infoModel = self.detailModel.info;
            SSProductListModel *productMdoel = self.detailModel.productList[0];
            BottomModel *model = [[BottomModel alloc]init];
            model.totalMoney = [self.detailModel.info.retailPrice floatValue];
            model.totalCount = 1;
            model.infoModel_ID = infoModel.ID;
            model.productMdoel_ID = productMdoel.ID;
            ShopModel *shopinfo = [[ShopModel alloc]init];
            shopinfo.shopTitle = self.detailModel.info.name;
            shopinfo.singlePrice = [self.detailModel.info.retailPrice floatValue];
            shopinfo.count = 1;
            shopinfo.picUrl = self.detailModel.info.picUrl;
            shopinfo.ID = self.detailModel.info.ID;
            SSProductListModel *productModel = self.detailModel.productList[0];
            shopinfo.productId = productModel.ID;
            SSShopSubmitOrderVC *submitVC = [[SSShopSubmitOrderVC alloc]init];
            submitVC.data_array = [@[shopinfo] mutableCopy];
            submitVC.bottomModel = model;
            submitVC.orderType = SSShopSubmitOrderVCJiFen;
            [self.navigationController pushViewController:submitVC animated:YES];
        }
    }else{
        SSLoginVC *loginVC = [[SSLoginVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}


- (SSShopDetailHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSShopDetailHeaderView" owner:self options:nil].lastObject;
    }
    return _headerView;
}

- (SSShopDetailFooterView *)footerView
{
    if (_footerView == nil) {
        WEAKSELF
        _footerView = [[NSBundle mainBundle]loadNibNamed:@"SSShopDetailFooterView" owner:self options:nil].lastObject;
        _footerView.block = ^(SSShopDetailFooterViewType type) {
            SSAccount *account = [SSAccountTool share].account;
            if(account)
            {
                if (type == SSShopDetailFooterViewTypeCar) {
                    ShoppingCarViewController *shoppingCarVC = [[ShoppingCarViewController alloc]init];
                    [weakSelf.navigationController pushViewController:shoppingCarVC animated:YES];
                }else if (type == SSShopDetailFooterViewTypeShop)
                {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else if (type == SSShopDetailFooterViewTypeAddCar)
                {
                    [weakSelf addCarCallback:nil];
                }else if (type == SSShopDetailFooterViewTypeBuy){
                    SSGoodSInfoModel *infoModel = self.detailModel.info;
                    SSProductListModel *productMdoel = self.detailModel.productList[0];
                    
                    [self.viewModel atOnceBuyCarWithGoodsId:infoModel.ID productId:productMdoel.ID callback:^(id  _Nonnull object) {
                        BottomModel *model = [[BottomModel alloc]init];
                        model.totalMoney = [weakSelf.detailModel.info.retailPrice floatValue];
                        model.totalCount = 1;
                        ShopModel *shopinfo = [[ShopModel alloc]init];
                        shopinfo.shopTitle = weakSelf.detailModel.info.name;
                        shopinfo.singlePrice = [weakSelf.detailModel.info.retailPrice floatValue];
                        shopinfo.count = 1;
                        shopinfo.picUrl = weakSelf.detailModel.info.picUrl;
                        shopinfo.ID = weakSelf.detailModel.info.ID;
                        SSProductListModel *productModel = self.detailModel.productList[0];
                        shopinfo.productId = productModel.ID;
                        SSShopSubmitOrderVC *submitVC = [[SSShopSubmitOrderVC alloc]init];
                        submitVC.data_array = [@[shopinfo] mutableCopy];
                        submitVC.bottomModel = model;
                        submitVC.orderType = SSShopSubmitOrderVCYuE;
                        submitVC.isNowBuy = YES;
                        [weakSelf.navigationController pushViewController:submitVC animated:YES];
                    }];
                    
//                    [self.viewModel addCarWithUserId:account.uid goodsId:infoModel.ID num:@"1" productId:productMdoel.ID countCallback:^(id  _Nonnull object) {
//
//                      }];
                }
            }else{
                if (type == SSShopDetailFooterViewTypeShop)
                {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    SSLoginVC *loginVC = [[SSLoginVC alloc]init];
                    [weakSelf.navigationController pushViewController:loginVC animated:YES];
                }
            }
        };
    }
    return _footerView;
}

- (void)addCarCallback:(void(^)(id object))returnBack
{
    SSGoodSInfoModel *infoModel = self.detailModel.info;
    WEAKSELF
    SSProductListModel *productMdoel = self.detailModel.productList[0];
    SSAccount *account = [SSAccountTool share].account;
    [self.viewModel addCarWithUserId:account.uid goodsId:infoModel.ID num:@"1" productId:productMdoel.ID countCallback:^(id  _Nonnull object) {
        [ProgressHUD showSuccess:@"添加购物车成功"];
                [weakSelf carNum];
    }];
}

- (void)carNum
{
    [self.viewModel shopCarListCallback:^(id  _Nonnull object) {
        SSShopCarModel *carModel = [SSShopCarModel mj_objectWithKeyValues:object[@"data"]];
        NSMutableArray *goodsListArray = carModel.cartList;
        if (goodsListArray.count == 0) {
            self.footerView.num_label.text = @"";
        }else{
            self.footerView.num_label.text = [NSString stringWithFormat:@"%lu",(unsigned long)goodsListArray.count];
        }
     }];
//    WEAKSELF
//    [self.viewModel getGoodsCountCallback:^(id  _Nonnull object) {
//       NSString *num = [NSString stringWithFormat:@"%@",object[@"data"]];
//        if ([num intValue] == 0) {
//            weakSelf.footerView.num_label.text = @"";
//        }else{
//            weakSelf.footerView.num_label.text = num;
//        }
//    }];
}

- (SSShopViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopViewModel alloc]init];
    }
    return _viewModel;
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

@end
