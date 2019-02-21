

//
//  SSCircleListVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/22.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleListVC.h"
#import "SSCircleListCell.h"
#import "SSCirclePublishVC.h"
#import "SSCircleListHeaderView.h"
#import "SSCircleMessageVC.h"
#import "SSMessageDetailVC.h"
#import "SSCircleListModel.h"
#import "SSFriendHomeVC.h"
#import "SSCircleViewModel.h"


@interface SSCircleListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *publish_button;
@property (nonatomic, strong) SSCircleViewModel *viewModel;
@property (nonatomic, strong) SSCircleListHeaderView  *headerView;
@property (nonatomic, assign) int pageNum;

@end

@implementation SSCircleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self feltData];
    [self.view addSubview:self.orderListTable];
    [self.view addSubview:self.publish_button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:KrefreshCircle object:nil];
}

- (void)refreshData
{
    [self feltData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)refreshDataAction
{
    [self feltData];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSCircleListCell *cell = [SSCircleListCell cellWithTableView:tableView];
    SSCircleListModel *model = self.dataArray[indexPath.row];
    [cell initCellWithModel:model index:indexPath.row];
    SSAccount *account = [SSAccountTool share].account;
    if ([account.uid intValue] == [model.userId intValue]) {
        cell.del_button.hidden = NO;
    }
    cell.block = ^(SSCircleListCellType cellType,SSCircleListModel *circlModel, NSInteger index) {
        if (cellType == SSCircleListCellTypeMessage) {
            SSMessageDetailVC *messageDetailVC = [[SSMessageDetailVC alloc]init];
            messageDetailVC.model = model;
            [self.navigationController pushViewController:messageDetailVC animated:YES];
        }else if (cellType == SSCircleListCellTypeDianzan)
        {
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:circlModel];
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
        }else if (cellType == SSCircleListCellTypeUserZhanKai){
            model.isUnfold = !circlModel.isUnfold;
            //1.当前所要刷新的cell，传入要刷新的 行数 和 组数
            NSIndexPath *indexCell = [NSIndexPath indexPathForRow:index inSection:0];
            //2.将indexPath添加到数组
            NSArray <NSIndexPath *> *indexPathArray = @[indexCell];
            //3.传入数组，对当前cell进行刷新
            [self.orderListTable reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
            
//            [self.orderListTable reloadData];
        }else if (cellType == SSCircleListCellTypeUserDel)
        {
            WEAKSELF
            [self.viewModel delMessageWithMessageID:circlModel.ID callBack:^(id obj) {
                weakSelf.pageNum = 1;
                [ProgressHUD showSuccess:@"删除成功"];
                [weakSelf feltData];
            }];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSCircleListModel *model = self.dataArray[indexPath.row];
    SSMessageDetailVC *messageDetailVC = [[SSMessageDetailVC alloc]init];
    messageDetailVC.model = model;
    [self.navigationController pushViewController:messageDetailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *numString = [[NSUserDefaults standardUserDefaults] objectForKey:@"CIRCLEMESSGENUM"];
    if ([numString intValue] > 0) {
        self.headerView.hidden = NO;
        [self.headerView.title_button setTitle:[NSString stringWithFormat:@"%@条未读消息",numString] forState:UIControlStateNormal];
    }else{
        self.headerView.hidden = YES;
    }
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *numString = [[NSUserDefaults standardUserDefaults] objectForKey:@"CIRCLEMESSGENUM"];
    if ([numString intValue] > 0) {
        return 75;
    }
    return 30;
}

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
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (void)pushlishCircleAction
{
    SSCirclePublishVC *publishVC = [[SSCirclePublishVC alloc]init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 50 - 20) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"ffffff");
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
        _orderListTable.mj_footer.automaticallyHidden = YES;
        _orderListTable.emptyDataSetSource = self;
        _orderListTable.emptyDataSetDelegate = self;
        [_orderListTable.mj_header beginRefreshing];
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (void)feltData
{
    SSAccount *account = [SSAccountTool share].account;
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
    NSDictionary *params = @{@"userId":account.uid,@"pageNum":pageNumStr};
    [FZHttpTool post:UserCircleMessageList parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        if (self.pageNum == 1) {
            self.dataArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.orderListTable reloadData];
        }else{
            NSArray *moreArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.dataArray addObjectsFromArray:moreArray];
            [self.orderListTable reloadData];
            if (moreArray.count < 10) {
                [self.orderListTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
      }];
}

- (void)messagelistTapAction
{
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"CIRCLEMESSGENUM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    SSCircleMessageVC *messageVC = [[SSCircleMessageVC alloc]init];
    messageVC.type = SSCircleMessageVCTypeNotices;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (SSCircleListHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSCircleListHeaderView" owner:self options:nil].lastObject;
        [_headerView.title_button addTarget:self action:@selector(messagelistTapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

- (UIButton *)publish_button
{
    if (_publish_button == nil) {
        _publish_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _publish_button.frame = CGRectMake(kwidth - 80, kheight - 150 - kTabBarHeight - 46, 46, 46);
        [_publish_button setImage:[UIImage imageNamed:@"circle_submit"] forState:UIControlStateNormal];
        [_publish_button setAdjustsImageWhenHighlighted:NO];
        [_publish_button addTarget:self action:@selector(pushlishCircleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publish_button;
}

- (SSCircleViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSCircleViewModel alloc]init];
    }
    return _viewModel;
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
