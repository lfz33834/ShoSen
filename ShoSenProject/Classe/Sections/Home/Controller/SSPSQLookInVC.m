//
//  SSPSQLookInVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/15.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPSQLookInVC.h"
#import "SSPSQLookInHeaderView.h"
#import "SSPSQLookInCell.h"
#import "SSHomeModel.h"
#import "SSOrderFooterView.h"
#import "SSConfirmBookVC.h"
#import "SSHomeViewModel.h"

@interface SSPSQLookInVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSPSQLookInHeaderView *headerView;
@property (nonatomic, strong) SSOrderFooterView *orderView;
@property (nonatomic, strong) SSHomeViewModel *viewModel;

@end

@implementation SSPSQLookInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"问卷调查"];
    [self.view addSubview:self.orderListTable];
    [self.view addSubview:self.orderView];
    [self feltData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSPSQLookInCell *cell = [SSPSQLookInCell cellWithTableView:tableView];
    SSHomeModel *model  = self.dataArray[indexPath.row];
    [cell initCellWithModel:model];
    cell.block = ^(SSHomeModel *returnModel) {
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
    };
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
    return 190;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSHomeModel *model  = self.dataArray[indexPath.row];
    return model.cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)feltData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"questionnaire" ofType:@"json"];
    NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:nil];
    self.dataArray = [SSHomeModel mj_objectArrayWithKeyValuesArray:jsonObject];
    [self.orderListTable reloadData];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 50 - 20) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"ffffff");
         _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (void)viewWillLayoutSubviews
{
    _orderView.frame = CGRectMake(0, kheight-kTopHeight-55, kwidth, 55);
}

- (SSOrderFooterView *)orderView
{
    if (_orderView == nil) {
        WEAKSELF
        _orderView = [[NSBundle mainBundle]loadNibNamed:@"SSOrderFooterView" owner:self options:nil].lastObject;
        [_orderView initWithViewWithType:OrderFooterViewTypePSQLookIn operateType:0];
        _orderView.block = ^(OrderFooterOperateType type) {
            if (type == OrderFooterOperateTypeCancel) {
                SSConfirmBookVC *bookVC = [[SSConfirmBookVC alloc]init];
                [weakSelf.navigationController pushViewController:bookVC animated:YES];
            }else{
                __block int answerNum = 0;
                [weakSelf.dataArray enumerateObjectsUsingBlock:^(SSHomeModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.isSelected) {
                        answerNum ++;
                    }
                }];
                if (answerNum == 9 ) {
                    [weakSelf.viewModel psqLookinWithModel:weakSelf.dataArray callBack:^(id json) {
                        SSConfirmBookVC *bookVC = [[SSConfirmBookVC alloc]init];
                        [weakSelf.navigationController pushViewController:bookVC animated:YES];
                    }];
                }else{
                    [ProgressHUD showSuccess:@"请回答问卷所有问题"];
                }
            }
        };
    }
    return _orderView;
}

- (SSHomeViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSHomeViewModel alloc]init];
    }
    return _viewModel;
}

- (SSPSQLookInHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSPSQLookInHeaderView" owner:self options:nil].lastObject;
    }
    return _headerView;
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
