//
//  KDCShopVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "KDCShopVC.h"
#import "SSShopCell.h"
#import "SSShopHeaderView.h"
#import "SSShopViewModel.h"
#import "SSShopModel.h"
#import "SSShopDetailVC.h"
#import "ShoppingCarViewController.h"
#import "SSShopOtherHeaderView.h"
#import "SSLoginVC.h"

@interface KDCShopVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) SSShopViewModel *viewModel;
@property (nonatomic, strong) SSShopModel *shopModel;
@property (nonatomic, strong) NSMutableArray *data_array;
@property (nonatomic, strong) NSMutableArray *banner_array;
@property (nonatomic, strong) UICollectionView *main_collectionView;

@end

@implementation KDCShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self setUpCollectionView];
    [self feltShopList];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    [leftBtn setImage:[[UIImage imageNamed:@"shop_home_car"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newbacks)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem = leftItem;
}

- (void)newbacks
{
    SSAccount *account = [SSAccountTool share].account;
    if(account)
    {
        ShoppingCarViewController *shopingCar = [[ShoppingCarViewController alloc]init];
        [self.navigationController pushViewController:shopingCar animated:YES];
    }else{
        SSLoginVC *loginVC = [[SSLoginVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)setUpCollectionView
{
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    flowLayout.minimumLineSpacing = 10.0;//行间距(最小值)
    flowLayout.minimumInteritemSpacing = 10.0;//item间距(最小值)
    CGFloat with = (kwidth - 10*3)/2;
    flowLayout.itemSize = CGSizeMake(with, 205);//item的大小
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//设置section的边距
    flowLayout.headerReferenceSize = CGSizeMake(kwidth, 200);
     //第二个参数是cell的布局
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight - kTabBarHeight - kTopHeight) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"SSShopCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"SSShopCell"];
    UINib *headerNib = [UINib nibWithNibName:@"SSShopHeaderView" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SSShopHeaderView"];
    UINib *otherheaderNib = [UINib nibWithNibName:@"SSShopOtherHeaderView" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:otherheaderNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SSShopOtherHeaderView"];
    self.main_collectionView = collectionView;
    [self.view addSubview:collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SSFloorGoodsList *good_model = self.shopModel.floorGoodsList[section];
    return good_model.goodsList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.shopModel.floorGoodsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SSShopCell" forIndexPath:indexPath];
    SSFloorGoodsList *listModel = self.shopModel.floorGoodsList[indexPath.section];
    SSGoodsListModel *goodModel = listModel.goodsList[indexPath.row];
    [cell initCellWithModel:goodModel section:indexPath.section];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            SSShopHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SSShopHeaderView" forIndexPath:indexPath];
            headerView.scrollView.imageURLStringsGroup = self.banner_array;
            return headerView;
        }else{
            
            SSShopOtherHeaderView *otherheaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SSShopOtherHeaderView" forIndexPath:indexPath];
             SSFloorGoodsList *good_model = self.shopModel.floorGoodsList[indexPath.section];
            otherheaderView.title_label.text = good_model.name;
            return otherheaderView;
        }
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSShopDetailVC *shopDetail = [[SSShopDetailVC alloc]init];
    SSFloorGoodsList *listModel = self.shopModel.floorGoodsList[indexPath.section];
    SSGoodsListModel *goodModel = listModel.goodsList[indexPath.row];
    shopDetail.goodID = goodModel.ID;
    if ([listModel.name isEqualToString:@"积分兑换专区"]) {
        shopDetail.vcType = SSShopDetailVCTypeJiFen;
    }else{
        shopDetail.vcType = SSShopDetailVCTypeMoney;
    }
    [self.navigationController pushViewController:shopDetail animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat with = (kwidth - 10*3)/2;
    return CGSizeMake(with, 205);
}
//定义每个Section 的 margin

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
    
}
//每个section中不同的行之间的行间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//每个item之间的间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGSize size={kwidth,235};
        return size;
    }
    CGSize Othersize={kwidth,85};
     return Othersize;
    
}

- (void)feltShopList
{
    [self.viewModel feltShopDataCallback:^(id  _Nonnull object) {
        [self.banner_array removeAllObjects];
        self.shopModel = [SSShopModel mj_objectWithKeyValues:object[@"data"]];
        [self.shopModel.banner enumerateObjectsUsingBlock:^(SSShopBannerModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.banner_array addObject:obj.url];
        }];
        [self.main_collectionView reloadData];
    }];
}

- (NSMutableArray *)data_array
{
    if (_data_array == nil) {
        _data_array = [[NSMutableArray alloc]init];
    }
    return  _data_array;
}

- (NSMutableArray *)banner_array
{
    if (_banner_array == nil) {
        _banner_array = [[NSMutableArray alloc]init];
    }
    return  _banner_array;
}

- (SSShopViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopViewModel alloc]init];
    }
    return _viewModel;
}

@end
