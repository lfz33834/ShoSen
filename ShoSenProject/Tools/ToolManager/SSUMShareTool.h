//
//  SSUMShareTool.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSUMShareTool : NSObject
+(instancetype)share;
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
-(void)UMShare;
- (void)getAuthWithUserInfoFromWechat:(UIViewController *)shareVC callBack:(void(^)(NSDictionary *dicData))block;
@end
