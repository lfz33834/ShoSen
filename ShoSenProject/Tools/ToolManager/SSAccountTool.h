//
//  SSAccountTool.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSAccountTool : NSObject

+(instancetype)share;

- (void)saveAccount:(SSAccount *)account;
- (void)saveAccountData:(NSMutableDictionary *)account;

// 获得当前账号
@property (nonatomic, strong) SSAccount * account;


/**
 *  是否登录
 */
- (BOOL)isLogin;

/**
 *  退出app账户操作
 */
- (void)logoutAccount;

@end
