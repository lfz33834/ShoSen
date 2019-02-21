//
//  SSOrderDeleteView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/18.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSOrderDeleteView.h"

@implementation SSOrderDeleteView

- (void)showDeleteView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (IBAction)cancelButtonTapAction:(UIButton *)sender {
    [self removeFromSuperview];
}
- (IBAction)confirmButtonTapAciton:(UIButton *)sender {
    self.block();
    [self removeFromSuperview];
}

@end
