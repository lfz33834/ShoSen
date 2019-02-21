//
//  SSAccount.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSAccount : NSObject<NSCoding>

@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *sign;//签名
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *tabs;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *rewardMoney;
@property (nonatomic, copy) NSString *contribution;
//@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *remainNum;
@property (nonatomic, copy) NSString *orderNum;
@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *xProperty;//积分
@property (nonatomic, copy) NSString *money;//钱
@property (nonatomic, copy) NSString *invitorPhone;//推荐人手机号



@end
