//
//  SSVerifyBBSVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/25.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSVerifyBBSVC.h"
#import "UITextField+Extension.h"

@interface SSVerifyBBSVC ()<UITextFieldDelegate>

@property(nonatomic,assign)NSInteger time;
@property (nonatomic, assign) BOOL isSecure;

@end

@implementation SSVerifyBBSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"忘记密码";
    [self setBlackMode];
    self.next_button.layer.cornerRadius = 5;
    self.next_button.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.isSecure = NO;
    self.password_textfield.secureTextEntry = NO;
    [self.password_look_button setImage:[UIImage imageNamed:@"mine_eyes_button"] forState:UIControlStateNormal];
    
    
    self.phone_textfield.delegate            = self;
    self.phone_textfield.keyboardType        = UIKeyboardTypeNumberPad;
    self.code_textfield.delegate              = self;
    self.code_textfield.keyboardType          = UIKeyboardTypeNumberPad;
    
    //    self.code_button.enabled                    = NO;
    //    self.submit_button.enabled                   = NO;
    
    [self.phone_textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.code_textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.password_textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

}

-(void) textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phone_textfield){
        [textField validateTextFieldTextLengh:11];
    }else if (textField == self.code_textfield){
        [textField validateTextFieldTextLengh:4];
    }else if (textField == self.password_textfield){
        [textField validateTextFieldTextLengh:20];
    }
}

- (IBAction)passwordLookButtonTapAction:(UIButton *)sender {
    
    if (self.isSecure) {
        self.isSecure = NO;
        self.password_textfield.secureTextEntry = NO;
        [self.password_look_button setImage:[UIImage imageNamed:@"mine_eyes_button"] forState:UIControlStateNormal];
        
    }else{
        self.isSecure = YES;
        self.password_textfield.secureTextEntry = YES;
        [self.password_look_button setImage:[UIImage imageNamed:@"mine_uneyes_button"] forState:UIControlStateNormal];
    }
}

- (IBAction)nextButtonTapAction:(UIButton *)sender {
    
    if (self.code_textfield.text.length != 4) {
        [ProgressHUD showError:@"验证码不正确"];
        return ;
    }
   
    if (self.password_textfield.text.length < 6) {
        [ProgressHUD showSuccess:@"密码不合法"];
        return;
    }
    
    if (![self.phone_textfield.text validatePhone]) {
        [ProgressHUD showSuccess:@"手机号不合法"];
        return;
    }
    
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"phone"] = account.phone;
    params[@"smsCode"] = self.code_textfield.text;
    params[@"password"] = [self.password_textfield.text md5];
    
    [FZHttpTool post:kChangePassword parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        [ProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
- (IBAction)codeButtonTapAction:(UIButton *)sender {
    if ([self.phone_textfield.text validatePhone]) {
        UIButton *btn = sender;
        btn.enabled = NO;
        self.time = 60;
        [btn setTitle:[NSString stringWithFormat:@"%lds",(long)self.time] forState:UIControlStateNormal];
         __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCodeTime:) userInfo:btn repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [timer invalidate];
            timer               = nil;
            btn.enabled         = YES;
            [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
         });
        [self sendCode:self.phone_textfield.text];
    }else{
        [ProgressHUD showError:@"手机号不合法"];
    }
}

- (void)sendCode:(NSString *)phone
{
    [FZHttpTool post:LoginCodeUrl parameters:@{@"phone":phone,@"smsCode":@""} isShowHUD:NO httpToolSuccess:^(id  _Nullable json) {
        [ProgressHUD showSuccess:@"发送验证码成功"];
    } failure:^(NSError * _Nullable error) {
    }];
}

- (void)updateCodeTime:(NSTimer *)timer
{
    UIButton *btn = timer.userInfo;
    self.time--;
    if (self.time <= 0) {
        self.time = 60;
        [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
    } else {
        [btn setTitle:[NSString stringWithFormat:@"%lds",(long)self.time] forState:UIControlStateNormal];
    }
}
@end
