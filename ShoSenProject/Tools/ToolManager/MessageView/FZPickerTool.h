//
//  FZPickerTool.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/28.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerDidSelectBlock)(NSIndexPath *indexPath);


@interface FZPickerTool : UIPickerView

+ (void)show:(NSArray<NSArray<NSString *> *> *)datas didSelectBlock:(PickerDidSelectBlock)didSelectBlock;

@end
