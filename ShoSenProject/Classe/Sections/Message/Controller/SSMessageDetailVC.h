//
//  SSMessageDetailVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/23.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "SSCircleListModel.h"

@interface SSMessageDetailVC : FZBaseViewController

@property (nonatomic, strong) SSCircleListModel *model;
@property (nonatomic, copy) NSString *messageID;

@end
