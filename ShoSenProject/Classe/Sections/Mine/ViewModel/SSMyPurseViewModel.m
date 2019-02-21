//
//  SSMyPurseViewModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/24.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMyPurseViewModel.h"

@implementation SSMyPurseViewModel

- (void)myPurseYueCallback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"phone"] = account.phone;
    params[@"type"] = @"1,2,3,4";
    params[@"pageNum"] = @"1";

    [FZHttpTool get:kMoneyListUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        block(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)myPurseJiFenCallback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"phone"] = account.phone;
    params[@"type"] = @"3,5";
    params[@"pageNum"] = @"1";
    
    [FZHttpTool get:kXProListUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        block(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)chargeMoneyWithMoney:(NSString *)money callback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"phone"] = account.phone;
    params[@"val"] = money;
    
    [FZHttpTool post:kChargeMoney parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        block(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
