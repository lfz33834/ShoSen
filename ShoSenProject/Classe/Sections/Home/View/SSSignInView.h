//
//  SSSignInView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSSignInViewType)
{
    SSSignInViewTypeSuccess,
    SSSignInViewTypeFailure,
};

@interface SSSignInView : UIView
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;
@property (weak, nonatomic) IBOutlet UILabel *title_label;

- (void)initViewWithType:(SSSignInViewType )type;

- (void)showView;

@end
