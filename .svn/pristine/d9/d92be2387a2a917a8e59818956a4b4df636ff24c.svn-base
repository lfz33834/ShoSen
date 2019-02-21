//
//  SSInvationCodeCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CodeType)
{
   CodeTypeRule,
   CodeTypeInvatation,
};

typedef void(^SSInvationCodeCellBlock)(CodeType type);

@interface SSInvationCodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *subTitle_label;
@property (weak, nonatomic) IBOutlet UILabel *code_label;
@property (weak, nonatomic) IBOutlet UIButton *invation_button;
@property (weak, nonatomic) IBOutlet UIView *rule_view;

@property (nonatomic, copy) SSInvationCodeCellBlock block;

@end
