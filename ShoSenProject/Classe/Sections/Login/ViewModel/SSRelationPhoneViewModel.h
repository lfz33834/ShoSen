//
//  SSRelationPhoneViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/15.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSRelationPhoneViewModel : NSObject

@property(nonatomic,strong)NSString     *phoneNum;

@property(nonatomic,strong)NSString     *codeNum;

@property(nonatomic, copy) NSString *nickName;
@property(nonatomic, copy) NSString *picUrl;
@property(nonatomic, copy) NSString *openID;

@property(nonatomic,strong)RACSignal    *phoneSignal;

@property(nonatomic,strong)RACSignal    *canLoginSignal;

/**是否可以点击发送验证码*/
@property(nonatomic,strong)RACSignal    *canCodeSignal;

@property(nonatomic,strong)RACCommand   *codeCommand;

@property(nonatomic,strong)RACCommand   *loginCommand;

@end
