//
//  SSCircleListHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/24.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleListHeaderView.h"

@implementation SSCircleListHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.title_button.layer.cornerRadius = 16;
    self.title_button.layer.borderWidth= 1;
    self.title_button.layer.borderColor = kColor(@"D6B35B").CGColor;
}

@end
