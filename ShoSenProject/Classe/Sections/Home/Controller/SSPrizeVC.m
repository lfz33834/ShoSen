//
//  SSPrizeVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPrizeVC.h"
#import "SSPrizeFooterCell.h"
#import "SSPrizeHeaderView.h"
#import "SSHomeViewModel.h"
#import "SSPrizeVC.h"
#import "SSPrizeModel.h"
#import "SSMyPrizeVC.h"

@interface SSPrizeVC ()<UITableViewDelegate,UITableViewDataSource >

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) SSHomeViewModel *viewModel;
@property (nonatomic, strong) SSPrizeHeaderView *headerView;
@property (nonatomic, strong) SSPrizeFooterCell *footerCell;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *prizeArray;
@property (nonatomic, strong) NSMutableArray *infoArray;
@property (nonatomic, copy) NSString *infoString;

@property (nonatomic, copy) NSString *prizeNum;
@end

@implementation SSPrizeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoString = @"";
    self.view.backgroundColor = kColor(@"da4142");
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self setTitle:@"幸运大转盘"];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.view addSubview:self.orderListTable];
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
    SSPrizeFooterCell *cell = [SSPrizeFooterCell cellWithTableView:tableView];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initCellWithArray:self.prizeArray];
    cell.info_textview.text = self.infoString;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma --tableDelegate--

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 610;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 588;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 50 - 20) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"da4142");
         _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (void)feltData
{

    [self.viewModel prizeListCallBack:^(id json) {
        self.dataArray = [SSPrizeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        [self.headerView initCircelViewWithArray:self.dataArray];
        
        NSArray *dataArray = json[@"data"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:dataArray forKey:@"jiangpin"];
        [defaults synchronize];
    }];
    
    [self.viewModel gamerewardRecordCallBack:^(id json) {
        self.prizeArray = [SSPrizeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        [self.orderListTable reloadData];
    }];
    
    [self.viewModel gameintReTimeWithPhoneCallBack:^(id json) {
        self.prizeNum = [NSString stringWithFormat:@"%@",json[@"data"]];
        self.headerView.title_label.text = [NSString stringWithFormat:@"剩余抽奖次数%@次",self.prizeNum];
    }];
    
    [self.viewModel prizeGameInfoCallBack:^(id json) {
//        self.footerCell.info_textview.text =
        NSMutableArray *infoDicArray = json[@"data"];
        [infoDicArray enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *contentStr = [NSString stringWithFormat:@"%@\n",obj[@"dicValue"]];
            [self.infoArray addObject:contentStr];
        }];
        
        [self.infoArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.infoString = [NSString stringWithFormat:@"%@%@",self.infoString,obj];
        }];
        [self.orderListTable reloadData];
    }];
}


- (SSPrizeHeaderView *)headerView
{
    if (_headerView == nil) {
        WEAKSELF
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSPrizeHeaderView" owner:self options:nil].lastObject;
        _headerView.block = ^(SSPrizeHeaderViewType type) {
            if (type == SSPrizeHeaderViewTypeRewardList) {
                SSMyPrizeVC *prizeVC = [[SSMyPrizeVC alloc]init];
                [weakSelf.navigationController pushViewController:prizeVC animated:YES];
            }else if (type == SSPrizeHeaderViewTypeDianjiNull)
            {
//                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        };

    }
    return _headerView;
}

- (SSHomeViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSHomeViewModel alloc]init];
    }
    return _viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)prizeArray
{
    if (_prizeArray == nil) {
        _prizeArray = [[NSMutableArray alloc]init];
    }
    return _prizeArray;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray *)infoArray
{
    if (_infoArray == nil) {
        _infoArray = [[NSMutableArray alloc]init];
    }
    return _infoArray;
}

@end
