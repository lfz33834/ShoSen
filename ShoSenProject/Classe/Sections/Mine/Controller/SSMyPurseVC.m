//
//  SSMyPurseVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/21.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMyPurseVC.h"
#import "LXScrollContentView.h"
#import "LXSegmentTitleView.h"
#import "SSMyPurseListVC.h"
#import "SSRechargeVC.h"
#import "SSPurseHelpVC.h"

@interface SSMyPurseVC ()<LXSegmentTitleViewDelegate,LXScrollContentViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) LXSegmentTitleView *titleView;
@property (nonatomic, strong) LXScrollContentView *contentView;

@end

@implementation SSMyPurseVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setupUI];
    [self reloadData];
    [self setNavBlack];
    
    
    UIButton * rightBtn = [UIButton itemWithFream:CGRectMake(0.0, 0.0, 50, 30.0f) withbackGroundColor:[UIColor clearColor] withTitle:@"帮助" withTitleColor:[UIColor whiteColor] withTitleSize:16 withIsBold:NO];
    [rightBtn setTitle:@"帮助" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)rightBtnAction
{
    SSPurseHelpVC *helpVC = [[SSPurseHelpVC alloc]init];
    [self.navigationController pushViewController:helpVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUserInfo];
    [self reloadData];
}

//初始化UI
- (void)setupUI{
    
    self.title = @"我的钱包";
    
//    [self updateUserInfo];
    
    self.titleView = [[LXSegmentTitleView alloc] initWithFrame:CGRectZero];
    self.titleView.titleSelectedColor = kColor(@"D6B35B");
    self.titleView.titleNormalColor = kColor(@"666666");
    self.titleView.titleFont = [UIFont systemFontOfSize:16];
    self.titleView.itemMinMargin = 0;
    self.titleView.indicatorColor = kColor(@"D6B35B");
    self.titleView.delegate = self;
    self.titleView.backgroundColor = kColor(@"ffffff");
    [self.view addSubview:self.titleView];
    
    self.contentView = [[LXScrollContentView alloc] initWithFrame:CGRectZero];
    self.contentView.delegate = self;
    [self.view addSubview:self.contentView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newbacks)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];
    
    self.charge_button.layer.cornerRadius = 5;
    self.charge_button.layer.borderColor = kColor(@"ffffff").CGColor;
    self.charge_button.layer.borderWidth = 1;
    [self.charge_button addTarget:self action:@selector(rechargeMoneyButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rechargeMoneyButtonTapAction
{
    SSRechargeVC *chargeVC = [[SSRechargeVC alloc]init];
    [self.navigationController pushViewController:chargeVC animated:YES];
}

- (void)newbacks
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)segmentTitleView:(LXSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    self.contentView.currentIndex = selectedIndex;
}

- (void)contentViewDidScroll:(LXScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress{
    
}

- (void)contentViewDidEndDecelerating:(LXScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectedIndex = endIndex;
}

//调整titleView和contentView的frame
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.titleView.frame = CGRectMake(0, 150, kwidth, 50);
    self.contentView.frame = CGRectMake(0, 200, kwidth, kheight - 200);
}

//刷新titleView和contentView的数据源，根据项目需求自行选择数据源
- (void)reloadData{
    NSArray *titles;
    titles = @[@"余额明细",@"积分明细"];
    self.titleView.segmentTitles = titles;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    
    SSMyPurseListVC *orderall = [[SSMyPurseListVC alloc]init];
    orderall.vcType = SSMyPurseListVCTypeYue;
     [vcs addObject:orderall];
    
    SSMyPurseListVC *orderpay = [[SSMyPurseListVC alloc]init];
    orderpay.vcType = SSMyPurseListVCTypeJiFen;
     [vcs addObject:orderpay];
    
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.titleView.selectedIndex = 0;
    self.contentView.currentIndex = 0;
}

- (void)updateUserInfo
{
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        [FZHttpTool post:UserInfoUrl parameters:@{@"phone":account.phone} isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
            [[SSAccountTool share]saveAccountData:[json[@"data"]mutableCopy]];
            
            SSAccount *account = [SSAccountTool share].account;
            self.money_label.text = account.money;
            self.jifen_label.text = account.xProperty;
            
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}

@end
