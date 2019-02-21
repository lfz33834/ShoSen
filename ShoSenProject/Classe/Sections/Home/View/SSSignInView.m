//
//  SSSignInView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSSignInView.h"

@implementation SSSignInView

- (void)awakeFromNib
{
    [super awakeFromNib];
        UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
        [self addGestureRecognizer:centerTap];
}

- (void)centerTapClick
{
    [self removeFromSuperview];
}

- (void)initViewWithType:(SSSignInViewType )type
{
    if (type == SSSignInViewTypeSuccess) {
        self.title_label.text = @"签到成功";
        self.contentlabel.text = @"恭喜你获得 20贡献值";
    }else if (SSSignInViewTypeFailure)
    {
        self.title_label.text = @"已进行过签到";
        self.contentlabel.text = @"";
    }
}

- (void)showView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
