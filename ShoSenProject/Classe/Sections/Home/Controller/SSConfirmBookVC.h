//
//  SSConfirmBookVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

@interface SSConfirmBookVC : FZBaseViewController
@property (weak, nonatomic) IBOutlet UIView *info_view;
@property (weak, nonatomic) IBOutlet UITextField *name_textfield;
@property (weak, nonatomic) IBOutlet UITextField *phone_textfield;
@property (weak, nonatomic) IBOutlet UITextField *loction_textfield;
@property (strong, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet UIButton *location_button;
@property (weak, nonatomic) IBOutlet UILabel *service_label;
@property (weak, nonatomic) IBOutlet UITextField *invitation_textfield;
@property (weak, nonatomic) IBOutlet UIImageView *home_bg_imageview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *invatorPhoneview_height_layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoview_height_layout;
@property (weak, nonatomic) IBOutlet UIView *invator_view;

@end
