//
//  SSPerkHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSPerkHeaderType)
{
    SSPerkHeaderTypeWithDraw,
    SSPerkHeaderTypeInfo,
};

typedef void(^SSPerkHeaderViewBlock)(SSPerkHeaderType type);

@interface SSPerkHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *money_label;
@property (weak, nonatomic) IBOutlet UIButton *withdraw_button;
@property (nonatomic, copy) SSPerkHeaderViewBlock block;
@end
