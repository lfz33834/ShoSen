//
//  SSCircleTwoView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSCircleTwoViewType)
{
   SSCircleTwoViewTypeNull,
   SSCircleTwoViewTypeFailure,
   SSCircleTwoViewTypeMall,
    SSCircleTwoViewTypeLevel,
};

typedef void(^SSCircleTwoViewBlock)(SSCircleTwoViewType type);

@interface SSCircleTwoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *confirm_button;
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (assign, nonatomic) SSCircleTwoViewType type;
@property (nonatomic, copy) SSCircleTwoViewBlock block;

- (void)initViewWithType:(SSCircleTwoViewType) type;

- (void)showView;
@end
