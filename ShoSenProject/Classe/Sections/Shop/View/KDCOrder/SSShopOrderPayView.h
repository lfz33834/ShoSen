//
//  SSShopOrderPayView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/13.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SSShopOrderPayViewType)
{
   SSShopOrderPayViewTypeYuE,
    SSShopOrderPayViewTypeJiFen,
};

typedef void(^SSShopOrderPayViewBlock)(BOOL isSelect,NSString *money);

@interface SSShopOrderPayView : UIView
@property (weak, nonatomic) IBOutlet UILabel *yue_title_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yue_trailing_layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yue_height_layou;
@property (weak, nonatomic) IBOutlet UIView *yue_view;
@property (weak, nonatomic) IBOutlet UIView *yue_select_view;
@property (weak, nonatomic) IBOutlet UILabel *yue_num_label;
@property (weak, nonatomic) IBOutlet UIImageView *yue_imageview;
@property (weak, nonatomic) IBOutlet UILabel *yue_use_label;

@property (weak, nonatomic) IBOutlet UIView *jifen_view;
@property (weak, nonatomic) IBOutlet UILabel *jifenTotal_label;
@property (weak, nonatomic) IBOutlet UILabel *money_label;
@property (weak, nonatomic) IBOutlet UILabel *yunfei_label;

@property (nonatomic, copy) SSShopOrderPayViewBlock block;

@property (nonatomic, strong) BottomModel *model;

- (void)initViewWithTyp:(SSShopOrderPayViewType )type moddel:(BottomModel *)model;

@end

NS_ASSUME_NONNULL_END
