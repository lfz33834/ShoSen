//
//  SSCircleFriendHomeHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCircleListModel.h"

typedef NS_ENUM(NSInteger, SSCircleHomeHeaderViewType)
{
    SSCircleHomeHeaderViewTypeSixin,
    SSCircleHomeHeaderViewTypeGuanzhu,
    SSCircleHomeHeaderViewTypeHeader,
};

typedef NS_ENUM(NSInteger, SSCircleFriendHomeHeaderViewType)
{
    SSCircleFriendHomeHeaderViewTypeSlef,
    SSCircleFriendHomeHeaderViewTypeOthers,
    SSCircleFriendHomeHeaderViewTypeFriends,
};

typedef void(^SSCircleFriendHomeHeaderViewBlock)(SSCircleHomeHeaderViewType type);

@interface SSCircleFriendHomeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UIButton *sixin_button;
@property (weak, nonatomic) IBOutlet UIButton *guanzhu_button;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (nonatomic, copy) SSCircleFriendHomeHeaderViewBlock block;
@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic, assign) SSCircleFriendHomeHeaderViewType type;
@property (weak, nonatomic) IBOutlet UIButton *header_button;
@property (nonatomic, strong) SSCircleListModel *listModel;
- (void)initViewWithModel:(SSCircleListModel *)model;

@end
