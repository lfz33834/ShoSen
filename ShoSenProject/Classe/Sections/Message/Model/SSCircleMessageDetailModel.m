//
//  SSCircleMessageDetailModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleMessageDetailModel.h"

@implementation SSCircleMessageDetailModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"commontList" : @"SSCircleMessageDetailModel"
             };
}


- (CGFloat)content_height
{
    if (self.content && self.content.length > 0 ) {
//        CGFloat labHeight = [self.content calculateHeightWithWidth:kwidth - 150 Font:15] + 10;

        UILabel *lab = [UILabel  itemLabelWithFream:CGRectMake(0, 0, kwidth - 150, 0) withTextString:self.content withTextColor:[UIColor blackColor] withFontSize:15 withBold:NO withTextAlignment:0];
        lab.numberOfLines = 0;
        [lab sizeToFit];
        CGFloat labHeight = CGRectGetHeight(lab.frame);
        return labHeight;
    }
    return 0;
}

- (CGFloat)commont_height
{

    if (self.content && self.content.length > 0 ) {
//        UILabel *lab = [UILabel  itemLabelWithFream:CGRectMake(0, 0, kwidth - 160, 0) withTextString:self.content withTextColor:[UIColor blackColor] withFontSize:15 withBold:NO withTextAlignment:0];
//        lab.numberOfLines = 0;
//        [lab sizeToFit];
//        CGFloat labHeight = CGRectGetHeight(lab.frame)+10;
        CGFloat labHeight = [self.content calculateHeightWithWidth:kwidth - 155 Font:15] + 10;

        return labHeight;
    }
    return 0;
}

- (CGFloat)tableview_height
{
    if(self.commontList.count == 0)
    {
        return 0;
    }
    CGFloat commont_height = 0;
    for (int i = 0; i < self.commontList.count; i++) {
        SSCircleMessageDetailModel *model = self.commontList[i];
        NSString *contentString ;
        if ([model.ID intValue] == [model.parentId intValue]) {
            contentString = [NSString stringWithFormat:@"%@:%@",model.name,model.content];
        }else{
            contentString = [NSString stringWithFormat:@"%@回复%@:%@",model.name,model.parentName,model.content];
        }
        
        CGFloat labHeight = 0;
        
        labHeight = [contentString calculateHeightWithWidth:kwidth - 155 Font:15] + 10;
//        if (self.content && self.content.length > 0 ) {
//            UILabel *lab = [UILabel  itemLabelWithFream:CGRectMake(0, 0, kwidth - 160, 0) withTextString:self.content withTextColor:[UIColor blackColor] withFontSize:15 withBold:NO withTextAlignment:0];
//            lab.numberOfLines = 0;
//            [lab sizeToFit];
//            labHeight = CGRectGetHeight(lab.frame)+10;
//        }
        
        commont_height += labHeight;
    }
    return commont_height;
}

@end
