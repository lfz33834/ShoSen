//
//  SSCircleMessageVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/22.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleMessageVC.h"
#import "SSCircleMessageCell.h"
#import "SSCircleListModel.h"
#import "SSCircleViewModel.h"
#import "SSMessageDetailVC.h"

@interface SSCircleMessageVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSCircleViewModel *viewModel;
@property (nonatomic, assign) int pageNum;

@end

@implementation SSCircleMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self.view addSubview:self.orderListTable];
    [self setTitle:@"我的消息"];
    [self feltData];
    
 }


#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSCircleMessageCell *cell = [SSCircleMessageCell cellWithTableView:tableView];
    SSCircleListModel *listModel = self.dataArray[indexPath.row];
    [cell initCellWithListModel:listModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SSCircleListModel *model = self.dataArray[indexPath.row];
    SSMessageDetailVC *messageDetailVC = [[SSMessageDetailVC alloc]init];
    messageDetailVC.model = model;
    [self.navigationController pushViewController:messageDetailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"mine_order_null"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无消息";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (SSCircleViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSCircleViewModel alloc]init];
    }
    return _viewModel;
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"f8f8f8");
        _orderListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageNum = 1;
            [self feltData];
            [self.orderListTable.mj_header endRefreshing];
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
    if (self.type == SSCircleMessageVCTypeMessage) {
        
        NSString *pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
        [self.viewModel circleMyReMesssageWithPageNum:pageNumStr allBack:^(id obj) {
            
            if (self.pageNum == 1) {
                self.dataArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
            }else{
                NSArray *moreArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [self.dataArray addObjectsFromArray:moreArray];
                if (moreArray.count < 10) {
                    [self.orderListTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [self.orderListTable reloadData];
        }];
        
    }else if (self.type == SSCircleMessageVCTypeNotices)
    {
        [self.viewModel circleNoticeMessCallBack:^(id obj) {
            self.dataArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
            [self.orderListTable reloadData];
        }];
    }
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
