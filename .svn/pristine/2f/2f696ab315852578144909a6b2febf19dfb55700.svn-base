//
//  UITableViewCell+Extend.m
//  Carpenter
//
//  Created by 冯成林 on 15/4/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "UITableViewCell+Extension.h"
#import "UIView+Extension.h"

@implementation UITableViewCell (Extension)


/**
 *  创建cell
 *
 *  @param tableView 所属tableView
 *
 *  @return cell实例
 */
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *rid = @"cellID";
    
    //从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    
    //缓存池中无数据
    if(cell == nil){
        
        cell = [self viewFromXIB];
    }
    
    return cell;
}

//删除分割线
- (void)removeSeparatorViewInView:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")]) {
            [subView removeFromSuperview];
        }else if(subView.subviews.count>0){
            [self removeSeparatorViewInView:subView];
        }
    }
}
@end
