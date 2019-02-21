//
//  SSLoginViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewModel.h"

@interface SSLoginViewModel : FZBaseViewModel

@property(nonatomic,strong)NSString     *phoneNum;

@property(nonatomic,strong)NSString     *codeNum;

@property(nonatomic,strong)RACSignal    *phoneSignal;

@property(nonatomic,strong)RACSignal    *canLoginSignal;

/**是否可以点击发送验证码*/
@property(nonatomic,strong)RACSignal    *canCodeSignal;

@property(nonatomic,strong)RACCommand   *codeCommand;

@property(nonatomic,strong)RACCommand   *loginCommand;

@end
