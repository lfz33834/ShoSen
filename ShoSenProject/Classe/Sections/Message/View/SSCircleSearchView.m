//
//  SSCircleSearchView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/31.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleSearchView.h"
#define isIOS(a) [[[UIDevice currentDevice]systemVersion] floatValue] == a

@interface SSCircleSearchView()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL isShow;

@end

@implementation SSCircleSearchView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.searchBar_view.layer.cornerRadius = 5;
    self.searchBar_view.layer.borderColor = kColor(@"f8f8f8").CGColor;
    self.searchBar_view.layer.borderWidth = 1;
    self.content_textfield.clearButtonMode= UITextFieldViewModeWhileEditing;
    self.content_textfield.delegate = self;
    self.content_textfield.returnKeyType = UIReturnKeySend;//改变为完成键，如果在项目中导入了YYText框架那么原生的就被替换掉了，变为returnKeyType = UIKeyboardTypeTwitter;
    self.search_right.constant = 15;
    self.cancel_button.hidden = YES;
    
    self.isShow = NO;
    
    [self.cancel_button addTarget:self action:@selector(cancelButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if ([string isEqualToString:@"\n"]) {
        
        [textField resignFirstResponder];//取消第一响应者
        
        if (self.block) {
            self.block(self.content_textfield.text);
            [UIView animateWithDuration:1 animations:^{
                self.search_right.constant = 15;
                self.cancel_button.hidden = YES;
            }];
            self.frame = CGRectMake(0, 0, kwidth, 80);
        }
        return NO;
    }
    
    return YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isShow) {
        self.frame = CGRectMake(0, 0, kwidth, kheight);
    }
}


- (void)cancelButtonTapAction
{
    [UIView animateWithDuration:1 animations:^{
        self.search_right.constant = 15;
        self.cancel_button.hidden = YES;
    }];
    self.frame = CGRectMake(0, 0, kwidth, 80);
    [self.content_textfield resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:1 animations:^{
        self.search_right.constant = 80;
        self.cancel_button.hidden = NO;
        self.isShow = YES;
    }];
    self.frame = CGRectMake(0, 0, kwidth, kheight);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:1 animations:^{
        self.search_right.constant = 15;
        self.cancel_button.hidden = YES;
        self.isShow = NO;
    }];
    self.frame = CGRectMake(0, 0, kwidth, 80);

}


@end
