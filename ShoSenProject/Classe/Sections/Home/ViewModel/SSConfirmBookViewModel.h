//
//  SSConfirmBookViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/20.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSConfirmBookViewModel : NSObject

- (void)userBookOrderWithContactPhone:(NSString *)contactPhone invatationPhone:(NSString *)invatationPhone  bookMoney:(NSString *)bookMoney bookProvince:(NSString *)bookProvince bookCity:(NSString *)bookCity bookUsername:(NSString *)userName callBack:(void (^)(id obj))block;

@end