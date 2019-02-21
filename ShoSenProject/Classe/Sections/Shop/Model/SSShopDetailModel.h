//
//  SSShopDetailModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SSGoodSInfoModel;
@interface SSShopDetailModel : NSObject

@property (nonatomic, strong) SSGoodSInfoModel *info;
@property (nonatomic, strong) NSArray *productList;


@end


@interface SSProductListModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *stockCount;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *deleted;

@end

@interface SSGoodSInfoModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *counterPrice;
@property (nonatomic, copy) NSString *retailPrice;
@property (nonatomic, strong) NSArray *gallery;


@end

NS_ASSUME_NONNULL_END
