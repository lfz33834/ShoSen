//
//  SSCircleFriendRecommendVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleFriendRecommendVC.h"
#import "SSCircleFriendRecommendCell.h"
#import "SSCircleViewModel.h"
#import "SSCircleListModel.h"

@interface SSCircleFriendRecommendVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSCircleViewModel *viewModel;
 
@end

@implementation SSCircleFriendRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"好友推荐"];
    [self.view addSubview:self.orderListTable];
    if (self.type == SSCircleVCTypeRecommend) {
        [self setTitle:@"好友推荐"];
    }else if (self.type == SSCircleVCTypeFollow)
    {
        [self setTitle:@"关注"];
    }else if (self.type == SSCircleVCTypeFans)
    {
        [self setTitle:@"我的粉丝"];
    }
    [self feltData];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSCircleFriendRecommendCell *cell = [SSCircleFriendRecommendCell cellWithTableView:tableView];
    SSCircleListModel *circleModel = self.dataArray[indexPath.row];
    if (self.type == SSCircleVCTypeFans)
    {
        cell.type = SSCircleFriendRecommendCellTypeFans;
    }
    [cell initCellWithModel:circleModel];
    cell.block = ^(SSCircleListModel *model) {
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        [self.orderListTable reloadData];
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
 
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header_view = [[UIView alloc]init];
    header_view.backgroundColor = kColor(@"ffffff");
    UILabel *title_label = [[UILabel alloc]init];
    title_label.frame = CGRectMake(20, 15, 150, 20);
    title_label.font = [UIFont systemFontOfSize:15];
    title_label.textAlignment = NSTextAlignmentLeft;
    title_label.backgroundColor = kColor(@"ffffff");
    title_label.text = @"推荐关注";
    [header_view addSubview:title_label];
    return header_view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.type == SSCircleVCTypeRecommend) {
        return 45;
    }else if (self.type == SSCircleVCTypeFollow)
    {
        return 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"circle_order_null"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"";
    if (self.type == SSCircleVCTypeRecommend) {
        [self setTitle:@"好友推荐"];
        title = @"暂无好友推荐";
    }else if (self.type == SSCircleVCTypeFollow)
    {
        [self setTitle:@"关注"];
        title = @"暂无关注";
    }else if (self.type == SSCircleVCTypeFans)
    {
        [self setTitle:@"我的粉丝"];
        title = @"暂无粉丝";
    }
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

- (void)feltData
{
    if (self.type == SSCircleVCTypeRecommend) {
        [self.viewModel userCircleFriendInvitationWithPageNum:@"2" CallBack:^(id obj) {
            NSLog(@"%@",obj);
            self.dataArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
            [self.dataArray enumerateObjectsUsingBlock:^(SSCircleListModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.isFollow = NO;
            }];
            [self.orderListTable reloadData];
        }];
    }else if (self.type == SSCircleVCTypeFollow)
    {
        SSAccount *account = [SSAccountTool share].account;
        [self.viewModel userCircleSelfFollowWithUserId:account.uid PageNum:@"1" CallBack:^(id obj) {
            self.dataArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
            [self.dataArray enumerateObjectsUsingBlock:^(SSCircleListModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.isFollow = YES;
             }];
            [self.orderListTable reloadData];
        }];
    }else if (self.type == SSCircleVCTypeFans){
        [self.viewModel circleUserCircleSelectFansWithPageNum:@"1" allBack:^(id obj) {
            self.dataArray = [SSCircleListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
            [self.dataArray enumerateObjectsUsingBlock:^(SSCircleListModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if([obj.eachOther intValue] == 1)
                {
                    obj.isFollow = YES;
                }else{
                    obj.isFollow = NO;
                }
            }];
            [self.orderListTable reloadData];
        }];
    }
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
