//
//  SSAccount.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSAccount.h"

#define Kheadimg @"headimg"
#define Kname @"name"
#define Kphone @"phone"
#define Ksign @"sign"
#define Kstatus @"status"
#define Ktoken @"token"
#define Kuid @"uid"
#define Ktabs @"tabs"
#define Ktitle @"title"
#define Kprovince @"province"
#define Kcity @"city"
#define Ksex @"sex"
#define KrewardMoney @"rewardMoney"
#define KopenId @"openId"
#define KremainNum @"remainNum"
#define KorderNum @"orderNum"


@implementation SSAccount
//MJCodingImplementation
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_headimg forKey:Kheadimg];
    [aCoder encodeObject:_name forKey:Kname];
    [aCoder encodeObject:_phone forKey:Kphone];
    [aCoder encodeObject:_sign forKey:Ksign];
    [aCoder encodeObject:_status forKey:Kstatus];
    [aCoder encodeObject:_token forKey:Ktoken];
    [aCoder encodeObject:_uid forKey:Kuid];
    [aCoder encodeObject:_tabs forKey:Ktabs];
    [aCoder encodeObject:_title forKey:Ktitle];
    [aCoder encodeObject:_city forKey:Kcity];
    [aCoder encodeObject:_sex forKey:Ksex];
    [aCoder encodeObject:_rewardMoney forKey:KrewardMoney];
    [aCoder encodeObject:_openId forKey:KopenId];
    [aCoder encodeObject:_remainNum forKey:KremainNum];
    [aCoder encodeObject:_orderNum forKey:KorderNum];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _headimg = [aDecoder decodeObjectForKey:Kheadimg];
        _name = [aDecoder decodeObjectForKey:Kname];
        _phone = [aDecoder decodeObjectForKey:Kphone];
        _sign = [aDecoder decodeObjectForKey:Ksign];
        _status = [aDecoder decodeObjectForKey:Kstatus];
        _token = [aDecoder decodeObjectForKey:Ktoken];
        _uid = [aDecoder decodeObjectForKey:Kuid];
        _tabs = [aDecoder decodeObjectForKey:Ktabs];
        _title = [aDecoder decodeObjectForKey:Ktitle];
        _city = [aDecoder decodeObjectForKey:Kcity];
        _sex = [aDecoder decodeObjectForKey:Ksex];
        _rewardMoney = [aDecoder decodeObjectForKey:KrewardMoney];
        _openId = [aDecoder decodeObjectForKey:KopenId];
        _remainNum = [aDecoder decodeObjectForKey:KremainNum];
        _orderNum = [aDecoder decodeObjectForKey:KorderNum];
    }
    return self;
}

@end
