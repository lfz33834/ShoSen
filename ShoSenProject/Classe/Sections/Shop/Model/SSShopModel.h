//
//  SSShopModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SSFloorGoodsList;
@class SSShopBannerModel;
@class SSGoodsListModel;

@interface SSShopModel : NSObject

@property (nonatomic, strong) NSArray *banner;
@property (nonatomic, strong) NSArray *floorGoodsList;

@end

@interface SSShopBannerModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) BOOL deleted;


@end

@interface SSFloorGoodsList : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *goodsList;

@end

@interface SSGoodsListModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) BOOL isNew;
@property (nonatomic, assign) BOOL isHot;
@property (nonatomic, copy) NSString *counterPrice;
@property (nonatomic, copy) NSString *retailPrice;

@end

NS_ASSUME_NONNULL_END
