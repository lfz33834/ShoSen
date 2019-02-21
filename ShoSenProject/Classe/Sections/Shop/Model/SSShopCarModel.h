//
//  SSShopCarModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/13.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopModel.h"
NS_ASSUME_NONNULL_BEGIN

@class SSShopCartTotalModel;


@interface SSShopCarModel : NSObject

@property (nonatomic, strong) SSShopCartTotalModel *cartTotal;
@property (nonatomic, strong) NSMutableArray *cartList;

@end

@interface SSShopCartTotalModel : NSObject

@property (nonatomic, copy) NSString *goodsCount;
@property (nonatomic, copy) NSString *checkedGoodsCount;
@property (nonatomic, copy) NSString *goodsAmount;

@end

//@interface SSShopCartListModel : NSObject
//
//@property (nonatomic, copy) NSString *ID;
//@property (nonatomic, copy) NSString *userId;
//@property (nonatomic, copy) NSString *goodsId;
//@property (nonatomic, copy) NSString *goodsSn;
//@property (nonatomic, copy) NSString *goodsName;
//@property (nonatomic, copy) NSString *productId;
//@property (nonatomic, copy) NSString *price;
//@property (nonatomic, copy) NSString *number;
//@property (nonatomic, copy) NSString *checked;
//@property (nonatomic, copy) NSString *picUrl;
//@property (nonatomic, copy) NSString *addTime;
//@property (nonatomic, copy) NSString *updateTime;
//
//@end


NS_ASSUME_NONNULL_END
