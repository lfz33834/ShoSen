//
//  SSCircleTwoView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleTwoView.h"

@implementation SSCircleTwoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bg_view.layer.cornerRadius  = 10;
    self.confirm_button.layer.cornerRadius = 12.5;
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
//    [self addGestureRecognizer:centerTap];
    
    [self.confirm_button addTarget:self action:@selector(myPrizeButtonTap) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initViewWithType:(SSCircleTwoViewType) type
{
    self.type = type;
    if (type == SSCircleTwoViewTypeNull) {
        self.content_label.text = @"您今日的抽奖机会已用完明天再来吧";
        [self.confirm_button setTitle:@"确定" forState:UIControlStateNormal];
    }else if(type == SSCircleTwoViewTypeFailure){
        self.content_label.text = @"好可惜 差一点就抽中了";
        [self.confirm_button setTitle:@"再抽一次" forState:UIControlStateNormal];
    }else if (type == SSCircleTwoViewTypeMall)
    {
        self.content_label.text = @"即将开放....";
        [self.confirm_button setTitle:@"确定" forState:UIControlStateNormal];
    }else if (type == SSCircleTwoViewTypeLevel)
    {
        self.content_label.text = @"等级不足，暂不可参与抽奖";
        [self.confirm_button setTitle:@"确定" forState:UIControlStateNormal];
    }
}

- (void)myPrizeButtonTap
{
    if (self.type == SSCircleTwoViewTypeNull) {
        self.block(SSCircleTwoViewTypeNull);
    }else if(self.type == SSCircleTwoViewTypeFailure){
        self.block(SSCircleTwoViewTypeFailure);
    }
    [self removeFromSuperview];

}

- (void)centerTapClick
{
    [self removeFromSuperview];
}

- (void)showView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
