//
//  SSMineAssetCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineAssetCell.h"
#import "SSMineAssetItemCell.h"

@interface SSMineAssetCell()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation SSMineAssetCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.main_table.delegate = self;
    self.main_table.dataSource = self;
    self.main_table.scrollEnabled = NO;
    self.main_table.separatorStyle =  UITableViewCellSeparatorStyleNone;
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     SSMineAssetItemCell *cell = [SSMineAssetItemCell cellWithTableView:tableView];
    SSPerkDetailListModel *model;
    if(indexPath.row > 0)
    {
        model = self.oneTable_array[indexPath.row - 1];
    }
    [cell initCellWithModel:model index:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.oneTable_array.count + 1;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
 }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 25;
    }
    return 33;
}

- (void)feltData
{
//    SSAccount *account = [SSAccountTool share].account;
//    NSDictionary *paramsDic = @{@"phone":account.phone};
//    [FZHttpTool post:UserRewardTotal parameters:paramsDic isShowHUD:YES httpToolSuccess:^(id json) {
//
//    } failure:^(NSError *error) {
//        [ProgressHUD showSuccess:@"请求失败"];
//    }];
}

- (NSMutableArray *)oneTable_array
{
    if (_oneTable_array == nil) {
        _oneTable_array = [[NSMutableArray alloc]init];
        SSPerkDetailListModel *model1 = [[SSPerkDetailListModel alloc]init];
        model1.dateString = @"2018-09";
        model1.nameString = @"你好啊";
        model1.phoneString = @"1234567";
        model1.moneyString = @"￥234";
        [_oneTable_array addObject:model1];
        SSPerkDetailListModel *model2 = [[SSPerkDetailListModel alloc]init];
        model2.dateString = @"2018-09";
        model2.nameString = @"你好啊";
        model2.phoneString = @"1234567";
        model2.moneyString = @"￥234";
        [_oneTable_array addObject:model2];
        SSPerkDetailListModel *model3 = [[SSPerkDetailListModel alloc]init];
        model3.dateString = @"2018-09";
        model3.nameString = @"你好啊";
        model3.phoneString = @"1234567";
        model3.moneyString = @"￥234";
        [_oneTable_array addObject:model3];
    }
    return _oneTable_array;
}

@end
