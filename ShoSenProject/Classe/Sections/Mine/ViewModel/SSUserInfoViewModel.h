//
//  SSUserInfoViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/28.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSUserInfoViewModel : NSObject

- (void)feltFlags:(void(^)(NSMutableArray *data_arrray))callBack;
- (void)feltStatus:(void(^)(NSMutableArray *data_arrray))callBack;
- (void)updateUserInfoHeaderImage:(NSString *)imageFile nickName:(NSString *)nikname signature:(NSString *)signature sex:(NSString *)sex status:(NSString *)status location:(NSString *)province city:(NSString *)city flags:(NSMutableArray *)flags callback:(void(^)(id object))callBack;
@end
