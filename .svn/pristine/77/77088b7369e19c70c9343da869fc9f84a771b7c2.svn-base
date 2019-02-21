//
//  Activity.m
//  Smile
//
//  Created by wei on 2017/4/13.
//  Copyright © 2017年 wei. All rights reserved.
//

#import "Activity.h"
#import <UIKit/UIKit.h>
#define activityTags 9999

@implementation Activity

+ (void)show;{
     [ShowMes stop];
    UIWindow*window = [[UIApplication sharedApplication].delegate window];
    UIView*backgroundView = [window viewWithTag:activityTags*2];
    
    UIView*mainView = [window viewWithTag:activityTags*2+1];
    if(!mainView){
        mainView = [[UIView alloc] initWithFrame:rect(0, kTopHeight, kwidth, kheight)];
        mainView.tag = activityTags*2+1;
        mainView.backgroundColor = [UIColor clearColor];
        [window addSubview:mainView];
    }else{
        mainView.hidden = NO;
    }
    
    if(!backgroundView){
        backgroundView = [[UIView alloc]initWithFrame:CGRectMake(kwidth/2-30, kheight/2-30, 60, 60)];
        backgroundView.layer.cornerRadius =5.0;
        backgroundView.layer.masksToBounds = YES;
        backgroundView.backgroundColor = kColor_gray;
        //backgroundView.backgroundColor = [UIColor clearColor];
        backgroundView.tag = activityTags*2;
        backgroundView.alpha = 0.8;
        [window addSubview:backgroundView];
        
        UIActivityIndicatorView*act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        act.tag = activityTags;
        act.center = CGPointMake(30, 30);
        [backgroundView addSubview:act];
        
    }else{
        backgroundView.hidden = NO;
    }
    
    [window bringSubviewToFront:backgroundView];
    
    UIActivityIndicatorView*act = [window viewWithTag:activityTags];
    if(act){
        [act startAnimating];
    }
}
+ (void)stop;{
     UIWindow * window = [[UIApplication sharedApplication].delegate window];
    UIActivityIndicatorView*act = [window viewWithTag:activityTags];
    if(act){
        [act stopAnimating];
    }
    UIView*backgroundView = [window viewWithTag:activityTags*2];
    if(backgroundView){
        backgroundView.hidden = YES;
    }
    UIView*mainView = [window viewWithTag:activityTags*2+1];
    if(mainView){
        mainView.hidden = YES;
    }
}


+ (void)showinview:(UIView*)view;{
    [ShowMes stop];
    UIView*window =view;
    UIView*backgroundView = [window viewWithTag:activityTags*2];
    UIView*mainView = [window viewWithTag:activityTags*2+1];
    if(!mainView){
        mainView = [[UIView alloc] initWithFrame:rect(0, 0, kwidth, kheight)];
        mainView.tag = activityTags*2+1;
        mainView.backgroundColor = [UIColor clearColor];
        [window addSubview:mainView];
    }else{
        mainView.hidden = NO;
    }
    
    if(!backgroundView){
        backgroundView = [[UIView alloc]initWithFrame:CGRectMake(kwidth/2-30, kheight/2-30, 60, 60)];
        backgroundView.layer.cornerRadius =5.0;
        backgroundView.layer.masksToBounds = YES;
        backgroundView.backgroundColor = kColor_gray;
        //backgroundView.backgroundColor = [UIColor clearColor];
        backgroundView.tag = activityTags*2;
        backgroundView.alpha = 0.8;
        [window addSubview:backgroundView];
        
        UIActivityIndicatorView*act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        act.tag = activityTags;
        act.center = CGPointMake(30, 30);
        [backgroundView addSubview:act];
        
    }else{
        backgroundView.hidden = NO;
    }
    UIActivityIndicatorView*act = [window viewWithTag:activityTags];
    if(act){
        [act startAnimating];
    }
}
+ (void)stopinview:(UIView*)view;{
    UIView * window = view;
    UIActivityIndicatorView*act = [window viewWithTag:activityTags];
    if(act){
        [act stopAnimating];
    }
    UIView*backgroundView = [window viewWithTag:activityTags*2];
    if(backgroundView){
        backgroundView.hidden = YES;
    }
    UIView*mainView = [window viewWithTag:activityTags*2+1];
    if(mainView){
        mainView.hidden = YES;
    }
}


@end


