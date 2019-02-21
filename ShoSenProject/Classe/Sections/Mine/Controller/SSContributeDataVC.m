//
//  SSContributeDataVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/28.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSContributeDataVC.h"
#import "LXScrollContentView.h"
#import "LXSegmentTitleView.h"
#import "SSContributeListVC.h"

@interface SSContributeDataVC ()<LXSegmentTitleViewDelegate,LXScrollContentViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) LXSegmentTitleView *titleView;
@property (nonatomic, strong) LXScrollContentView *contentView;

@end

@implementation SSContributeDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"贡献值明细"];
    [self setupUI];
    [self reloadData];
    [self wr_setNavBarShadowImageHidden:NO];
    self.view.backgroundColor = kColor(@"ffffff");
}

//初始化UI
- (void)setupUI{
    
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
    self.titleView.frame = CGRectMake(0, 0, kwidth, 45);
    self.contentView.frame = CGRectMake(0, 50, kwidth, kheight - 45);
}

//刷新titleView和contentView的数据源，根据项目需求自行选择数据源
- (void)reloadData{
    NSArray *titles;
    titles = @[@"全部明细",@"今日明细"];
    self.titleView.segmentTitles = titles;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    
    SSContributeListVC *circleList = [[SSContributeListVC alloc]init];
    circleList.type = SSContributeListVCTypeAll;
    [vcs addObject:circleList];
    
    SSContributeListVC *finderVC = [[SSContributeListVC alloc]init];
    finderVC.type = SSContributeListVCTypeCurrent;
    [vcs addObject:finderVC];
    
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.titleView.selectedIndex = 0;
    self.contentView.currentIndex = 0;
}

@end
