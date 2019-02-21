//
//  UILabel+Insets.m
//  qingsongchou
//
//  Created by CaoPing on 15/5/6.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import "UILabel+Insets.h"
#import <objc/runtime.h>

@implementation UILabel (Insets)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(drawTextInRect:);
        SEL swizzledSelector = @selector(cp_drawTextInRect:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (UIEdgeInsets)edgeInsets
{
    return [objc_getAssociatedObject(self, @selector(edgeInsets)) UIEdgeInsetsValue];
}

- (void)setEdgeInsets:(UIEdgeInsets)insets
{
    objc_setAssociatedObject(self, @selector(edgeInsets), [NSValue valueWithUIEdgeInsets:insets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cp_drawTextInRect:(CGRect)rect
{
    [self cp_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
