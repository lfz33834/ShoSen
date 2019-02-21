//
//  ShopModel.h
//  ShopCarDemo
//
//  Created by 周智勇 on 16/7/25.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject
@property (nonatomic, copy)NSString * shopTitle;//商品名称
@property (nonatomic, assign)float singlePrice;
@property (nonatomic, assign)BOOL selected;//店铺中的单个商品被选中
@property (nonatomic, assign)NSInteger count;

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *goodsSn;
//@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *productId;
//@property (nonatomic, copy) NSString *price;
//@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *checked;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *updateTime;

@end
