//
//  SSShopOrderDetailCancelView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSShopOrderDetailCancelViewBlock)(NSString *title);

@interface SSShopOrderDetailCancelView : UIView

@property (weak, nonatomic) IBOutlet UITableView *item_tableview;
@property (weak, nonatomic) IBOutlet UIButton *wait_button;
@property (weak, nonatomic) IBOutlet UIButton *cancel_button;

@property (nonatomic,copy) SSShopOrderDetailCancelViewBlock block;

- (void)showCancelView;

@end

NS_ASSUME_NONNULL_END
