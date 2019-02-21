//
//  SSShopOrderDetailHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSShopOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSShopOrderDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *wuliu_label;
@property (weak, nonatomic) IBOutlet UILabel *user_label;
@property (weak, nonatomic) IBOutlet UILabel *location_label;
@property (weak, nonatomic) IBOutlet UILabel *status_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;

@property (weak, nonatomic) IBOutlet UILabel *paystatus_label;
- (void)initViewWithModel:(SSShopOrderInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
