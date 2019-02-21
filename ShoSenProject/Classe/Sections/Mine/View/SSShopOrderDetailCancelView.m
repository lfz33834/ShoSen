//
//  SSShopOrderDetailCancelView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderDetailCancelView.h"
#import "SSOrderDetailCancelCell.h"

@interface SSShopOrderDetailCancelView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation SSShopOrderDetailCancelView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.item_tableview.delegate = self;
    self.item_tableview.dataSource = self;
    self.item_tableview.backgroundColor = kColor(@"f8f8f8");
    self.item_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.selectIndex = -1;
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSOrderDetailCancelCell *cell = [SSOrderDetailCancelCell cellWithTableView:tableView];
    SSOrderListModel *model = self.dataArray[indexPath.row];
    if (indexPath.row == self.selectIndex) {
        [cell initWithCellWithModel:model isSelected:YES];
    }else{
        [cell initWithCellWithModel:model isSelected:NO];
    }
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
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndex = indexPath.row;
    [self.item_tableview reloadData];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
        SSOrderListModel *model1 = [[SSOrderListModel alloc]init];
        model1.isSelected = NO;
        model1.titleString = @"信息填错";
        [_dataArray addObject:model1];
        SSOrderListModel *model2 = [[SSOrderListModel alloc]init];
        model2.isSelected = NO;
        model2.titleString = @"重复下单";
        [_dataArray addObject:model2];
        SSOrderListModel *model3 = [[SSOrderListModel alloc]init];
        model3.isSelected = NO;
        model3.titleString = @"不想买了";
        [_dataArray addObject:model3];
        SSOrderListModel *model4 = [[SSOrderListModel alloc]init];
        model4.isSelected = NO;
        model4.titleString = @"其他";
        [_dataArray addObject:model4];
    }
    return _dataArray;
}


- (IBAction)cancelButtonTapAction:(UIButton *)sender {
    
    SSOrderListModel *model = self.dataArray[self.selectIndex];
    self.block(model.titleString);
    [ProgressHUD showSuccess:@"取消成功"];
    [self removeFromSuperview];
}

- (IBAction)waitButtonTapAction:(UIButton *)sender {
    [self removeFromSuperview];

}

- (void)showCancelView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
