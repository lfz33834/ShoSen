//
//  SSMineShopAllOrderVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineShopAllOrderVC.h"
#import "LXScrollContentView.h"
#import "LXSegmentTitleView.h"
#import "SSShopOrderListVC.h"
#import "SSCircleSearchView.h"
#import "SSSearchShopOrderListVC.h"
#import "SearchBarEffectController.h"

@interface SSMineShopAllOrderVC ()<LXSegmentTitleViewDelegate,LXScrollContentViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) LXSegmentTitleView *titleView;
@property (nonatomic, strong) LXScrollContentView *contentView;

@end

@implementation SSMineShopAllOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"商品订单"];
    [self setupUI];
    [self reloadData];
    
    [self wr_setNavBarShadowImageHidden:NO];
    self.view.backgroundColor = kColor(@"ffffff");
}

//初始化UI
- (void)setupUI{
    
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UIButton * rightBtn = [UIButton itemWithFream:CGRectMake(0.0, 0.0, 30.0f, 30.0f) withbackGroundColor:[UIColor clearColor] withTitle:@"" withTitleColor:[UIColor whiteColor] withTitleSize:16 withIsBold:NO];
    [rightBtn setImage:[UIImage imageNamed:@"shopeorder_search"] forState:UIControlStateNormal];
    [rightBtn setAdjustsImageWhenHighlighted:NO];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
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
}

- (void)newbacks
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction
{
    SearchBarEffectController * search = [[SearchBarEffectController alloc]init];
    search.block = ^(NSString *returnString) {
        SSSearchShopOrderListVC *searchview = [[SSSearchShopOrderListVC alloc]init];
        searchview.search_string = returnString;
        [self.navigationController pushViewController:searchview animated:YES];
    };
    [search show];
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
    self.titleView.frame = CGRectMake(0, 0, kwidth, 50);
    self.contentView.frame = CGRectMake(0, 50, kwidth, kheight - 50);
}

//刷新titleView和contentView的数据源，根据项目需求自行选择数据源
- (void)reloadData{
    NSArray *titles;
    titles = @[@"全部",@"待支付",@"待收货",@"已完成",@"已取消"];
    self.titleView.segmentTitles = titles;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    
    SSShopOrderListVC *orderall = [[SSShopOrderListVC alloc]init];
    orderall.type = 0;
    [vcs addObject:orderall];
    
    SSShopOrderListVC *orderpay = [[SSShopOrderListVC alloc]init];
    orderpay.type = 1;
    [vcs addObject:orderpay];
    
    SSShopOrderListVC *orderreceive = [[SSShopOrderListVC alloc]init];
    orderreceive.type = 3;
    [vcs addObject:orderreceive];
    
    SSShopOrderListVC *orderfinish = [[SSShopOrderListVC alloc]init];
    orderfinish.type = 5;
    [vcs addObject:orderfinish];
    
    SSShopOrderListVC *ordercancel = [[SSShopOrderListVC alloc]init];
    ordercancel.type = 6;
    [vcs addObject:ordercancel];
    
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.titleView.selectedIndex = 0;
    self.contentView.currentIndex = 0;
}

@end
