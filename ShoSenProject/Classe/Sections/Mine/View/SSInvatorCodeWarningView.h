//
//  SSInvatorCodeWarningView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/27.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSInvatorCodeWarningViewBlock)(void);

@interface SSInvatorCodeWarningView : UIView
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UIButton *confirm_button;

@property (nonatomic, copy) SSInvatorCodeWarningViewBlock block;

- (void)showView;


@end

NS_ASSUME_NONNULL_END
