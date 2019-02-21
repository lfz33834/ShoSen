//
//  SSMineBBSAssetVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineBBSAssetVC.h"
#import "SSMineAssetCell.h"
#import "SSMineAssetHeaderView.h"
#import "SSAssetModel.h"

@interface SSMineBBSAssetVC ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) SSMineAssetHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) UITableView      *mine_table;

@end

@implementation SSMineBBSAssetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"资产明细"];
    [self wr_setNavBarTintColor:kColor(@"D6B35B")];
    [self wr_setNavBarBarTintColor:kColor(@"D6B35B")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self.view addSubview:self.mine_table];
    [self feltData];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newbacks)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];
}

- (void)newbacks
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSMineAssetCell *cell = [SSMineAssetCell cellWithTableView:tableView];
    cell.oneTable_array = self.data_array;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 225;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.data_array.count * 33 + 60;
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

- (SSMineAssetHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSMineAssetHeaderView" owner:self options:nil].lastObject;
    }
    return _headerView;
}

- (void)feltData
{
    SSAccount *account = [SSAccountTool share].account;
    NSString *url = [NSString stringWithFormat:@"%@/base/xProList?phone=%@",BaseUrl,account.phone];
    [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        self.data_array = [SSAssetModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        [self.mine_table reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (NSMutableArray *)data_array
{
    if (_data_array == nil) {
        _data_array = [[NSMutableArray alloc]init];
    }
    return _data_array;
}

@end
