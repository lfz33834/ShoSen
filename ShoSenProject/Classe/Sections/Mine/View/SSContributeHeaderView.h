//
//  SSContributeHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SSContributeHeaderViewBlock)(void);

@interface SSContributeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *contributeNum_label;
@property (weak, nonatomic) IBOutlet UILabel *contributecontent_label;
@property (weak, nonatomic) IBOutlet UIButton *detail_button;
@property (weak, nonatomic) IBOutlet UIView *level_view;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (nonatomic, copy) SSContributeHeaderViewBlock block;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading_layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_layout;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;

@property (weak, nonatomic) IBOutlet UIView *header_bg_view;

@end
