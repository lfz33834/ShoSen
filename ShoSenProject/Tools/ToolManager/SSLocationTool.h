//
//  SSLocationTool.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/7.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSLocationTool : NSObject
+(instancetype)share;
- (void)startLocation;
- (void)startLongTimeLocation;
- (void)initBaiduLocationCallBack:(void(^)(NSString *obj))callBack;
@end
