//
//  SSCircleListImageCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleListImageCell.h"

@implementation SSCircleListImageCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
}

@end
