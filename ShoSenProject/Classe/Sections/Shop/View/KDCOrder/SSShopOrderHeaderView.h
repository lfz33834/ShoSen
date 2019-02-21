//
//  SSShopOrderHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLocationModel.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^SSShopOrderHeaderViewBlock)(void);

@interface SSShopOrderHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *location_view;
@property (weak, nonatomic) IBOutlet UILabel *info_label;
@property (weak, nonatomic) IBOutlet UILabel *default_label;
@property (weak, nonatomic) IBOutlet UILabel *location_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *default_label_width_layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *location_label_leading;
@property (nonatomic, copy) SSShopOrderHeaderViewBlock block;

@property (nonatomic, strong) SSLocationModel *locationModel;

@end

NS_ASSUME_NONNULL_END
