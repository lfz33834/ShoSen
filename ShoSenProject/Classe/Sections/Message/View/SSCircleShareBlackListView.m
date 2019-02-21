//
//  SSCircleShareBlackListView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/31.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleShareBlackListView.h"

@implementation SSCircleShareBlackListView

- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self addGestureRecognizer:centerTap];
    
}

+(SSCircleShareBlackListView *)share{
    static SSCircleShareBlackListView *shareInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstace=[[self alloc] init];
    });
    return shareInstace;
}

- (void)hideView
{
    [self removeFromSuperview];
}

- (void)showView
{
    self.frame = CGRectMake(0, 0, kwidth, kheight);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)initViewWithType:(SSCircleShareBlackListType )type
{
    self.type = type;
    if (type == SSCircleShareBlackListTypeShare) {
        
        [self.one_button setImage:[UIImage imageNamed:@"circle_wechat"] forState:UIControlStateNormal];
        [self.one_button setTitle:@"微信" forState:UIControlStateNormal];
        [self.two_button setImage:[UIImage imageNamed:@"circle_pengyouwechat"] forState:UIControlStateNormal];
        [self.two_button setTitle:@"朋友圈" forState:UIControlStateNormal];
    }else if (type == SSCircleShareBlackListTypeBlackList)
    {
        [self.one_button setImage:[UIImage imageNamed:@"circle_jubao"] forState:UIControlStateNormal];
        [self.one_button setTitle:@"举报" forState:UIControlStateNormal];
        [self.two_button setImage:[UIImage imageNamed:@"circle_lahei"] forState:UIControlStateNormal];
        [self.two_button setTitle:@"拉黑" forState:UIControlStateNormal];
    }
}
- (IBAction)oneButtonTapAction:(UIButton *)sender {
    
    if (self.type == SSCircleShareBlackListTypeShare) {
        self.block(SSCireViewTapTypeWechatShare);
    }else if (self.type == SSCircleShareBlackListTypeBlackList)
    {
        self.block(SSCireViewTapTypeJubao);
    }
    [self hideView];
}
- (IBAction)twoButtonTapAction:(UIButton *)sender {
    if (self.type == SSCircleShareBlackListTypeShare) {
        self.block(SSCireViewTapTypePengyouCircleShare);
    }else if (self.type == SSCircleShareBlackListTypeBlackList)
    {
        self.block(SSCireViewTapTypeLahei);
    }
    [self hideView];
}

@end
