//
//  SSHomeModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SSAnswerModel;
@interface SSHomeModel : NSObject

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *className;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *spanCount;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *subjectId;
@property (nonatomic, copy) NSString *selectAnswers;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *selectData;
@property (nonatomic, assign) int cellHeight;
@property (nonatomic, assign) int titleHeight;

@end

@interface SSAnswerModel : NSObject

@property (nonatomic, copy) NSString *answerID;
@property (nonatomic, copy) NSString *answerValue;
@property (nonatomic, assign) BOOL isSelected;


@end

