//
//  SSVerifyBBSVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/25.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSVerifyBBSVC : FZBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phone_textfield;
@property (weak, nonatomic) IBOutlet UITextField *code_textfield;
@property (weak, nonatomic) IBOutlet UIButton *code_button;
@property (weak, nonatomic) IBOutlet UIButton *next_button;

@property (weak, nonatomic) IBOutlet UIButton *password_look_button;
@property (weak, nonatomic) IBOutlet UITextField *password_textfield;
@property (nonatomic, copy) NSString *smsCode;

@end

NS_ASSUME_NONNULL_END
