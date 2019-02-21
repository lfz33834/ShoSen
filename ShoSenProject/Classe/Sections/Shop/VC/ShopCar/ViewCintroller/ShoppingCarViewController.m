//
//  ShoppingCarViewController.m
//  ZDCar
//
//  Created by yangxuran on 16/7/22.
//  Copyright © 2016年 boc. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "ShopCarTableViewCell.h"
#import "CustomHeaderView.h"
#import "BottomView.h"
#import "ShopCarModel.h"
#import "ShopModel.h"
#import "MBProgressHUD+RY.h"
#import "KDCShopHeaderView.h"
#import "SSShopViewModel.h"
#import "SSShopCarModel.h"
#import "SSShopSubmitOrderVC.h"
#import "SSShopDeleteView.h"

@interface ShoppingCarViewController ()<UITableViewDelegate,UITableViewDataSource,ShopCarTableViewCellDelegate, BottomViewDelegate, UIAlertViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong)UITableView * baseTable;
@property (nonatomic, strong)NSMutableArray * dataAry;
@property (nonatomic, strong)BottomView * bottomView;
@property (nonatomic, strong)KDCShopHeaderView *headerView;
@property (nonatomic, strong)BottomModel * bottomModel;
@property (nonatomic, strong)NSMutableArray * totalSelectedAry;
@property (nonatomic, strong)UIButton * rightTopBtn;
@property (nonatomic, assign)BOOL isEditing;
@property (nonatomic, strong) SSShopDeleteView *shopDeleteView;
//测试
@property (nonatomic, copy)NSMutableString * testString;
@property (nonatomic, strong) SSShopViewModel *viewModel;
@property (nonatomic, strong) SSShopCarModel *carModel;

@end

static NSString * indentifier = @"shopCarCell";
@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购物车";
    self.view.backgroundColor = kColor(@"f8f8f8");
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.view addSubview:self.baseTable];
    
    BottomView * bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, kheight - 55 - kTopHeight, kWidth, 55)];
    bottomView.delegate = self;
    self.bottomView = bottomView;
    [self.view addSubview:self.bottomView];
    self.bottomModel = [[BottomModel alloc] init];
    
    [self configerNavItemBtn];
    [self shopCarList];
}

