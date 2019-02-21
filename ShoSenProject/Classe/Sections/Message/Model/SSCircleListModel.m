//
//  SSCircleListModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/25.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleListModel.h"

@implementation SSCircleListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

- (NSString *)content
{
    return [_content URLDecodedString];
}

- (CGFloat)contentHeight
{
    if (self.content && self.content.length > 0 ) {
        UILabel *lab = [UILabel  itemLabelWithFream:CGRectMake(0, 0, kwidth - 60, 0) withTextString:self.content withTextColor:[UIColor blackColor] withFontSize:16 withBold:NO withTextAlignment:0];
        lab.numberOfLines = 0;
        [lab sizeToFit];
        CGFloat labHeight = CGRectGetHeight(lab.frame);
        return labHeight + 10;
    }
    return 0;
}

- (CGFloat)maxContentHeight
{
    return 120;
}

- (CGFloat)bottomViewHeight
{
    if (self.location.length > 0) {
        return 100;
    }
    return 70;
}

- (CGFloat)cirledetail_bottomViewHeight
{
    if (self.location.length > 0) {
        return 130;
    }
    return 80;
}

- (CGFloat)imageHeight
{
    if (self.picture.length > 1) {
        NSArray *picArray = [self.picture componentsSeparatedByString:@","];
        if (picArray.count == 1) {
            return  180;
        }else{
            NSInteger lineNum = picArray.count/3;
            NSInteger morePic = picArray.count%3;
            if (morePic > 0) {
                return 100*(lineNum + 1);
            }else{
                return 100*lineNum;
            }
        }
    }
    return 0;
}

@end