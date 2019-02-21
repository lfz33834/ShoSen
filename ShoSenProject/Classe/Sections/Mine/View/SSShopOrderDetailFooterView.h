//
//  SSShopOrderDetailFooterView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSShopOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSShopOrderDetailFooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *orderNo_label;
@property (weak, nonatomic) IBOutlet UILabel *orderTime_label;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice_label;
@property (weak, nonatomic) IBOutlet UILabel *yunfei_label;
@property (weak, nonatomic) IBOutlet UILabel *yue_label;
@property (weak, nonatomic) IBOutlet UILabel *total_lable;
@property (weak, nonatomic) IBOutlet UILabel *yue_title_label;

- (void)initViewWithModel:(SSShopOrderInfoModel *)model orderModel:(SSShopOrderListModel*)orderModel;

@end

NS_ASSUME_NONNULL_END
