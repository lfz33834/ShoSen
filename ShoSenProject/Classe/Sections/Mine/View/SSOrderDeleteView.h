//
//  SSOrderDeleteView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/18.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SSOrderDeleteViewBlock)(void);

@interface SSOrderDeleteView : UIView

@property (nonatomic, copy) SSOrderDeleteViewBlock block;
- (void)showDeleteView;

@end
