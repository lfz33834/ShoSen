//
//  SSMineHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MineHeaderTapType)
{
    MineHeaderTapTypeUserInfo,
    MineHeaderTapTypePartner,
    MineHeaderTapTypeLevel,
};

typedef void(^SSMineHeaderViewBlock)(MineHeaderTapType type);

@interface SSMineHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIView *header_view;
@property (nonatomic, copy) SSMineHeaderViewBlock block;
@property (weak, nonatomic) IBOutlet UILabel *header_label;
@property (weak, nonatomic) IBOutlet UIView *headerDetail_view;
@property (weak, nonatomic) IBOutlet UIButton *detail_button;

@property (weak, nonatomic) IBOutlet UILabel *nickname_label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_two;
@property (weak, nonatomic) IBOutlet UIButton *level_button;
@property (weak, nonatomic) IBOutlet UIView *headerLove_view;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerDetail_height_layout;
- (void)updateUserInfo;

@end
