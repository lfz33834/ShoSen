//
//  SSNewsModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSNewsModel : NSObject

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, copy) NSString *news_Picture;
@property (nonatomic, copy) NSString *news_ReadNum;
@property (nonatomic, copy) NSString *news_Title;

@end
