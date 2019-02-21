//
//  SSFriendHomeVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "SSCircleListModel.h"

typedef NS_ENUM(NSInteger, SSFriendHomeVCType)
{
    SSFriendHomeVCTypeSelf,
    SSFriendHomeVCTypeOthers,
    SSFriendHomeVCTypeFriends,
};

@interface SSFriendHomeVC : FZBaseViewController

@property (nonatomic, strong) SSCircleListModel *listModel;
@property (nonatomic, assign) SSFriendHomeVCType vcType;

@end
