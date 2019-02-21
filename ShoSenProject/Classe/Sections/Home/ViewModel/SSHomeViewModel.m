//
//  SSHomeViewModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSHomeViewModel.h"
#import "SSHomeModel.h"

@implementation SSHomeViewModel

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
        SSHomeModel *model1 = [[SSHomeModel alloc]init];
        model1.titleStr = @"违章查询";
        model1.imageName = @"home_cell_car";
        model1.className = @"";
        [_dataArray addObject:model1];
        SSHomeModel *model2 = [[SSHomeModel alloc]init];
        model2.titleStr = @"道路救援";
        model2.imageName = @"home_cell_save";
        model2.className = @"";
        [_dataArray addObject:model2];
        SSHomeModel *model3 = [[SSHomeModel alloc]init];
        model3.titleStr = @"保险服务";
        model3.imageName = @"home_cell_service";
        model3.className = @"";
        [_dataArray addObject:model3];
        SSHomeModel *model4 = [[SSHomeModel alloc]init];
        model4.titleStr = @"代驾";
        model4.imageName = @"home_cell_drive";
        model4.className = @"";
        [_dataArray addObject:model4];
        SSHomeModel *model5 = [[SSHomeModel alloc]init];
        model5.titleStr = @"洗车";
        model5.imageName = @"home_cell_carwash";
        model5.className = @"";
        [_dataArray addObject:model5];
        SSHomeModel *model6 = [[SSHomeModel alloc]init];
        model6.titleStr = @"充电桩";
        model6.imageName = @"home_cell_charge";
        model6.className = @"";
        [_dataArray addObject:model1];
    }
    return _dataArray;
}

//签到
- (void)homeSignInWithPhoneCallBack:(void(^)(id json))back
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"phone":account.phone};
    [FZHttpTool post:UserBaseSignLogin parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//奖品列表
- (void)gameRewardListWithPhoneCallBack:(void(^)(id json))back
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"phone":account.phone};
    [FZHttpTool post:UserGameRewardList parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}


//咨询列表
- (void)newsCallBack:(void(^)(id json))back
{
     [FZHttpTool get:UserBaseNewss parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//获奖列表
- (void)prizeListCallBack:(void(^)(id json))back
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/dictionary?type=14"];
    [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//获得奖项
- (void)feltPrizeWithPhoneCallBack:(void(^)(id json))back
{
    SSAccount *account = [SSAccountTool share].account;
    NSString *url = [NSString stringWithFormat:@"%@/game/reward?phone=%@",BaseUrl,account.phone];
    [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//中奖名单接口
- (void)gamerewardRecordCallBack:(void(^)(id json))back
{
      [FZHttpTool get:UserGamerewardRecord parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//抽奖次数接口
- (void)gameintReTimeWithPhoneCallBack:(void(^)(id json))back
{
    SSAccount *account = [SSAccountTool share].account;
    NSString *url = [NSString stringWithFormat:@"%@/game/intReTime?phone=%@",BaseUrl,account.phone];
    [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//抽奖的说明
- (void)prizeGameInfoCallBack:(void(^)(id json))back
{
    NSString *url = [NSString stringWithFormat:@"%@/base/dictionary?type=1000",BaseUrl];
    [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)psqLookinWithModel:(NSMutableArray *)dataArray callBack:(void(^)(id json))back
{
    NSMutableArray *paramArray = [[NSMutableArray alloc]init];
    SSAccount *account = [SSAccountTool share].account;
    [dataArray enumerateObjectsUsingBlock:^(SSHomeModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dicData = [[NSMutableDictionary alloc]init];
        NSMutableArray *answers = [[NSMutableArray alloc]init];
        dicData[@"userId"] = account.uid;
        dicData[@"subjectId"] = obj.subjectId;
        [obj.data enumerateObjectsUsingBlock:^(SSAnswerModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelected) {
                [answers addObject:obj.answerID];
            }
        }];
        dicData[@"answerId"] = [answers componentsJoinedByString:@","];
        [paramArray addObject:dicData];
    }];
    NSData *data = [NSJSONSerialization dataWithJSONObject:paramArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [FZHttpTool postBoyWithUrl:UserBaseSubjectAns body:jsonStr showLoading:YES httpToolSuccess:^(id  _Nullable json) {
        back(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
