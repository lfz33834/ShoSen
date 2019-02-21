//
//  SSInvatorCodeWarningView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/27.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSInvatorCodeWarningView.h"

@implementation SSInvatorCodeWarningView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bg_view.layer.cornerRadius = 5;
    self.confirm_button.layer.cornerRadius = 35/2;
}
- (IBAction)confirmButtonTapAction:(UIButton *)sender {
    [self removeFromSuperview];
    self.block();
}

- (void)showView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
