//
//  WCNoticeAlertView.h
//  WeiChuan
//
//  Created by lifuzhou on 2018/5/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WCNoticeAlertViewType) {
    WCNoticeAlertViewTypeCancel,
    WCNoticeAlertViewTypeConfirm,
};

typedef void(^WCNoticeAlertViewBlock)(WCNoticeAlertViewType type);
@interface WCNoticeAlertView : UIView

@property (nonatomic, copy) WCNoticeAlertViewBlock block;
@property (nonatomic, strong) NSDictionary *dicData;
- (void)showNoticeView;
+ (instancetype)shareInstance;

@end
