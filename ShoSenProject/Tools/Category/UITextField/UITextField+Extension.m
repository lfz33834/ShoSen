//
//  UITextField+Extension.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void)setPlaceHolderColor:(UIColor *)color
{
    [self setValue:color forKeyPath:@"placeholderLabel.textColor"];
}

- (BOOL)validateTextFieldTextLengh:(NSInteger )maxLength
{
    NSInteger kMaxLength = maxLength;
    NSString *toBeString = self.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                self.text = [toBeString substringToIndex:kMaxLength];
                //                [[XBAlertTools share] toastMessage:@"超出输入范围" resultBlock:nil];
                return YES;
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            self.text = [toBeString substringToIndex:kMaxLength];
            //            [[XBAlertTools share] toastMessage:@"超出输入范围" resultBlock:nil];
            return YES;
        }
    }
    return NO;
}

//限制输入的文本
//#define NUM @"0123456789"
//#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if(textField == _phone_textfield || textField == _usercard_textfield)
//    {
//        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        return [string isEqualToString:filtered];
//    }
//    return YES;
//}

@end
