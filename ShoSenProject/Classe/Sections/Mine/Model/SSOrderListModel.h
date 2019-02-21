//
//  SSOrderListModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSOrderListModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *moneyString;

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) NSString *bookMoney;
@property (nonatomic, copy) NSString *bookRemark;
@property (nonatomic, copy) NSString *bookStatus;//`BookStatus` int(1) DEFAULT '1' COMMENT '1:接收预定2:己缴预定款3:己缴全款4:取消定单5:删除定单',
@property (nonatomic, copy) NSString *bookTime;
@property (nonatomic, copy) NSString *bookUserName;
@property (nonatomic, copy) NSString *bookUserPhone;
@property (nonatomic, copy) NSString *invatationUserPhone;

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *invitorUserName;
@property (nonatomic, copy) NSString *invitorUserPhone;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *province;


@end
