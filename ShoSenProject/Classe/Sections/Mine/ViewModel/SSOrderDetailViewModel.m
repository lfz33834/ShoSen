//
//  SSOrderDetailViewModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/18.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSOrderDetailViewModel.h"

@implementation SSOrderDetailViewModel

- (void)deleteOrderWithID:(NSString *)bookID callback:(void(^)(void))block
{
    NSDictionary *params = @{@"bookId":bookID,@"cancelReason":@""};
    [FZHttpTool post:UserBookDeleteUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        [ProgressHUD showSuccess:@"删除成功"];
        block();
    } failure:^(NSError *error) {
        [ProgressHUD showSuccess:@"删除失败"];
    }];
}
- (void)cancelOrderWithID:(NSString *)bookID reson:(NSString *)cancelReason callback:(void(^)(void))block
{
    NSDictionary *params = @{@"bookId":bookID,@"cancelReason":cancelReason};
    [FZHttpTool post:UserBookCancelUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        [ProgressHUD showSuccess:@"取消成功"];
        block();
    } failure:^(NSError *error) {
        [ProgressHUD showSuccess:@"取消失败"];
    }];
}
- (void)orderDetailWithID:(NSString *)bookID returnData:(void(^)(NSDictionary *data))block
{
    NSDictionary *params = @{@"bookId":bookID};
    [FZHttpTool post:UserBookDetailUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        block(json);
    } failure:^(NSError *error) {
        [ProgressHUD showSuccess:@"请求失败"];
    }];
}

@end
