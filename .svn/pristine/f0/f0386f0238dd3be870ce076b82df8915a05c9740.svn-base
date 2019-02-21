//
//  SSCircleCommentDelView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleCommentDelView.h"

@implementation SSCircleCommentDelView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (IBAction)delButtonTapAction:(UIButton *)sender {
    if (self.block) {
        self.block(SSCircleCommentDelViewTypeDel);
        [self removeFromSuperview];
    }
}

- (IBAction)cancelButtonTapAction:(UIButton *)sender {
    if (self.block) {
        self.block(SSCircleCommentDelViewTypeCancel);
        [self removeFromSuperview];
    }
}

 - (void)showDelView
{
    self.frame = CGRectMake(0, 0, kwidth, kheight);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


@end
