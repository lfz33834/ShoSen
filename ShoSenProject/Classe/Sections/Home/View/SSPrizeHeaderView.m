//
//  SSPrizeHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPrizeHeaderView.h"
#import "LuckyDrawView.h"
#import "SSCircleView.h"
#import "SSCircleTwoView.h"

@interface SSPrizeHeaderView()

@property (nonatomic, strong) SSCircleView *circle_oneview;
@property (nonatomic, strong) SSCircleTwoView *circel_twoview;

@end

@implementation SSPrizeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    self.circleView = [NSBundle mainBundle]loadNibNamed:@"" owner:<#(nullable id)#> options:<#(nullable NSDictionary *)#>
//   self.luk = [[LuckyDrawView alloc]initWithFrame:CGRectMake(0, 0, kwidth - 80, kwidth - 80)];
//   WEAKSELF
//    self.luk.block = ^(NSDictionary *data) {
//        if([data[@"data"] intValue] == -1){
//            SSAccount *account = [SSAccountTool share].account;
//            if ([account.level intValue] < 3) {
//                [weakSelf.circel_twoview initViewWithType:SSCircleTwoViewTypeLevel];
//            }
//            [weakSelf.circel_twoview initViewWithType:SSCircleTwoViewTypeNull];
//            [weakSelf.circel_twoview showView];
//        }else if ([data[@"data"] intValue] == 5){
//            [weakSelf.circel_twoview initViewWithType:SSCircleTwoViewTypeFailure];
//            [weakSelf.circel_twoview showView];
//        }else{
//            NSArray *dataArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"jiangpin"];
//            [dataArray enumerateObjectsUsingBlock:^(NSDictionary   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if([obj[@"sortNum"] intValue] -1 == [data[@"data"] intValue])
//                {
//                    [weakSelf.circle_oneview  initViewWithContent:obj[@"dicValue"]];
//                    [weakSelf.circle_oneview showView];
//                }
//            }];
//        }
//        weakSelf.title_label.text = [NSString stringWithFormat:@"剩余抽奖次数%@次",data[@"time"]];
//    };
//    [self.circle_view addSubview:self.luk];
    WEAKSELF
    self.circleview.block = ^(NSDictionary *data) {
       
        if([data[@"data"] intValue] == -1){
            SSAccount *account = [SSAccountTool share].account;
            if ([account.level intValue] < 3) {
                [weakSelf.circel_twoview initViewWithType:SSCircleTwoViewTypeLevel];
            }else{
                [weakSelf.circel_twoview initViewWithType:SSCircleTwoViewTypeNull];
            }
            [weakSelf.circel_twoview showView];
        }else if ([data[@"data"] intValue] == 5){
            [weakSelf.circel_twoview initViewWithType:SSCircleTwoViewTypeFailure];
            [weakSelf.circel_twoview showView];
        }else{
            NSArray *dataArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"jiangpin"];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if([obj[@"sortNum"] intValue] -1 == [data[@"data"] intValue])
                {
                    NSString *contentStr = @"";
                    NSArray *contentArray = [obj[@"dicValue"] componentsSeparatedByString:@","];
                    if (contentArray.count == 2) {
                        contentStr = [NSString stringWithFormat:@"%@%@",contentArray[0],contentArray[1]];
                    }else{
                        contentStr = obj[@"dicValue"];
                    }
                    [weakSelf.circle_oneview  initViewWithContent:[NSString stringWithFormat:@"恭喜你获得%@",contentStr]];
                    [weakSelf.circle_oneview showView];
                }
            }];
        }
        weakSelf.title_label.text = [NSString stringWithFormat:@"剩余抽奖次数%@次",data[@"time"]];
    };
    [self.lookPrize_button addTarget:self action:@selector(lookinPrizeTapAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initCircelViewWithArray:(NSMutableArray *)dataArray
{
    [self.circleview initCellWichModel:dataArray];
}

- (void)lookinPrizeTapAction
{
    self.block(SSPrizeHeaderViewTypeRewardList);
}



- (SSCircleTwoView *)circel_twoview
{
    if (_circel_twoview == nil) {
        WEAKSELF
        _circel_twoview = [[[NSBundle mainBundle]loadNibNamed:@"SSCircleTwoView" owner:self options:nil]lastObject];
        _circel_twoview.frame = CGRectMake(0, 0, kwidth, kheight);
        _circel_twoview.block = ^(SSCircleTwoViewType type) {
            if (type == SSCircleTwoViewTypeNull) {
                weakSelf.block(SSPrizeHeaderViewTypeDianjiNull);
            }else if (type == SSCircleTwoViewTypeFailure)
            {
                [weakSelf.circleview beignRotaion];
            }
        };
    }
    return _circel_twoview;
}

- (SSCircleView *)circle_oneview
{
    if (_circle_oneview == nil) {
        _circle_oneview = [[[NSBundle mainBundle]loadNibNamed:@"SSCircleView" owner:self options:nil]lastObject];
        _circle_oneview.frame = CGRectMake(0, 0, kwidth, kheight);

    }
    return _circle_oneview;
}

@end
