//
//  SSPartnerItemModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/8.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPartnerItemModel.h"
#import "UILabel+Extension.h"

@implementation SSPartnerItemModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

- (CGFloat)heightCell
{
    if (self.contentStr && self.contentStr.length > 0 ) {
        UILabel *lab = [UILabel itemLabelWithFream:CGRectMake(0, 0, kwidth - 80, 0) withTextString:self.contentStr withTextColor:[UIColor blackColor] withFontSize:15 withBold:NO withTextAlignment:0];
        lab.numberOfLines = 0;
        [lab sizeToFit];
        CGFloat labHeight = CGRectGetHeight(lab.frame);
        return labHeight + 20;
    }
    return 0;
}

@end
