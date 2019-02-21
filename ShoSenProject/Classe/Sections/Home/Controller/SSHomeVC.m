//
//  SSHomeVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/13.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSHomeVC.h"
#import "SSHomCollectionCell.h"
#import "SSHomeCollectionHeaderView.h"
#import "SSHomeViewModel.h"
#import "SSCarConfigureVC.h"
#import "SSLoginVC.h"
#import "SSHomeCell.h"
#import "SSHomeHeaderView.h"
#import "SSCircleViewModel.h"
#import "SSNewsModel.h"
#import "SSPrizeVC.h"
#import "SSSignInView.h"
#import "FZWebViewController.h"
#import "SSContributeDetailVC.h"

@interface SSHomeVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) SSHomeViewModel *homeViewModel;
@property (nonatomic, strong) SSCircleViewModel *circleViewModel;
@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSHomeHeaderView *headerView;
@property (nonatomic, strong) SSSignInView *signView;

@end

@implementation SSHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.orderListTable];

    UIImageView *middleView = [[UIImageView alloc]init];
    middleView.frame = CGRectMake(0, 0, 150, 18);
    
//    middleView.contentMode =  UIViewContentModeScaleAspectFit;
//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
//    [middleView sd_setImageWithURL:[NSURL URLWithString:@"https://api.shosen.cn/app/img/mbc.png"] placeholderImage:nil];
    middleView.image = [UIImage imageNamed:@"home_title_imageview"];
    self.navigationItem.titleView = middleView;
    
    [self feltData];
    UIButton *right_button = [UIButton buttonWithType:UIButtonTypeCustom];
    right_button.frame = CGRectMake(0, 0, 28, 28);
    [right_button setImage:[UIImage imageNamed:@"home_qrcode"] forState:UIControlStateNormal];
    [right_button addTarget:self action:@selector(rightButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right_button];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    UIButton *left_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_button setTitle:@"北京" forState:UIControlStateNormal];
    left_button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [lxdforControlEvents:UIControlEventTouchUpInside];
    left_button.frame = CGRectMake(0, 0, 60, 30);
    [leftView addSubview:left_button];
    UIImageView *leftImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_arrow"]];
    leftImageview.frame = CGRectMake(60, 15, 13, 7);
    [leftView addSubview:leftImageview];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
//    [[SSLocationTool share]startLongTimeLocation];

}

- (void)leftButtonTapAction
{
    
}

- (void)rightButtonTapAction
{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSHomeCell *cell = [SSHomeCell cellWithTableView:tableView];
    SSNewsModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma --tableDelegate--

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 455;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSNewsModel *model = self.dataArray[indexPath.row];
    FZWebViewController *webVC = [[FZWebViewController alloc]init];
    webVC.title = @"资讯";
    webVC.loadUrl = model.linkUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"mine_order_null"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        WEAKSELF
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 50 - 20) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"ffffff");
        _orderListTable.emptyDataSetSource = self;
        _orderListTable.emptyDataSetDelegate = self;
        _orderListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf feltData];
            [weakSelf.orderListTable.mj_header endRefreshing];
        }];
        [_orderListTable.mj_header beginRefreshing];
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (void)feltData
{
    [self.circleViewModel userBannerListBannerListWithType:@"2" CallBack:^(id obj) {
        self.headerView.scrollView.imageURLStringsGroup = obj[@"data"];
    }];
    
    [self.homeViewModel newsCallBack:^(id json) {
        self.dataArray = [SSNewsModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        [self.orderListTable reloadData];
    }];
}

- (SSSignInView *)signView
{
    if (_signView == nil) {
        _signView = [[NSBundle mainBundle]loadNibNamed:@"SSSignInView" owner:self options:nil].lastObject;
        _signView.frame = CGRectMake(0, 0, kwidth, kheight);
    }
    return _signView;
}

- (SSHomeHeaderView *)headerView
{
    if (_headerView == nil) {
        WEAKSELF
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSHomeHeaderView" owner:self options:nil].lastObject;
        _headerView.block = ^(SSHomeHeaderViewType type) {
            if (type == SSHomeHeaderViewTypeBook) {
                SSCarConfigureVC *bookVC = [[SSCarConfigureVC alloc]init];
                [weakSelf.navigationController pushViewController:bookVC animated:YES];
            }else if(type == SSHomeHeaderViewTypeActive){
                [ProgressHUD showError:@"即将开放..."];
//                SSPrizeVC *prizeVC = [[SSPrizeVC alloc]init];
//                [weakSelf.navigationController pushViewController:prizeVC animated:YES];
            }else if (type == SSHomeHeaderViewTypeSignin)
            {
                [weakSelf.signView initViewWithType:SSSignInViewTypeSuccess];
                [weakSelf.signView showView];
            }else if (type == SSHomeHeaderViewTypeSigninFailure)
            {
                [weakSelf.signView initViewWithType:SSSignInViewTypeFailure];
                [weakSelf.signView showView];
            }else if (type == SSHomeHeaderViewTypeMall)
            {
                SSContributeDetailVC *infoVC = [[SSContributeDetailVC alloc]init];
                infoVC.title = @"会员中心";
                [weakSelf.navigationController pushViewController:infoVC animated:YES];
            }
            else if (type == SSHomeHeaderViewTypeMore)
            {
                FZWebViewController *webVC = [[FZWebViewController alloc]init];
                webVC.title = @"资讯";
                UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_back"]];
                webVC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:image];
                webVC.loadUrl = @"https://api.shosen.cn/news/news.html";
                [weakSelf.navigationController pushViewController:webVC animated:YES];
            }
        };
    }
    return _headerView;
}

- (SSHomeViewModel *)homeViewModel
{
    if (_homeViewModel == nil) {
        _homeViewModel = [[SSHomeViewModel alloc]init];
    }
    return _homeViewModel;
}

- (SSCircleViewModel *)circleViewModel
{
    if (_circleViewModel == nil) {
        _circleViewModel = [[SSCircleViewModel alloc]init];
    }
    return _circleViewModel;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
