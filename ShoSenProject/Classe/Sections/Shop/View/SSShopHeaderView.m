//
//  SSShopHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopHeaderView.h"

@interface SSShopHeaderView()<SDCycleScrollViewDelegate>

@end

@implementation SSShopHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpScrollView];
}


- (void)setUpScrollView
{
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kwidth, 150) delegate:self placeholderImage:[UIImage imageNamed:@"circle_placeholder_1"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.currentPageDotImage = [UIImage imageWithColor:kColor(@"D6B35B") size:CGSizeMake(15, 1)];
    cycleScrollView2.pageDotImage = [UIImage imageWithColor:kColor(@"ffffff") size:CGSizeMake(15, 1)];
    self.scrollView = cycleScrollView2;
    [self.scroll_view addSubview:cycleScrollView2];
    //         block监听点击方式
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
    };
}

@end
