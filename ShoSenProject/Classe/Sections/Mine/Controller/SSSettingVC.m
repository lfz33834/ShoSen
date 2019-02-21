//
//  SSSettingVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSSettingVC.h"

@interface SSSettingVC ()

{
    NSInteger type;
}

@end

@implementation SSSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置"];
    
    [SSPayTool share].block = ^(id obj) {
//        NSString *headimgurl = obj[@"headimgurl"];
//        NSString *nickName = obj[@"nickname"];
        NSString *openId = obj[@"openid"];
        [self wechatBindWithOpenId:openId];
    };
    
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        self.logout_label.text = @"退出登录";
        type = 1;
    }else{
        self.logout_label.text = @"请登录";
        type = 0;
    }
    
    if (account.openId.length > 0) {
        self.status_label.text = @"解绑";
    }else{
        self.status_label.text = @"去绑定";
    }
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGesture addTarget:self action:@selector(gestureTapAction)];
    [self.logout_view addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *bindGesture = [[UITapGestureRecognizer alloc]init];
    [bindGesture addTarget:self action:@selector(bindGesturTapAction)];
    [self.bind_view addGestureRecognizer:bindGesture];
    
    
    UITapGestureRecognizer *phoneGesure = [[UITapGestureRecognizer alloc]init];
    [phoneGesure addTarget:self action:@selector(phoneGesturTapAction)];
    [self.contact_view addGestureRecognizer:phoneGesure];
}

- (void)phoneGesturTapAction
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"010-53394889"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)bindGesturTapAction
{
    SSAccount *account = [SSAccountTool share].account;
    if (account.openId.length > 0) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        SSAccount *account = [SSAccountTool share].account;
        NSDictionary *userDic = @{@"securityToken":account.token};
        params[@"user"] = userDic;
        params[@"id"] = account.uid;
        [FZHttpTool post:UserWechaUnlock parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
            self.status_label.text = @"去绑定";
            [ProgressHUD showSuccess:@"解绑成功"];
            [self updateUserInfo];
        } failure:^(NSError * _Nullable error) {
        }];
    }else{
        [[SSPayTool share] getAuthWithUserInfoFromWechat:self callBack:^(NSDictionary *dicData) {
            
        }];
    }
}

- (void)wechatBindWithOpenId:(NSString *)openId
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"openId"] = openId;
    params[@"phone"] = account.phone;
    [FZHttpTool post:UserLoginWechatBindUrl parameters:params isShowHUD:NO httpToolSuccess:^(id  _Nullable json) {
        self.status_label.text = @"解绑";
        [ProgressHUD showSuccess:@"绑定成功"];
        [self updateUserInfo];
    } failure:^(NSError * _Nullable error) {
    }];
}


- (void)updateUserInfo
{
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        [FZHttpTool post:UserInfoUrl parameters:@{@"phone":account.phone} isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
            [[SSAccountTool share]saveAccountData:[json[@"data"]mutableCopy]];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}


- (void)gestureTapAction
{
    if (type == 1) {
        [[FZAlertTool share]alertView:@"提示" message:@"是否确定退出" cancelTitle:@"取消" confirm:@"确定" resultBlock:^(WCNoticeAlertViewType alertType) {
            if (alertType == WCNoticeAlertViewTypeCancel) {
//                [ProgressHUD showError:@""];
            }else if(alertType == WCNoticeAlertViewTypeConfirm){
                [FZHttpTool post:UserLogout parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {

                    [[SSAccountTool share]logoutAccount];
//                    SSLoginVC *loginVC = [[SSLoginVC alloc]init];
//                    loginVC.block = ^{
                        self.logout_label.text = @"退出登录";
                        type = 1;
//                    };
                    [self.navigationController popViewControllerAnimated:YES];
                    self.block();
//                    [self.navigationController pushViewController:loginVC animated:YES];
                } failure:^(NSError *error) {
                    [ProgressHUD showSuccess:@"请求失败"];
                }];
            }
        }];
    }else{
        SSLoginVC *loginVC = [[SSLoginVC alloc]init];
        loginVC.fromVC = SSLoginVCFromSetting;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
