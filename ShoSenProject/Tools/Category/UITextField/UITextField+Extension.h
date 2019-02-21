//
//  UITextField+Extension.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

- (void)setPlaceHolderColor:(UIColor *)color;
- (BOOL)validateTextFieldTextLengh:(NSInteger )maxLength;

@end
