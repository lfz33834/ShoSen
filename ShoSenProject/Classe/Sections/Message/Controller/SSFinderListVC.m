//
//  SSFinderListVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/1.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSFinderListVC.h"
#import "SSCircleFriendsCell.h"
#import "SSCircleMessageVC.h"
#import "SSMessageDetailVC.h"
#import "SSCircleListModel.h"
#import "SSCircleListCell.h"
#import "SSMessageDetailVC.h"
#import "SSCircleFriendRecommendVC.h"
#import "SSCircleViewModel.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "SSFriendHomeVC.h"

@interface SSFinderListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *followArray;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) SSCircleViewModel *viewModel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) SDCycleScrollView *scrollView;

@property (nonatomic, assign) int pageNum;

@end

@implementation SSFinderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self setTitle:@"发现"];
    [self feltData];
    [self.view addSubview:self.orderListTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:KrefreshFinder object:nil];
}

- (void)refreshData
{
    [self feltData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        SSCircleFriendsCell *cell = [SSCircleFriendsCell cellWithTableView:tableView];
        cell.cellType = SSCircleFriendsCellTypeFinder;
        [cell initCellWithDataArray:self.followArray];
        cell.block = ^(SSCircleListModel *model,SSCircleFriendsCellType type) {
            if (type == SSCircleFriendsCellTypeFinder) {
                SSCircleFriendRecommendVC *friendVC = [[SSCircleFriendRecommendVC alloc]init];
                friendVC.type = SSCircleVCTypeRecommend;
                [self.navigationController pushViewController:friendVC animated:YES];
            }else{
                SSFriendHomeVC *homeVC = [[SSFriendHomeVC alloc]init];
                model.userId = model.ID;
                homeVC.listModel = model;
                homeVC.vcType = SSFriendHomeVCTypeOthers;
                [self.navigationController pushViewController:homeVC animated:YES];
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    SSCircleListCell *cell = [SSCircleListCell cellWithTableView:tableView];
    SSCircleListModel *model = self.dataArray[indexPath.row - 1];
    [cell initCellWithModel:model index:indexPath.row];
    cell.block = ^(SSCircleListCellType cellType, SSCircleListModel *circleModel , NSInteger index) {
        if (cellType == SSCircleListCellTypeMessage) {
            SSMessageDetailVC *messageDetailVC = [[SSMessageDetailVC alloc]init];
            messageDetailVC.model = circleModel;
            [self.navigationController pushViewController:messageDetailVC animated:YES];
        }else if (cellType == SSCircleListCellTypeDianzan)
        {
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:circleModel];
        }else if (cellType == SSCircleListCellTypeUserInfo)
        {
            SSAccount *account = [SSAccountTool share].account;
            SSFriendHomeVC *homeVC = [[SSFriendHomeVC alloc]init];
            homeVC.listModel = circleModel;
            if ([account.uid intValue] == [circleModel.userId intValue]) {
                homeVC.vcType = SSFriendHomeVCTypeSelf;
            }else{
                homeVC.vcType = SSFriendHomeVCTypeOthers;
            }
            [self.navigationController pushViewController:homeVC animated:YES];
        } else if (cellType == SSCircleListCellTypeUserZhanKai){
            model.isUnfold = !circleModel.isUnfold;
            //1.当前所要刷新的cell，传入要刷新的 行数 和 组数
            NSIndexPath *indexCell = [NSIndexPath indexPathForRow:index inSection:0];
            //2.将indexPath添加到数组
            NSArray <NSIndexPath *> *indexPathArray = @[indexCell];
            //3.传入数组，对当前cell进行刷新
            [self.orderListTable reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        SSCircleListModel *model = self.dataArray[indexPath.row - 1];
        SSMessageDetailVC *messageDetailVC = [[SSMessageDetailVC alloc]init];
        messageDetailVC.model = model;
        [self.navigationController pushViewController:messageDetailVC animated:YES];
    }
}

#pragma --tableDelegate--

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 170;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 185;
    }
    SSCircleListModel *model = self.dataArray[indexPath.row - 1];
    if (model.contentHeight > 120 && model.isUnfold) {
        return model.contentHeight+model.bottomViewHeight+model.imageHeight+ 110 + 30;
    }else if(model.contentHeight > 120 && !model.isUnfold){
        return 120+model.bottomViewHeight+model.imageHeight+ cellContentHeight;
    }
    return model.contentHeight+model.bottomViewHeight+model.imageHeight+ 110 + 30;
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
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 40 - 20) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"f8f8f8");
        _orderListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageNum = 1;
            [weakSelf feltData];
            [weakSelf.orderListTable.mj_header endRefreshing];
        }];
        _orderListTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.pageNum ++;
            [self feltData];
            [self.orderListTable.mj_footer endRefreshing];
        }];
        _orderListTable.emptyDataSetSource = self;
        _orderListTable.emptyDataSetDelegate = self;
        _orderListTable.mj_footer.automaticallyHidden = YES;
        [_orderListTable.mj_header beginRefreshing];
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (void)feltData
{
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];

    [self.viewModel userCircleFriendInvitationWithPageNum:@"1" CallBack:^(id obj) {
        self.followArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
        [self.orderListTable reloadData];
    }];//推荐列表

    [self.viewModel userCircleHotTopWithPageNum:pageNumStr CallBack:^(id obj) {
        if (self.pageNum == 1) {
            [self.dataArray removeAllObjects];
            self.dataArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
        }else{
            NSArray *moreArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
            [self.dataArray addObjectsFromArray:moreArray];
            if (moreArray.count < 10) {
                [self.orderListTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.orderListTable reloadData];
    }];//热门话题
    
    [self.viewModel userBannerListBannerListWithType:@"1" CallBack:^(id obj) {
        self.bannerArray = obj[@"data"];
        self.scrollView.imageURLStringsGroup = self.bannerArray;
        [self.orderListTable reloadData];
    }];//banner 列表
    
}

- (SSCircleViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSCircleViewModel alloc]init];
    }
    return _viewModel;
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, 170)];
        _headerView.backgroundColor = kColor(@"ffffff");
        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(15, 15, kwidth - 30, 140) delegate:self placeholderImage:[UIImage imageNamed:@"circle_placeholder_1"]];
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        self.scrollView = cycleScrollView2;
        [_headerView addSubview:cycleScrollView2];
//         block监听点击方式
         cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
         NSLog(@">>>>>  %ld", (long)index);
         };
    }
    return _headerView;
}

- (NSMutableArray *)bannerArray
{
    if (_bannerArray == nil) {
        _bannerArray = [[NSMutableArray alloc]init];
    }
    return _bannerArray;
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray *)followArray
{
    if (_followArray == nil) {
        _followArray = [[NSMutableArray alloc]init];
    }
    return _followArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
