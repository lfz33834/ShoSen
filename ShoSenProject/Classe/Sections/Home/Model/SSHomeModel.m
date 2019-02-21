//
//  SSHomeModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSHomeModel.h"

@implementation SSHomeModel

- (int)cellHeight
{
    CGFloat labHeight = [self.title calculateHeightWithWidth:kwidth - 30 Font:15] + 10;
    int num = [self.spanCount intValue];
    int lineNum = (int)self.data.count/num;
    CGFloat itemHeight = 0 ;
    if (self.data.count%num > 0) {
        itemHeight = 40*(lineNum + 1);
    }else{
        itemHeight = 40*lineNum;
    }
    return labHeight + itemHeight + 35;
}

- (int)titleHeight
{
    CGFloat labHeight = [self.title calculateHeightWithWidth:kwidth - 30 Font:15] + 10;
    return labHeight;
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data" : @"SSAnswerModel"
             };
}
@end

@implementation SSAnswerModel

@end

