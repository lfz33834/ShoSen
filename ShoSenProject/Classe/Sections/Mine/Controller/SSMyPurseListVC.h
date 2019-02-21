//
//  SSMyPurseListVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/21.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SSMyPurseListVCType)
{
    SSMyPurseListVCTypeJiFen,
    SSMyPurseListVCTypeYue,
};

@interface SSMyPurseListVC : FZBaseViewController

@property (nonatomic, assign)SSMyPurseListVCType vcType;

@end

NS_ASSUME_NONNULL_END
