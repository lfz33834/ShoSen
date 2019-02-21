//
//  SSCircleView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSCircleView : UIView
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UIButton *confirm_button;
@property (weak, nonatomic) IBOutlet UILabel *content_label;

- (void)initViewWithContent:(NSString *)contentStr;
- (void)showView;
@end
