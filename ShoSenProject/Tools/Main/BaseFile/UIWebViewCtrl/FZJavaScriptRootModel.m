
//
//  FZJavaScriptRootModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZJavaScriptRootModel.h"

@implementation FZJavaScriptRootModel
- (void)getCommonParams
{
    
}
- (void)showMessage:(NSString *)paramStr
{
    NSLog(@"currentThread  = %@",[NSThread currentThread]);
    NSLog(@"paramStr = %@",paramStr);
}
@end
