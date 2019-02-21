

//
//  SSCircleTopicVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/1.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleTopicVC.h"
#import "SSCircleSearchView.h"
#import "SSCircleListCell.h"
#import "SSCircleListHeaderView.h"
#import "SSCircleMessageVC.h"
#import "SSMessageDetailVC.h"
#import "SSCircleListModel.h"
#import "SSFriendHomeVC.h"
#import "SSCircleViewModel.h"

@interface SSCircleTopicVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) SSCircleSearchView *searchView;
@property (nonatomic, strong) SSCircleViewModel *viewModel;
@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, copy)   NSString *contentStr;

@end

@implementation SSCircleTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    self.contentStr = @"";
    [self setTitle:@"我的话题"];
    [self.view addSubview:self.orderListTable];
    [self.view addSubview:self.searchView];
    [self feltData];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSCircleListCell *cell = [SSCircleListCell cellWithTableView:tableView];
    SSCircleListModel *model = self.dataArray[indexPath.row];
    [cell initCellWithModel:model index:indexPath.row];
    cell.del_button.hidden = NO;
     cell.block = ^(SSCircleListCellType cellType,SSCircleListModel *circlModel, NSInteger index) {
        if (cellType == SSCircleListCellTypeMessage) {
            SSMessageDetailVC *messageDetailVC = [[SSMessageDetailVC alloc]init];
            messageDetailVC.model = model;
            [self.navigationController pushViewController:messageDetailVC animated:YES];
        }else if (cellType == SSCircleListCellTypeDianzan)
        {
            
        }else if (cellType == SSCircleListCellTypeUserInfo)
        {
            SSAccount *account = [SSAccountTool share].account;
            SSFriendHomeVC *homeVC = [[SSFriendHomeVC alloc]init];
            homeVC.listModel = circlModel;
            if ([account.uid intValue] == [circlModel.userId intValue]) {
                homeVC.vcType = SSFriendHomeVCTypeSelf;
            }else{
                homeVC.vcType = SSFriendHomeVCTypeFriends;
            }
            [self.navigationController pushViewController:homeVC animated:YES];
        }else if (cellType == SSCircleListCellTypeUserDel)
        {
            [self.viewModel delMessageWithMessageID:circlModel.ID callBack:^(id obj) {
                self.pageNum = 1;
                [ProgressHUD showSuccess:@"删除成功"];
                [self feltData];
            }];
        }else if (cellType == SSCircleListCellTypeUserZhanKai){
            model.isUnfold = !circlModel.isUnfold;
            
            //1.当前所要刷新的cell，传入要刷新的 行数 和 组数
            NSIndexPath *indexCell = [NSIndexPath indexPathForRow:index inSection:0];
            //2.将indexPath添加到数组
            NSArray <NSIndexPath *> *indexPathArray = @[indexCell];
            //3.传入数组，对当前cell进行刷新
            [self.orderListTable reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
            
//            [self.orderListTable reloadData];
        }
    };
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
    SSCircleListModel *model = self.dataArray[indexPath.row];
 
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
    NSString *title = @"暂无话题";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, kwidth, kheight - 50 - 20) style:UITableViewStylePlain];
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
    SSAccount *account = [SSAccountTool share].account;
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
    [self.viewModel userCircleSelfMessageWithUserId:account.uid content:self.contentStr PageNum:pageNumStr  CallBack:^(id obj) {
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
}

- (void)messagelistTapAction
{
    SSCircleMessageVC *messageVC = [[SSCircleMessageVC alloc]init];
    messageVC.type = SSCircleMessageVCTypeMessage;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (SSCircleViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSCircleViewModel alloc]init];
    }
    return _viewModel;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _searchView.frame = CGRectMake(0, 0, kwidth, 80);

}

- (SSCircleSearchView *)searchView
{
    if (_searchView == nil) {
        WEAKSELF
        _searchView = [[NSBundle mainBundle]loadNibNamed:@"SSCircleSearchView" owner:self options:nil].lastObject;
        _searchView.block = ^(NSString *content) {
            weakSelf.pageNum = 1;
            weakSelf.contentStr = content;
            [weakSelf feltData];
        };
    }
    return _searchView;
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