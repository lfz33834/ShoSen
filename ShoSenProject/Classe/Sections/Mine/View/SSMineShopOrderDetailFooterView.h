//
//  SSMineShopOrderDetailFooterView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/13.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ShopOrderDetaiViewType )
{
    ShopOrderDetaiTypePay,
    ShopOrderDetaiTypeCancel,
};

typedef NS_ENUM(NSInteger,ShopOrderDetaiButtonTapType )
{
    ShopOrderDetaiButtonTapTypeCancel,
    ShopOrderDetaiButtonTapTypePay,
    ShopOrderDetaiButtonTapTypeDelete,
    ShopOrderDetaiButtonTapTypeBuy,
};

typedef void(^SSMineShopOrderDetailFooterViewBlock)(ShopOrderDetaiButtonTapType buttonType);

@interface SSMineShopOrderDetailFooterView : UIView

@property (weak, nonatomic) IBOutlet UIButton *cancel_button;
@property (weak, nonatomic) IBOutlet UIButton *confirm_butotn;

@property (nonatomic, assign) ShopOrderDetaiViewType viewType;
@property (nonatomic, copy) SSMineShopOrderDetailFooterViewBlock block;

@end

NS_ASSUME_NONNULL_END
