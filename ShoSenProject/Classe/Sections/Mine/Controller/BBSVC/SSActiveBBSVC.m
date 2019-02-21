//
//  SSActiveBBSVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/25.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSActiveBBSVC.h"
#import "UITextField+Extension.h"
#import "WXApi.h"

@interface SSActiveBBSVC ()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL isPassword;
@property (nonatomic, assign) BOOL isConfirmPassword;

@end

@implementation SSActiveBBSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlackMode];
    self.title = @"激活";
    self.isPassword = YES;
    self.isConfirmPassword = YES;
    
    
    self.password_textfield.delegate = self;
    self.confirmPassword_textfield.delegate = self;

    self.password_textfield.secureTextEntry = NO;
    self.confirmPassword_textfield.secureTextEntry = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBlackMode];
    self.active_button.layer.cornerRadius = 5;
    self.active_button.clipsToBounds = YES;
    
    [self.password_textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.confirmPassword_textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    SSAccount *account = [SSAccountTool share].account;
    
    self.phone_label.text = [NSString stringWithFormat:@"手机号码：%@",account.phone];;
    if (account.invitorPhone.length > 1) {
        self.person_label.text = [NSString stringWithFormat:@"推 荐 人：%@",account.invitorPhone];
    }else{
        self.personLabel_height_layout.constant = 0;
        self.person_label.hidden = YES;
    }
    
}

-(void) textFieldDidChange:(UITextField *)textField
{
    if (textField == self.password_textfield){
        [textField validateTextFieldTextLengh:20];
    }else if (textField == self.confirmPassword_textfield){
        [textField validateTextFieldTextLengh:20];
    }
    
    if(self.password_textfield.text.length > 0 && self.confirmPassword_textfield.text.length > 0)
    {
        [self.active_button setBackgroundImage:[UIImage imageNamed:@"shop_bottom_button"] forState:UIControlStateNormal];
        [self.active_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.active_button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.active_button setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
    }
}

- (IBAction)passwordLookButtonTapAction:(UIButton *)sender {
    
    if (self.isPassword) {
        self.isPassword = NO;
        self.password_textfield.secureTextEntry = YES;
        [self.password_look_button setImage:[UIImage imageNamed:@"mine_uneyes_button"] forState:UIControlStateNormal];
    }else{
        self.isPassword = YES;
        self.password_textfield.secureTextEntry = NO;
        [self.password_look_button setImage:[UIImage imageNamed:@"mine_eyes_button"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)confirmPasswordLookButtonTapAction:(UIButton *)sender {

    if (self.isConfirmPassword) {
        self.isConfirmPassword = NO;
        self.confirmPassword_textfield.secureTextEntry = YES;
        [self.confirmPassword_look_button setImage:[UIImage imageNamed:@"mine_uneyes_button"] forState:UIControlStateNormal];
    }else{
        self.isConfirmPassword = YES;
        self.confirmPassword_textfield.secureTextEntry = NO;
        [self.confirmPassword_look_button setImage:[UIImage imageNamed:@"mine_eyes_button"] forState:UIControlStateNormal];
    }
}
- (IBAction)activeButtonTapAction:(id)sender {
    
    [self activeBBS];
}

- (void)activeBBS
{
    if (self.password_textfield.text.length < 6 || self.confirmPassword_textfield.text.length < 6) {
        [ProgressHUD showError:@"密码设置不规范"];
        return;
    }else if (![self.password_textfield.text isEqualToString:self.confirmPassword_textfield.text]) {
        [ProgressHUD showError:@"前后密码输入不一致"];
        return;
    }
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"phone"] = account.phone;
    params[@"password"] = [self.password_textfield.text md5];
    [FZHttpTool post:kActiveBBS parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        [ProgressHUD showSuccess:@"激活成功"];
        [self openWXMiniProgram];
    } failure:^(NSError * _Nullable error) {
        
    }];
}


//外部调用此方法前先调用abilityCheck判断是否可以正常调起微信小程序
- (BOOL)openWXMiniProgram {
    
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = @"gh_ca9acc95304d";
    launchMiniProgramReq.path = @"/pages/loginPL/index";
    launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview;
    return  [WXApi sendReq:launchMiniProgramReq];
}

@end
