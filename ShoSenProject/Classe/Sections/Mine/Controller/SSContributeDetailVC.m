//
//  SSContributeDetailVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSContributeDetailVC.h"
#import "SSContributeHeaderView.h"
#import "SSContributeListVC.h"
#import "SSFlagsModel.h"
#import "SSContributeDataVC.h"

@interface SSContributeDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SSContributeHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) UITableView      *orderListTable;

@end

@implementation SSContributeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"会员中心"];
    [self.view addSubview:self.orderListTable];
    [self feltData];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1400;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (void)feltData
{
    SSAccount *account = [SSAccountTool share].account;
    NSString *url = [NSString stringWithFormat:@"%@/base/contriToday?phone=%@",BaseUrl,account.phone];
    [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        NSArray *listArray = json[@"data"];
        if (listArray.count == 0) {
            self.headerView.contributeNum_label.text = [NSString stringWithFormat:@"+ %@",@"0"];
        }else{
            __block int sunum = 0;
            NSMutableArray *dataArray = [SSFlagsModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [dataArray enumerateObjectsUsingBlock:^(SSFlagsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                sunum += [obj.typeValue intValue];
            }];
            self.headerView.contributeNum_label.text = [NSString stringWithFormat:@"+ %d",sunum];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 64) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"f8f8f8");
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (SSContributeHeaderView *)headerView
{
    if (_headerView == nil) {
        WEAKSELF
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSContributeHeaderView" owner:self options:nil].lastObject;
        _headerView.block = ^{
            SSContributeDataVC *listVC = [[SSContributeDataVC alloc]init];
            [weakSelf.navigationController pushViewController:listVC animated:YES];
        };
    }
    return _headerView;
}

@end
