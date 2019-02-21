//
//  SSShopOrderListModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  SSHandleOptionModel;

NS_ASSUME_NONNULL_BEGIN

@interface SSShopOrderListModel : NSObject

@property (nonatomic, copy) NSString *orderStatusText;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, assign) BOOL isGroupin;
@property (nonatomic, copy) NSString *orderSn;
@property (nonatomic, copy) NSString *actualPrice;
@property (nonatomic, strong) NSArray *goodsList;
@property (nonatomic, strong) NSArray *handleOption;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *ID;

@end

@interface SSShopOrderInfoModel : NSObject

@property (nonatomic, copy) NSString *consignee;
@property (nonatomic, copy) NSString *orderStatusText;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *orderSn;
@property (nonatomic, copy) NSString *actualPrice;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *freightPrice;//运费
@property (nonatomic, copy) NSString *balancePrice;//余额
@property (nonatomic, copy) NSString *countDownStamp;//
@property (nonatomic, copy) NSString *orderType;//balance余额integral积分
@property (nonatomic, strong) SSHandleOptionModel *handleOption;


@end

@interface SSShopOrderGoodsListModel : NSObject

@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *goodsSn;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) BOOL deleted;

@end

@interface SSHandleOptionModel : NSObject

@property (nonatomic, assign) BOOL cancel;
@property (nonatomic, assign) BOOL deleteType;
@property (nonatomic, assign) BOOL pay;
@property (nonatomic, assign) BOOL comment;
@property (nonatomic, assign) BOOL confirm;
@property (nonatomic, assign) BOOL refund;
@property (nonatomic, assign) BOOL rebuy;

@end

NS_ASSUME_NONNULL_END
