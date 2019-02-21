//
//  SSMineFooterView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineFooterView.h"

@implementation SSMineFooterView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.logout_button.layer.cornerRadius = 5;
    self.logout_button.layer.borderColor = kColor(@"D6B35B").CGColor;
    self.logout_button.layer.borderWidth = 1;
    if([SSAccountTool share].account)
    {
        [self.logout_button  setTitle:@"退出登录" forState:UIControlStateNormal];
    }else{
        [self.logout_button  setTitle:@"登录" forState:UIControlStateNormal];
    }
}
- (IBAction)logoutButtonTapAction:(UIButton *)sender {
    if([SSAccountTool share].account)
    {
        
    }else{
        
    }
}

@end
