//
//  SSShopOrderFooterView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSShopOrderFooterViewBlock)(void);

@interface SSShopOrderFooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *money_label;

@property (nonatomic, copy) SSShopOrderFooterViewBlock block;

@end

NS_ASSUME_NONNULL_END
