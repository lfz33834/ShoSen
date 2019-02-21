//
//  SSBBSVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/25.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSBBSVC.h"

@implementation SSBBSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区";
    [self setBlackMode];
    self.back_button.layer.cornerRadius = 5;
    self.back_button.layer.borderColor = kColor(@"D6B35B").CGColor;
    self.back_button.layer.borderWidth = 1;
}

- (IBAction)backButtonTapAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
