//
//  ShowMes.m
//  Smile
//
//  Created by wei on 2017/6/27.
//  Copyright © 2017年 wei. All rights reserved.
//

#import "ShowMes.h"
#import "Activity.h"
#define showMesTags 9998

@implementation ShowMes

+ (void)show:(NSString*)mes;{
    [Activity stop];
    UIWindow*window = [[UIApplication sharedApplication].delegate window];
    
    ShowMesView*mesview = [window viewWithTag:showMesTags*2];
    
    NSArray*mesList = [mes componentsSeparatedByString:@"\n"];
    float width = [UILabel width:mes font:FontS(17) h:15];
    float hight =[UILabel hight:mes font:FontS(17) w:221];
    if(mesList.count>0){
        float theBiger = 0;
        for(int i=0;i<mesList.count;i++){
            NSString*x = mesList[i];
            float w1 = [UILabel width:x font:FontS(17) h:15];
            if(w1>theBiger){
                theBiger = w1;
            }
        }
        if(theBiger>221) width = 221;
        else width = theBiger;
    }else{
        if(width>221) width = 221;
    }
    width = width + 60;
    hight = hight + 60;
    
    if(!mesview){
        mesview = [[ShowMesView alloc] init];
        [mesview settext:mes];
        mesview.tag =showMesTags*2;
        [mesview setFrame:rect(window.frame.size.width/2-width/2, window.frame.size.height/2-hight/2, width, hight)];
        [window addSubview:mesview];
    }else{
        [mesview settext:mes];
        mesview.hidden = NO;
        [mesview setFrame:rect(window.frame.size.width/2-width/2, window.frame.size.height/2-hight/2, width, hight)];
    }
    [mesview bringSubviewToFront:window];
    //1s消失
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [ShowMes stop];
    });
    
}
/*
+ (void)show:(NSString*)mes inController:(id)vc;{
    if(vc){
        [ShowMes show:mes];
    }
}
 */
+ (void)stop;{
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    ShowMesView*mesview = [window viewWithTag:showMesTags*2];
    if(mesview){
        mesview.hidden = YES;
        [mesview settext:@""];
    }
}

@end

@implementation ShowMesView
- (instancetype)init{
    self = [super init];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = kColor(@"000000");
    self.alpha = 0.7;
    
    self.label = [[UILabel alloc] init];
    self.label.font = FontS(17);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    self.label.numberOfLines = 0;
    [self addSubview:self.label];
    self.label.sd_layout.leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}
- (void)settext:(NSString*)text;{
    self.label.text = text;
}
@end
