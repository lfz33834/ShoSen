//
//  SSPSQItemCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/15.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPSQItemCell.h"

@implementation SSPSQItemCell

- (void)initCellWithModel:(SSHomeModel *)model
{
    if ([model.type intValue] == 0) {//单选
        
    }else if ([model.type intValue] == 1){//多选
        
    }
}

@end
