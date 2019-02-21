//
//  SSCircleCommentDelView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SSCircleCommentDelViewType) {
    SSCircleCommentDelViewTypeCancel,
    SSCircleCommentDelViewTypeDel,
};

typedef void(^SSCircleCommentDelViewBlock)(SSCircleCommentDelViewType type);

@interface SSCircleCommentDelView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancel_button;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property (nonatomic, copy) SSCircleCommentDelViewBlock block;


- (void)showDelView;
@end
