//
//  SSMineRulesVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/8.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineRulesVC.h"
#import "SSPerkDetailHeaderView.h"
#import "SSPerkDetailFooterView.h"
#import "SSRuleOneCell.h"

@interface SSMineRulesVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *bg_view;
@property (nonatomic, strong) UIView *table_view;
@property (nonatomic, strong) UITableView *rule_table;
@property (nonatomic,strong) SSPerkDetailHeaderView *headerView;
@property (nonatomic,strong) SSPerkDetailFooterView *footerView;

@end

@implementation SSMineRulesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"规则"];
    [self.view addSubview:self.bg_view];
    [self.bg_view addSubview:self.table_view];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.table_view addSubview:self.rule_table];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSRuleOneCell *cell = [SSRuleOneCell cellWithTableView:tableView];
    [cell initWithCellWithType:SSRuleOneCellTypeTwo];
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
    return 43;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 415;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerView;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 82;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)bg_view
{
    if (_bg_view == nil) {
        _bg_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 64)];
        _bg_view.backgroundColor = kColor(@"f8f8f8");
        _bg_view.layer.borderColor = kColor(@"D6B35B").CGColor;
        _bg_view.layer.borderWidth = 7;
    }
    return _bg_view;
}

- (UIView *)table_view
{
    if (_table_view == nil) {
        _table_view = [[UIView alloc]init];
        _table_view.frame = CGRectMake(20, 33, kwidth - 40, 540);
        _table_view.layer.cornerRadius = 5;
        _table_view.layer.shadowColor= kColor(@"333333").CGColor;
        _table_view.userInteractionEnabled=YES;
        _table_view.layer.shadowOpacity=0.2;
        [_table_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kwidth - 40, 540)] CGPath]];
        _table_view.layer.shadowRadius = 5.0;//半径
        _table_view.layer.shadowOffset = CGSizeMake(5, 5);
    }
    return _table_view;
}

- (UITableView *)rule_table
{
    if (!_rule_table) {
        _rule_table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth - 40, 540) style:UITableViewStylePlain];
        _rule_table.delegate = self;
        _rule_table.dataSource = self;
        _rule_table.scrollEnabled = NO;
        _rule_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rule_table;
}

@end
