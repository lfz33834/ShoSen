//
//  SSCirclePublishHeader.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/24.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCirclePublishHeader.h"
#import "UITextView+ZWPlaceHolder.h"
//#import <ZWLimitCounter/UITextView+ZWLimitCounter.h>

@interface SSCirclePublishHeader()<UITextViewDelegate>

@end

@implementation SSCirclePublishHeader

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.content_textview.delegate = self;
    self.content_textview.zw_placeHolder = @"分享新鲜动态";
//    self.content_textview.zw_limitCount = 200;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.block) {
        
//        NSString*hString = [textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.block(textView.text);
//        if(textView.text.length > 70){
//            self.content_textview.text = [textView.text substringWithRange:NSMakeRange(0, 69)];
//            self.block([textView.text substringWithRange:NSMakeRange(0, 69)]);
//            [ProgressHUD showSuccess:@"输入超出范围"];
//        }else{
//            self.block(textView.text);
//        }
    }
}

@end
