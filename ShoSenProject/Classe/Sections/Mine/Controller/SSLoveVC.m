//
//  SSLoveVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2019/2/13.
//  Copyright © 2019年 lifuzhou. All rights reserved.
//

#import "SSLoveVC.h"

@interface SSLoveVC ()

@end

@implementation SSLoveVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"公益慈善"];
    [self feltData];
}

- (void)feltData
{
    [FZHttpTool get:LoveChariSum parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        NSDictionary *dicData = json[@"data"];
        if ([dicData[@"IsAllPay"] intValue] == 0){
            self.title_imageview.hidden = YES;
            self.love_subTitle.hidden = YES;
            self.money_title.text = dicData[@"allBig"];
        }else{
            self.title_imageview.hidden = NO;
            self.love_subTitle.hidden = NO;
            self.love_subTitle.text = [NSString stringWithFormat:@"感谢您!已成功向慈善机构捐赠%@元",dicData[@"SingBig"]];
            self.money_title.text = dicData[@"allBig"];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
