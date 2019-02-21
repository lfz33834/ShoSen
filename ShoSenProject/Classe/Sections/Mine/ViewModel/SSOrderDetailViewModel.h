//
//  SSOrderDetailViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/18.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSOrderDetailViewModel : NSObject

- (void)deleteOrderWithID:(NSString *)bookID callback:(void(^)(void))block;
- (void)cancelOrderWithID:(NSString *)bookID reson:(NSString *)cancelReason callback:(void(^)(void))block;
- (void)orderDetailWithID:(NSString *)bookID returnData:(void(^)(NSDictionary *data))block;

@end
