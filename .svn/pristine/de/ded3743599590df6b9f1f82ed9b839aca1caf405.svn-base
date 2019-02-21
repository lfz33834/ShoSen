
//
//  SSCircleBlackListView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleBlackListView.h"

@implementation SSCircleBlackListView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bg_view.layer.cornerRadius = 5;
    self.cancel_button.layer.cornerRadius = 5;
    self.confirm_button.layer.cornerRadius = 5;
    
    [self.cancel_button addTarget:self action:@selector(cancelButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.confirm_button addTarget:self action:@selector(confirmButtonTapAction) forControlEvents:UIControlEventTouchUpInside];

}

- (void)showView
{
    self.frame = CGRectMake(0, 0, kwidth, kheight);

    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)cancelButtonTapAction
{
    [self removeFromSuperview];
}

- (void)confirmButtonTapAction
{
    self.block();
    [self removeFromSuperview];
}

@end
