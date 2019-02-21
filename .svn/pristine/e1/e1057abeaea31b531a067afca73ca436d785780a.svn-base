//
//  SSCircleInputView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/29.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MaxTextViewHeight 80 //限制文字输入的高度


typedef NS_ENUM(NSInteger,SSCircleInputType) {
    SSCircleInputTypeMessage,
    SSCircleInputTypeEditeMessage,
};

typedef void(^SSCircleInputViewBlock)(SSCircleInputType type);

@interface SSCircleInputView : UIView
@property (weak, nonatomic) IBOutlet UIView *edite_view;
@property (weak, nonatomic) IBOutlet UIButton *message_button;
@property (copy, nonatomic) SSCircleInputViewBlock block;
@property (weak, nonatomic) IBOutlet UITextView *content_textview;

//------ 发送文本 -----//
@property (nonatomic,copy) void (^SSInputViewTextBlock)(NSString *text);
//------  设置占位符 ------//
- (void)setPlaceholderText:(NSString *)text;

@end
