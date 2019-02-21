//
//  SSShopLocationManagerVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "SSLocationModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSShopLocationManagerVCBlock)(SSLocationModel *locationModel);

@interface SSShopLocationManagerVC : FZBaseViewController

@property (nonatomic, strong) SSLocationModel *locationModel;
@property (nonatomic, copy) SSShopLocationManagerVCBlock block;


@end

NS_ASSUME_NONNULL_END
