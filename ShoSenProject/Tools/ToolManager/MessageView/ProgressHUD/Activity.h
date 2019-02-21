//
//  Activity.h
//  Smile
//
//  Created by wei on 2017/4/13.
//  Copyright © 2017年 wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

+ (void)show;
+ (void)stop;

+ (void)showinview:(UIView*)view;
+ (void)stopinview:(UIView*)view;

@end
