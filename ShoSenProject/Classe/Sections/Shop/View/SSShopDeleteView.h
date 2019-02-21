//
//  SSShopDeleteView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SSShopDeleteViewType)
{
    SSShopDeleteViewTypeDelete,
    SSShopDeleteViewTypeExchange,
    SSShopDeleteViewTypeYueExchange,
    SSShopDeleteViewTypePay,
};

typedef void(^SSShopDeleteViewBlock)(SSShopDeleteViewType viewType);

@interface SSShopDeleteView : UIView
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UIButton *confirm_button;
@property (weak, nonatomic) IBOutlet UIButton *cancel_button;
@property (weak, nonatomic) IBOutlet UILabel *title_label;

@property (nonatomic, assign) SSShopDeleteViewType viewType;
@property (nonatomic, copy) SSShopDeleteViewBlock block;

- (void)initViewWithType:(SSShopDeleteViewType)viewType;

- (void)showView;

@end

NS_ASSUME_NONNULL_END
