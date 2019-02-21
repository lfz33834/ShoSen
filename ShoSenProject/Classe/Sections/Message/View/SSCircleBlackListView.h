//
//  SSCircleBlackListView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SSCircleBlackListViewBlock)(void);

@interface SSCircleBlackListView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancel_button;
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UIButton *confirm_button;

@property (nonatomic, copy) SSCircleBlackListViewBlock block;
- (void)showView;
@end
