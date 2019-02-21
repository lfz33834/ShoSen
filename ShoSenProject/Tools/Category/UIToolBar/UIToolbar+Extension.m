//
//  UIToolbar+Extension.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "UIToolbar+Extension.h"

@implementation UIToolbar (Extension)

static CGFloat __barHeight;

+ (void)load
{
    __barHeight = 49;//default value
}

+ (void)setBarHeight:(CGFloat)barHeight
{
    __barHeight = barHeight;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize result = [super sizeThatFits:size];
    result.height = __barHeight;
    return result;
}

@end
