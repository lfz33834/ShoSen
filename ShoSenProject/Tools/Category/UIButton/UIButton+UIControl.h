//
//  UIButton+UIControl.h
//  WeiChuan
//
//  Created by lifuzhou on 2018/6/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval 1//默认时间间隔

@interface UIButton (UIControl)

@property(nonatomic,assign)NSTimeInterval timeInterval;//用这个给重复点击加间隔

@property(nonatomic,assign)BOOL isIgnoreEvent;//YES不允许点击NO允许点击

@end


