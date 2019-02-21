//
//  SSPurseHelpVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/29.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPurseHelpVC.h"

@implementation SSPurseHelpVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"帮助";
    
    [self.bg_imageview sd_setImageWithURL:[NSURL URLWithString:@"https://api.shosen.cn/app/img/yeNote.png"] placeholderImage:nil];
}

@end
