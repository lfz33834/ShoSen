//
//  SSMineOrderListVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineOrderListVC.h"
#import "SSOrderListCell.h"
#import "SSOrderListPayCell.h"
#import "SSOrderDetailVC.h"
#import "SSOrderListModel.h"
#import "SSOrderListViewModel.h"
#import "SSPayOrderVC.h"

@interface SSMineOrderListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSOrderListViewModel *viewModel;

@end

@implementation SSMineOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[SSOrderListViewModel alloc]init];
    [self.view addSubview:self.orderListTable];
    [self setTitle:@"MAX订单"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self feltData];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSOrderListModel *model = self.dataArray[indexPath.row];
    if ([model.bookStatus intValue] != 1) {
        SSOrderListCell *cell = [SSOrderListCell cellWithTableView:tableView];
        cell.listModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    SSOrderListPayCell *cell = [SSOrderListPayCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.listModel = model;
    cell.block = ^(SSOrderListModel *model) {
        SSPayOrderVC *bookVC = [[SSPayOrderVC alloc]init];
        bookVC.bookID = model.ID;
        bookVC.viewType = SSPayOrderVCTypeCar;
        [self.navigationController pushViewController:bookVC animated:YES];
    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSOrderListModel *model = self.dataArray[indexPath.row];
    if ([model.bookStatus intValue] != 1) {
        return 260;
    }
    return 308;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSOrderDetailVC *detailVC = [[SSOrderDetailVC alloc]init];
    SSOrderListModel *model = self.dataArray[indexPath.row];
    detailVC.vcType = model.bookStatus;
    detailVC.bookId = model.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
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
    NSString *title = @"暂无订单";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (void)feltData
{
    WEAKSELF
    [self.viewModel feltOrderListWithBookPhone:nil callBack:^(NSMutableArray *dataList) {
        weakSelf.dataArray = dataList;
        [weakSelf.orderListTable reloadData];
    }];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        WEAKSELF
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"f8f8f8");
        _orderListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
 //            [self.viewModel.refreshCommand execute:self.tableView];
            [weakSelf.orderListTable.mj_header endRefreshing];
        }];
        _orderListTable.emptyDataSetSource = self;
        _orderListTable.emptyDataSetDelegate = self;
        _orderListTable.mj_footer.automaticallyHidden = YES;
        [_orderListTable.mj_header beginRefreshing];
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
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
