//
//  SSCircleView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleView.h"

@implementation SSCircleView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bg_view.layer.cornerRadius  = 10;
    self.confirm_button.layer.cornerRadius = 12.5;
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self addGestureRecognizer:centerTap];
    
    [self.confirm_button addTarget:self action:@selector(centerTapClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initViewWithContent:(NSString *)contentStr
{
    self.content_label.text = contentStr;
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
