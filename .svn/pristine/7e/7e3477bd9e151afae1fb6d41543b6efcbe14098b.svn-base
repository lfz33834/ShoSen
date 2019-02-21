//
//  SSCircleInputView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/29.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleInputView.h"

#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenwidth (kScreenBounds.size.width)
#define kScreenheight (kScreenBounds.size.height)
#define UIColorRGB(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

@interface SSCircleInputView()<UITextViewDelegate,UIScrollViewDelegate>

@end

@implementation SSCircleInputView

- (void)awakeFromNib
{
    [super awakeFromNib];
//    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
//    [self addGestureRecognizer:centerTap];
}
- (IBAction)messagebuttongtapAction:(UIButton *)sender {
    if(self.block)
    {
        self.block(SSCircleInputTypeMessage);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.block) {
        self.block(SSCircleInputTypeEditeMessage);
    }
}

- (void)centerTapClick
{
    if (self.block) {
        self.block(SSCircleInputTypeEditeMessage);
    }
}

@end