- (void)configerNavItemBtn{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newbacks)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.rightTopBtn = btn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)newbacks
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableView *)baseTable{
    if (_baseTable == nil) {
        _baseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 55 - kTopHeight) style:UITableViewStylePlain];
        _baseTable.dataSource = self;
        _baseTable.delegate = self;
        _baseTable.backgroundColor = kColor(@"f8f8f8");
        _baseTable.rowHeight = 80;
        _baseTable.emptyDataSetSource = self;
        _baseTable.emptyDataSetDelegate = self;
        _baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _baseTable;
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"mine_order_null"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无商品";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"shop_null_button"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName:kColor(@"ffffff")
                                 };
    return [[NSAttributedString alloc] initWithString:@"去逛逛" attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -- <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    return self.headerView;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCarTableViewCell * cell = [ShopCarTableViewCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.model = self.dataAry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击进入商品详情页面");

}

#pragma mark --- cell代理方法(cell 左侧按钮)
- (void)clickedWichLeftBtn:(UITableViewCell *)cell{
    NSIndexPath * indexpath = [self.baseTable indexPathForCell:cell];
    ShopModel * model = self.dataAry[indexpath.row];
    model.selected = !model.selected;
    NSInteger totalCount = 0;
    for (int i = 0; i < self.dataAry.count; i++) {
        ShopModel * shopModel = self.dataAry[i];
        if (shopModel.selected) {
            totalCount++;
        }
    }
    [self checkShopState];
}

//修改数量
- (void)changeTheShopCount:(UITableViewCell *)cell count:(NSInteger )count{
    NSIndexPath * indexpath = [self.baseTable indexPathForCell:cell];
    NSLog(@"%zd-----%zd", indexpath.section, indexpath.row);
    ShopModel * model = self.dataAry[indexpath.row];
    model.count = count;
    //    [self checkShopState];错误
    [self GetTotalBill];
    
    [self updateNumWithModel:model];
}

- (void)updateNumWithModel:(ShopModel *)model
{
    [self.viewModel updateShopGoodsNumWithId:model.ID goodsId:model.goodsId number:[NSString stringWithFormat:@"%ld",(long)model.count] productId:model.productId callback:^(id  _Nonnull object) {
        
    }];
}

#pragma mark --  BottomViewDelegate
-  (void)clickedBottomSelecteAll{//全选方法
    
    self.bottomModel.isSelecteAll = !self.bottomModel.isSelecteAll;
       for (int j = 0; j < self.dataAry.count; j++) {
        ShopModel *shopModel = self.dataAry[j];
        shopModel.selected = self.bottomModel.isSelecteAll;
     }
    self.bottomView.model = self.bottomModel;
    [self GetTotalBill];//求和
    [self.baseTable reloadData];
}

- (void)clickedBottomJieSuanWithType:(BottomViewType)type model:(BottomModel *)model
{
    if (self.bottomModel.isEdit) {
        if (self.bottomModel.totalCount == 0) {
            NSLog(@"请选择要删除的商品");
            [MBProgressHUD showError:@"请选择要删除的商品"];
        }else{
            NSLog(@"选择了商品，进行删除");
            NSLog(@"要删除的数据模型是%@", _totalSelectedAry);
//            [self warnMessage:[NSString stringWithFormat:@"要删除（%@）", self.testString]];
            [self.shopDeleteView initViewWithType:SSShopDeleteViewTypeDelete];
            [self.shopDeleteView showView];
        }
    }else{
        if (self.bottomModel.totalCount == 0) {
            [MBProgressHUD showError:@"请选择结算商品"];
        }else{
            NSLog(@"选择了商品，进行结算，进入商品详情页面");
            NSLog(@"要传给下一个订单详情页面的数据模型是%@", _totalSelectedAry);
            SSShopSubmitOrderVC *submitVC = [[SSShopSubmitOrderVC alloc]init];
            submitVC.data_array = self.totalSelectedAry;
            submitVC.bottomModel = model;
            submitVC.orderType = SSShopSubmitOrderVCYuE;
            [self.navigationController pushViewController:submitVC animated:YES];
        }
    }
}

#pragma mark -- 公共方法
//选中商品或者选中店铺都会走这个公共方法。在这里判断选中的店铺数量还不是和数据源数组数量相等。一样的话就全选，否则相反。
- (void)checkShopState{
    NSInteger totalSelected = 0;
    for (int i = 0; i < self.dataAry.count; i++) {
        ShopModel * model = self.dataAry[i];
        if (model.selected) {
            totalSelected++;
        }
    }
    if (totalSelected == self.dataAry.count) {
        self.bottomModel.isSelecteAll = YES;
    }else{
        self.bottomModel.isSelecteAll = NO;
    }
    self.bottomView.model = self.bottomModel;
    
    [self GetTotalBill];//求和
    [self.baseTable reloadData];
    
}

//求得总共费用
- (void)GetTotalBill{
    self.totalSelectedAry  = [NSMutableArray array];
    float totalMoney = 0.00;
    NSMutableString * compentStr = [[NSMutableString alloc] init];
      for (int j = 0; j <  self.dataAry.count; j++) {
        ShopModel *shopModel = self.dataAry[j];
        if (shopModel.selected) {
            //保存model。如果是结算，传递选中商品，确认订单页面展示。如果是删除，根据此数组，拿到商品ID，用来删除。
            [_totalSelectedAry addObject:shopModel];
            [compentStr appendString:shopModel.shopTitle];
            totalMoney += shopModel.singlePrice * shopModel.count;
        }
    }
     if (self.dataAry.count == 0) {
        self.bottomModel.isSelecteAll = NO;
        self.bottomModel.isEdit = NO;
        [self.rightTopBtn setTitle:@"编辑"forState:UIControlStateNormal];
        self.bottomView.model = self.bottomModel;
    }
    self.testString = compentStr;//保存，测试用。
    self.bottomModel.totalMoney = totalMoney;
    self.bottomModel.totalCount = _totalSelectedAry.count;
    self.bottomView.model = self.bottomModel;
}

//- (void)warnMessage:(NSString *)string{
//    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
//}
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//        //删除事件。多个删除直接重新请求数据！
//        [self deleteOrder];
//    }
//}

- (SSShopDeleteView *)shopDeleteView
{
    if (_shopDeleteView == nil) {
        WEAKSELF
        _shopDeleteView = [[NSBundle mainBundle]loadNibNamed:@"SSShopDeleteView" owner:self options:nil].lastObject;
        _shopDeleteView.frame = CGRectMake(0, 0, kwidth, kheight);
        _shopDeleteView.block = ^(SSShopDeleteViewType viewType){
            //删除事件。多个删除直接重新请求数据！
            [weakSelf deleteOrder];
        };
    }
    return _shopDeleteView;
}

- (KDCShopHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"KDCShopHeaderView" owner:self options:nil].lastObject;
    }
    return _headerView;
}

- (SSShopViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopViewModel alloc]init];
    }
    return  _viewModel;
}

- (void)deleteOrder
{
    NSMutableArray *productIds = [[NSMutableArray alloc]init];
    [self.totalSelectedAry enumerateObjectsUsingBlock:^(ShopModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [productIds addObject:obj.productId];
    }];
    [self.viewModel deleteOrderWithProductIds:productIds callback:^(id  _Nonnull object) {
        [ProgressHUD showSuccess:@"删除成功"];
        [self shopCarList];
    }];
}

- (void)shopCarList
{
    WEAKSELF
    [self.viewModel shopCarListCallback:^(id  _Nonnull object) {
        self.carModel = [SSShopCarModel mj_objectWithKeyValues:object[@"data"]];
        weakSelf.headerView.jifen_label.text = self.carModel.cartTotal.goodsAmount;
        weakSelf.dataAry = self.carModel.cartList;
        
        if (self.dataAry.count > 0) {
            self.bottomView.hidden = NO;
//            [self.rightTopBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }else{
            self.bottomView.hidden = YES;
            [self.rightTopBtn setTitle:@"" forState:UIControlStateNormal];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)weakSelf.dataAry.count] forKey:@"GOODSCOUNT"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [weakSelf.baseTable reloadData];
    }];
}



#pragma mark --- NavgationItemBtnClicked
- (void)editBtnClicked{
    
    for (int j = 0; j < self.dataAry.count; j++) {
        ShopModel *shopModel = self.dataAry[j];
        shopModel.selected = NO;
    }
    self.bottomView.model = self.bottomModel;
    [self GetTotalBill];//求和
    [self.baseTable reloadData];
    
    self.isEditing = !self.isEditing;
    [self.rightTopBtn setTitle:self.isEditing ? @"完成" : @"编辑" forState:UIControlStateNormal];
    self.bottomModel.isEdit = self.isEditing;
    self.bottomView.model = self.bottomModel;
}

@end
