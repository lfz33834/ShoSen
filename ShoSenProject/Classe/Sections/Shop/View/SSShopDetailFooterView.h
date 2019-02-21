//
//  SSShopDetailFooterView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SSShopDetailFooterViewType)
{
    SSShopDetailFooterViewTypeBuy,
    SSShopDetailFooterViewTypeAddCar,
    SSShopDetailFooterViewTypeShop,
    SSShopDetailFooterViewTypeCar,
};

typedef void(^SSShopDetailFooterViewBlock)(SSShopDetailFooterViewType type);

@interface SSShopDetailFooterView : UIView

@property (weak, nonatomic) IBOutlet UIButton *buy_button;
@property (weak, nonatomic) IBOutlet UIButton *addcar_button;
@property (weak, nonatomic) IBOutlet UIButton *shop_button;
@property (weak, nonatomic) IBOutlet UIButton *car_button;
@property (weak, nonatomic) IBOutlet UILabel *num_label;

@property (nonatomic, copy) SSShopDetailFooterViewBlock block;

@end

NS_ASSUME_NONNULL_END
