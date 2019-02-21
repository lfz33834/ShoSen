//
//  SSOrderListViewModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSOrderListViewModel.h"

@implementation SSOrderListViewModel

- (void)feltOrderListWithBookPhone:(NSString*)phone callBack:(void(^)(NSMutableArray *dataList))dataList
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"bookPhone":account.phone};
    [FZHttpTool post:UserBookListUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        NSMutableArray *data = [SSOrderListModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        dataList(data);
    } failure:^(NSError *error) {
        [ProgressHUD showSuccess:@"请求失败"];
    }];

}

@end
