//
//  SSContributeListVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSContributeListVC.h"
#import "SSContributeDetailCell.h"
#import "SSFlagsModel.h"


@interface SSContributeListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) UITableView      *mine_table;
@property (nonatomic, assign) int pageIndex;

@end

@implementation SSContributeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 1;
    [self setTitle:@"贡献值明细"];
    [self.view addSubview:self.mine_table];
    [self feltDataWithPage:self.pageIndex];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSContributeDetailCell *cell = [SSContributeDetailCell cellWithTableView:tableView];
    if (self.data_array.count > 0) {
        SSFlagsModel *model = self.data_array[indexPath.row];
        [cell initCellWithModle:model];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data_array.count;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [UIView new];
}

- (void)feltDataWithPage:(int )page
{
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    SSAccount *account = [SSAccountTool share].account;
    if (self.type == SSContributeListVCTypeCurrent) {
        NSString *url = [NSString stringWithFormat:@"%@/base/contriToday?phone=%@",BaseUrl,account.phone];
        [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
            self.data_array = [SSFlagsModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.mine_table reloadData];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }else if (self.type == SSContributeListVCTypeAll)
    {
        NSString *url = [NSString stringWithFormat:@"%@/base/contriList?phone=%@&pageNum=%@",BaseUrl,account.phone,pageStr];
        [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
            self.data_array = [SSFlagsModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.mine_table reloadData];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}

- (UITableView *)mine_table
{
    if (!_mine_table) {
        _mine_table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
        _mine_table.delegate = self;
        _mine_table.dataSource = self;
        _mine_table.backgroundColor = kColor(@"f8f8f8");
        _mine_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mine_table;
}

- (NSMutableArray *)data_array
{
    if (_data_array == nil) {
        _data_array = [[NSMutableArray alloc]init];
    }
    return  _data_array;
}

@end
