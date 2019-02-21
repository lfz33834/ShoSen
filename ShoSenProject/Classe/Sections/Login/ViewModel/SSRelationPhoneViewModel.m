//
//  SSRelationPhoneViewModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/15.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSRelationPhoneViewModel.h"

@interface SSRelationPhoneViewModel()
@property(nonatomic,assign)NSInteger code;

@property(nonatomic,assign)NSInteger time;

@end

@implementation SSRelationPhoneViewModel

- (instancetype)init
{
    self =  [super init];
    if (self) {
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel
{
    @weakify(self);
    RACSignal *phoneSignal = [RACObserve(self, phoneNum) map:^id(id value) {
        @strongify(self);
        return @([self isPhoneNum:value]);
    }];
    RACSignal *codeSignal = [RACObserve(self, codeNum) map:^id(id value) {
        @strongify(self);
        return @([self isCodeNum:value]);
    }];
    self.canLoginSignal = [RACSignal combineLatest:@[phoneSignal,codeSignal] reduce:^id(NSNumber *phone,NSNumber *code){
        return @([phone boolValue]&&[code boolValue]);
    }];
    self.canCodeSignal = [RACSignal combineLatest:@[phoneSignal] reduce:^id(NSNumber *phone){
        return @([phone boolValue]);
    }];
    self.codeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        UIButton *btn = input;
        btn.enabled = NO;
        self.time = 60;
        [btn setTitle:[NSString stringWithFormat:@"%lds",(long)self.time] forState:UIControlStateNormal];
        __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCodeTime:) userInfo:btn repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [timer invalidate];
            timer               = nil;
            btn.enabled         = YES;
            [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
        });
        return [FZHttpTool postWithURL:LoginCodeUrl withParamater:@{@"phone":self.phoneNum,@"smsCode":@""}];
    }];
    
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary *params = @{@"openId":self.openID,@"name":self.nickName,@"picStr":self.picUrl,@"phone":self.phoneNum,@"smsCode":self.codeNum};
        return [FZHttpTool postWithURL:UserBindWechatUrl withParamater:params];
    }];
}

- (void)updateCodeTime:(NSTimer *)timer
{
    UIButton *btn = timer.userInfo;
    self.time--;
    if (self.time <= 0) {
        self.time = 60;
        [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
    } else {
        [btn setTitle:[NSString stringWithFormat:@"%lds",self.time] forState:UIControlStateNormal];
    }
}

- (BOOL)isPhoneNum:(NSString *)phoneNum
{
    if ([phoneNum hasPrefix:@"1"])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isCodeNum:(NSString *)codeNum
{
    return codeNum.length == 4;
}

//- (void)wechatWithImageUrl:(NSString *)imageUrl name:(NSString *)nickName openID:(NSString *)openID
//{
//    NSDictionary *params = @{@"openId":openID,@"name":nickName,@"picStr":imageUrl,@"phone":@"13366100567",@"smsCode":@"5505"};
//    [FZHttpTool post:UserLoginWechatUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
//
//    } failure:^(NSError * _Nullable error) {
//
//    }];
//}
@end
