//
//  SSCircleVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/22.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleVC.h"
#import "LXScrollContentView.h"
#import "LXSegmentTitleView.h"
#import "SSCircleListVC.h"
#import "SSCircleMineVC.h"
#import "SSFinderListVC.h"

@interface SSCircleVC () <LXSegmentTitleViewDelegate,LXScrollContentViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) LXSegmentTitleView *titleView;
@property (nonatomic, strong) LXScrollContentView *contentView;

@end

@implementation SSCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"圈子"];
    [self setupUI];
    [self reloadData];
    
    [self wr_setNavBarShadowImageHidden:NO];
    self.view.backgroundColor = kColor(@"ffffff");
}

//初始化UI
- (void)setupUI{
    
    
    UIButton * rightBtn = [UIButton itemWithFream:CGRectMake(0.0, 0.0, 30.0f, 30.0f) withbackGroundColor:[UIColor clearColor] withTitle:@"" withTitleColor:[UIColor whiteColor] withTitleSize:16 withIsBold:NO];
    [rightBtn setImage:[UIImage imageNamed:@"circle_header"] forState:UIControlStateNormal];
    [rightBtn setAdjustsImageWhenHighlighted:NO];

    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.titleView = [[LXSegmentTitleView alloc] initWithFrame:CGRectZero];
    self.titleView.titleSelectedColor = kColor(@"D6B35B");
    self.titleView.titleNormalColor = kColor(@"666666");
    self.titleView.titleFont = [UIFont systemFontOfSize:15];
    self.titleView.itemMinMargin = 0;
    self.titleView.indicatorColor = kColor(@"D6B35B");
    self.titleView.delegate = self;
    self.titleView.backgroundColor = kColor(@"ffffff");
    [self.view addSubview:self.titleView];
    
    self.contentView = [[LXScrollContentView alloc] initWithFrame:CGRectZero];
    self.contentView.delegate = self;
    [self.view addSubview:self.contentView];
}

- (void)rightBtnAction
{
    SSCircleMineVC *circleMineVC = [[SSCircleMineVC alloc]init];
    [self.navigationController pushViewController:circleMineVC animated:YES];
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
    self.titleView.frame = CGRectMake(0, 0, 190, 40);
    self.contentView.frame = CGRectMake(0, 40, kwidth, kheight - 35);
}

//刷新titleView和contentView的数据源，根据项目需求自行选择数据源
- (void)reloadData{
    NSArray *titles;
    titles = @[@"发现",@"圈子"];
    self.titleView.segmentTitles = titles;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    
    SSFinderListVC *finderVC = [[SSFinderListVC alloc]init];
    [vcs addObject:finderVC];
    
    SSCircleListVC *circleList = [[SSCircleListVC alloc]init];
    [vcs addObject:circleList];
    

    
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.titleView.selectedIndex = 0;
    self.contentView.currentIndex = 0;
}

@end
