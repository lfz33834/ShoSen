//
//  SSEnterBBSVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/25.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSEnterBBSVC.h"
#import "SSVerifyBBSVC.h"
#import "WXApi.h"

@interface SSEnterBBSVC ()

@end

@implementation SSEnterBBSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlackMode];
    self.title = @"进入社区";
    [self setBlackMode];
    self.enter_button.layer.cornerRadius = 5;
    self.enter_button.layer.borderColor = kColor(@"D6B35B").CGColor;
    self.enter_button.layer.borderWidth = 1;
    

    
}
- (IBAction)enterButtonTapAction:(UIButton *)sender {
    
    [self openWXMiniProgram];
}

- (IBAction)forgetButtonTapAction:(UIButton *)sender {
    SSVerifyBBSVC *bbs = [[SSVerifyBBSVC alloc]init];
    [self.navigationController pushViewController:bbs animated:YES];
}

//外部调用此方法前先调用abilityCheck判断是否可以正常调起微信小程序
- (BOOL)openWXMiniProgram {
    
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = @"gh_ca9acc95304d";
    launchMiniProgramReq.path = @"/pages/loginPL/index";
    launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview;
    return  [WXApi sendReq:launchMiniProgramReq];
}
//检查用户是否安装微信
//判断当前微信的版本是否支持OpenApi
+ (BOOL)abilityCheck {
    if ([WXApi isWXAppInstalled]) {
        if ([WXApi isWXAppSupportApi]) {
            return YES;
        }
        return NO;
    }
    return NO;
}

@end
