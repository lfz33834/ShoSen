//
//  SSMinePerkDetailVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/29.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMinePerkDetailVC.h"
#import "SSMinePerkCell.h"
#import "SSPerkDetailHeaderView.h"
#import "SSPerkDetailRuleCell.h"
#import "SSPerkDetailFooterView.h"
#import "SSPerkDetailNormalCell.h"
#import "SSMinePerkDetailViewModel.h"
#import "SSPerkDetailListModel.h"
#import "SSRuleOneCell.h"

@interface SSMinePerkDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *oneTable_array;
@property (nonatomic,strong) SSPerkDetailHeaderView *headerView;
@property (nonatomic,strong) SSPerkDetailFooterView *footerView;
@property (nonatomic,strong) SSMinePerkDetailViewModel *viewModel;

@end

@implementation SSMinePerkDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"详情"];
    
    [self feltData];
    self.view.frame = CGRectMake(0, 64, kwidth, kheight - 64);
    self.viewModel = [[SSMinePerkDetailViewModel alloc]init];
    self.bg_view.layer.borderColor = kColor(@"D6B35B").CGColor;
    self.bg_view.layer.borderWidth = 7;
    self.title_label.layer.cornerRadius = 5;
    self.title_label.clipsToBounds = YES;
    
    self.oneTableView_height.constant = 75 + 25*self.oneTable_array.count + 25;
    self.twoTable_height.constant = 140 + 270 + 20;
    
    CGFloat heightview = 75 + 25*self.oneTable_array.count + 25 + 140 + 270 + 20 + 200;
    if (heightview > 600) {
        self.height_layout.constant = heightview - 600;
    }else{
        self.height_layout.constant = 0;
    }
    
    self.onetable_view.layer.cornerRadius = 5;
    self.onetable_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.onetable_view.userInteractionEnabled=YES;
    self.onetable_view.layer.shadowOpacity=0.2;
    [self.onetable_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kwidth - 40, self.oneTableView_height.constant)] CGPath]];
    self.onetable_view.layer.shadowRadius = 5.0;//半径
    self.onetable_view.layer.shadowOffset = CGSizeMake(5, 5);
//    self.onetable_view.clipsToBounds = YES;

    
    self.twotable_view.layer.cornerRadius = 5;
    self.twotable_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.twotable_view.userInteractionEnabled=YES;
    self.twotable_view.layer.shadowOpacity=0.2;
    [self.twotable_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kwidth - 40, self.twoTable_height.constant)] CGPath]];
    self.twotable_view.layer.shadowRadius = 5.0;//半径
    self.twotable_view.layer.shadowOffset = CGSizeMake(5, 5);
//    self.twotable_view.clipsToBounds = YES;
 
    self.one_table.delegate = self;
    self.one_table.dataSource = self;
    self.one_table.scrollEnabled = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.one_table.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    self.two_table.delegate = self;
    self.two_table.dataSource = self;
    self.two_table.scrollEnabled = NO;
    self.two_table.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.one_table) {
        SSPerkDetailNormalCell *cell = [SSPerkDetailNormalCell cellWithTableView:tableView];
        SSPerkDetailListModel *model;
        if(indexPath.row > 0)
        {
            model = self.oneTable_array[indexPath.row - 1];
        }
        [cell initCellWithModel:model index:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    SSRuleOneCell *cell = [SSRuleOneCell cellWithTableView:tableView];
    [cell initWithCellWithType:SSRuleOneCellTypeOne];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.one_table) {
        return self.oneTable_array.count + 1;
    }
    return 1;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.one_table) {
        return [UIView new];
    }
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.one_table) {
        return 0;
    }
    return 43;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.one_table) {
        return 25;
    }
    return 270;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == self.two_table) {
        return self.footerView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.one_table) {
        return 0;
    }
    return 72;
}

- (void)feltData
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *paramsDic = @{@"phone":account.phone};
    [FZHttpTool post:UserRewardTotal parameters:paramsDic isShowHUD:YES httpToolSuccess:^(id json) {
        
    } failure:^(NSError *error) {
        [ProgressHUD showSuccess:@"请求失败"];
    }];
}

- (SSPerkDetailHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSPerkDetailHeaderView" owner:self options:nil].lastObject;
    }
    return _headerView;
}

- (SSPerkDetailFooterView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[NSBundle mainBundle]loadNibNamed:@"SSPerkDetailFooterView" owner:self options:nil].lastObject;
    }
    return _footerView;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
