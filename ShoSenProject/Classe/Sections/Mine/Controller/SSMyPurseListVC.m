//
//  SSMyPurseListVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/21.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMyPurseListVC.h"
#import "SSMienPurseCell.h"
#import "SSMyPurseViewModel.h"
#import "SSMyPurseListModel.h"

@interface SSMyPurseListVC ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSMutableArray   *data_array;
 @property (nonatomic, strong) UITableView      *mine_table;
@property (nonatomic, strong) SSMyPurseViewModel *viewModel;

@end

@implementation SSMyPurseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mine_table];
    
    if (self.vcType == SSMyPurseListVCTypeYue) {
        [self feltYue];
    }else if (self.vcType == SSMyPurseListVCTypeJiFen){
        [self feltJifen];
    }
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSMienPurseCell *cell = [SSMienPurseCell cellWithTableView:tableView];
    SSMyPurseListModel *model  = self.data_array[indexPath.row];
    if (self.vcType == SSMyPurseListVCTypeYue) {
        [cell initCellWithModel:model cellType:SSMienPurseCellTypeYue];
    }else if (self.vcType == SSMyPurseListVCTypeJiFen){
        [cell initCellWithModel:model cellType:SSMienPurseCellTypeJiFen];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"mine_order_null"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无明细";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UITableView *)mine_table
{
    if (!_mine_table) {
        _mine_table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - kTopHeight - kTabBarHeight) style:UITableViewStylePlain];
        _mine_table.delegate = self;
        _mine_table.dataSource = self;
        _mine_table.emptyDataSetSource = self;
        _mine_table.emptyDataSetDelegate = self;
        _mine_table.backgroundColor = kColor(@"f8f8f8");
        _mine_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mine_table;
}

- (void)feltYue
{
    [self.viewModel myPurseYueCallback:^(id  _Nonnull object) {
        self.data_array = [SSMyPurseListModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        [self.mine_table reloadData];
    }];
}

- (void)feltJifen
{
    [self.viewModel myPurseJiFenCallback:^(id  _Nonnull object) {
        self.data_array = [SSMyPurseListModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        [self.mine_table reloadData];
    }];
}

- (SSMyPurseViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSMyPurseViewModel alloc]init];
    }
    
   return _viewModel;
}

@end
