//
//  SSConfirmBookViewModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/20.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSConfirmBookViewModel.h"

@implementation SSConfirmBookViewModel

- (void)userBookOrderWithContactPhone:(NSString *)contactPhone invatationPhone:(NSString *)invatationPhone  bookMoney:(NSString *)bookMoney bookProvince:(NSString *)bookProvince bookCity:(NSString *)bookCity bookUsername:(NSString *)userName callBack:(void (^)(id obj))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"invitorPhone":invatationPhone,@"bookPhone":account.phone,@"contactPhone":contactPhone,@"bookMoney":bookMoney,@"bookProvince":bookProvince,@"bookCity":bookCity,@"bookName":userName};
    [FZHttpTool post:UserBookUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        block(json);
//        [ProgressHUD showSuccess:@"下单成功"];
     } failure:^(NSError *error) {
        [ProgressHUD showSuccess:@"下单失败"];
    }];
}

@end