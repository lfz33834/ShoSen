//
//  FZAlertTool.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCNoticeAlertView.h"

typedef void (^confirm)(void);
typedef void (^cancle)(void);

@interface FZAlertTool : NSObject
{
    confirm confirmParam;
    cancle  cancleParam;
    
}

+(instancetype)share;

- (void)alertView:(NSString *)titleStr message:(NSString *)messageStr cancelTitle:(NSString *)cancelTitle confirm:(NSString *)confirmStr resultBlock:(WCNoticeAlertViewBlock)block;

+ (UIAlertController *)showActionSheetWithCurrentController:(UIViewController *)paramVC  withTitle:(NSString *)paramTitle withMessage:(NSString *)messageString withUIAlertControllerStyle:(UIAlertControllerStyle)style withOtherBtnTitle:(NSArray *)otherArr cancelHidden:(BOOL)state result:(void (^)(NSString * paramNavWayStr))result;

-(void)showAlertView:(UIViewController *)viewController title:(NSString *)title mes:(NSString *)message cancelBnt:(NSString *)cancelButtonTitle otherBnt:(NSString *)otherButtonTitle :(void (^)(void))confirm :(void (^)(void))cancle;
- (void)alertView:(NSString *)titleStr message:(NSString *)messageStr cancelTitle:(NSString *)cancelTitle confirm:(NSString *)confirmStr resultBlock:(WCNoticeAlertViewBlock)block;

-(void)loadingAnimation:(BOOL)state;

@end
