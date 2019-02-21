//
//  SSUserInfoItemCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSUserInfoItemCell.h"

@implementation SSUserInfoItemCell

- (void)setItemFlag:(SSFlagsModel *)itemFlag
{
    _itemFlag = itemFlag;
    _content_label.text = itemFlag.dicValue;
    _content_label.layer.cornerRadius = 2.5;
    _content_label.layer.borderColor = kColor(@"999999").CGColor;
    _content_label.layer.borderWidth = 0.5;
    
    if (itemFlag.isSelect) {
        _content_label.layer.borderColor = kColor(@"D6B35B").CGColor;
        _content_label.textColor = kColor(@"D6B35B");
    }else{
        _content_label.layer.borderColor = kColor(@"999999").CGColor;
        _content_label.textColor = kColor(@"999999");
    }
}

@end
