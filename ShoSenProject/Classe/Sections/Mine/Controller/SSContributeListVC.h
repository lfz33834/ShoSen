//
//  SSContributeListVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

typedef NS_ENUM(NSInteger, SSContributeListVCType) {
    SSContributeListVCTypeCurrent,
    SSContributeListVCTypeAll,
};

@interface SSContributeListVC : FZBaseViewController

@property (nonatomic,assign) SSContributeListVCType type;

@end
