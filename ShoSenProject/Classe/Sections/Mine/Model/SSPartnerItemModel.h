//
//  SSPartnerItemModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/8.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSPartnerItemModel : NSObject

@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, copy) NSString *moneyStr;
@property (nonatomic, assign) CGFloat heightCell;

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *invitSum;
@property (nonatomic, copy) NSString *reward;
@property (nonatomic, copy) NSString *rewardRemark;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *userPhone;


@end
