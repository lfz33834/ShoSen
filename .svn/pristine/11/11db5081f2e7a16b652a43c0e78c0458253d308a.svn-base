//
//  SSMinePerkVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/20.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMinePerkVC.h"
#import "SSMinePerkCell.h"
#import "SSPerkHeaderView.h"
#import "SSMinePerkDetailVC.h"
#import "SSMineAllPerkDetailVC.h"

@interface SSMinePerkVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SSPerkHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) UITableView      *mine_table;
@property (nonatomic, strong) NSDictionary     *dicData;

@end

@implementation SSMinePerkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的津贴"];
    [self.view addSubview:self.mine_table];
    [self feltData];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSMinePerkCell *cell = [SSMinePerkCell cellWithTableView:tableView];
    cell.dicData = self.dicData;
    WEAKSELF
    cell.block = ^{
        SSMinePerkDetailVC *detailVC = [[SSMinePerkDetailVC alloc]init];
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    };
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 235;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 330;
}


- (UITableView *)mine_table
{
    if (!_mine_table) {
        _mine_table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
        _mine_table.delegate = self;
        _mine_table.dataSource = self;
         _mine_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mine_table;
}

- (SSPerkHeaderView *)headerView
{
    if (_headerView == nil) {
        WEAKSELF
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSPerkHeaderView" owner:self options:nil].lastObject;
        _headerView.block = ^(SSPerkHeaderType type) {
            if (type == SSPerkHeaderTypeWithDraw) {
                
            }else if (type == SSPerkHeaderTypeInfo)
            {
                SSMineAllPerkDetailVC *detailVC = [[SSMineAllPerkDetailVC alloc]init];
                [weakSelf.navigationController pushViewController:detailVC animated:YES];
            }
        };
    }
    return _headerView;
}

- (void)feltData
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *paramsDic = @{@"phone":account.phone};
    [FZHttpTool post:UserRewardTotal parameters:paramsDic isShowHUD:YES httpToolSuccess:^(id json) {
        self.dicData = json[@"data"];
        [self.mine_table reloadData];
    } failure:^(NSError *error) {
        [ProgressHUD showSuccess:@"请求失败"];
    }];
}
//createTime = 1539224579;
//id = 34;
//invitSum = 2;
//reward = 2000;
//rewardMonth = 3;
//rewardRemark = "";
//rewardedMoney = 6000;
//updateTime = 1539224589;
//userPhone = 17801058804;

@end
