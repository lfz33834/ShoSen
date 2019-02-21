//
//  SSShopOrderListCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSShopOrderListModel.h"


NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, SSShopOrderListCellType)
{
    SSShopOrderListCellTypePay,//支付
    SSShopOrderListCellTypeCancel,//取消订单
    SSShopOrderListCellTypeLogistics,//物流
    SSShopOrderListCellTypeBuy,//再次购买
    SSShopOrderListCellTypeReceiving,//确认收货
    SSShopOrderListCellTypeDelete,//删除
};

typedef void(^SSShopOrderListCellBlock)(SSShopOrderListCellType type);

@interface SSShopOrderListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *num_label;
@property (weak, nonatomic) IBOutlet UILabel *status_label;
@property (weak, nonatomic) IBOutlet UIButton *cancel_button;
@property (weak, nonatomic) IBOutlet UILabel *number_label;
@property (weak, nonatomic) IBOutlet UIButton *two_butotn;
@property (weak, nonatomic) IBOutlet UIButton *one_button;
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing_layout;

@property (nonatomic, copy) SSShopOrderListCellBlock block;
@property (nonatomic, strong) SSShopOrderListModel *model;
- (void)initViewWithModel:(SSShopOrderListModel *)model;

@end

NS_ASSUME_NONNULL_END
