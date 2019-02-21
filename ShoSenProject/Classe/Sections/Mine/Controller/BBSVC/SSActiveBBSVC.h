//
//  SSActiveBBSVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/25.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSActiveBBSVC : FZBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *active_button;
@property (weak, nonatomic) IBOutlet UILabel *phone_label;
@property (weak, nonatomic) IBOutlet UILabel *person_label;
@property (weak, nonatomic) IBOutlet UITextField *password_textfield;
@property (weak, nonatomic) IBOutlet UIButton *password_look_button;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword_textfield;
@property (weak, nonatomic) IBOutlet UIButton *confirmPassword_look_button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *personLabel_height_layout;

@end

NS_ASSUME_NONNULL_END
