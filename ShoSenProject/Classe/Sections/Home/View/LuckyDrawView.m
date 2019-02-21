//
//  LuckyDrawView.m
//  大转盘
//
//  Created by 谭启宏 on 16/3/2.
//  Copyright © 2016年 tqh. All rights reserved.
//

#import "LuckyDrawView.h"
#import "SSHomeViewModel.h"

//抽奖大转盘UI分为3部分:中心按钮点击，转盘，转盘内容
//需要可以自定义转盘内容的数量,内容，
//指针

//
@interface LuckyDrawView ()<UIAlertViewDelegate>

@property (nonatomic,strong)UIButton *playButton;   //抽奖按钮
@property (nonatomic,strong)UIImageView *rotateWheel; //转盘背景
@property (nonatomic,strong)CADisplayLink *link;
//@property (nonatomic,assign)NSInteger number;
@property (nonatomic,strong) SSHomeViewModel *viewModel;

@end

@implementation LuckyDrawView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commit];
        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}

- (void)initCellWichModel:(NSMutableArray *)prizeArray;
{
    
    for (int i = 0; i < prizeArray.count; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(self.bounds)/6,
                                                                  CGRectGetHeight(self.bounds)/2)];
        label.layer.anchorPoint = CGPointMake(0.5, 1);
        label.center = CGPointMake(CGRectGetHeight(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        SSPrizeModel *model = prizeArray[i];
        label.text = [NSString stringWithFormat:@"%@",model.dicValue];
        CGFloat angle = M_PI * 2 / 6 * i;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = kColor(@"DA4142");
        label.transform = CGAffineTransformMakeRotation(angle);
        [self.rotateWheel addSubview:label];
    }
    [self addSubview:self.playButton];
    [self startRotate];
}

- (void)commit {
    self.rotateWheel = [[UIImageView alloc]initWithFrame:self.bounds];
    self.rotateWheel.image = [UIImage imageNamed:@"home_prize_circle"];
    self.playButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.frame = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(self.bounds)/3,
                                       CGRectGetHeight(self.bounds)/3);

    self.playButton.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetWidth(self.bounds)/2);
    [self.playButton setImage:[UIImage imageNamed:@"home_prize_dianji"] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(playButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rotateWheel];
}

#pragma mark - 事件监听

- (void)playButtonPressed {
    //度数*返回来的数
    //M_PI*2/12*（13-12) 12
    //M_PI*2/12*2 11
    //M_PI*2/12*3 10
    //M_PI*2/12*4 9
    [self.viewModel feltPrizeWithPhoneCallBack:^(id json) {
        if ([json[@"data"][@"data"] intValue] == -1) {
//            self.numberIndex = 1;
            if (self.block) {
                self.block(json[@"data"]);
            }
            return ;
        }else{
            self.numberIndex = [json[@"data"][@"data"] intValue];
        }
    if (![self.rotateWheel.layer animationForKey:@"zhuandong"]) {
        CABasicAnimation* animation = [[CABasicAnimation alloc] init];
        animation.keyPath = @"transform.rotation";
        animation.toValue = @(2 * M_PI * 5 - M_PI*2/6*(6-self.numberIndex));
        animation.duration = 5;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [self.rotateWheel.layer addAnimation:animation forKey:@"zhuandong"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.rotateWheel.transform = CGAffineTransformMakeRotation(M_PI*2/6*(6-self.numberIndex));
            self.link.paused = YES;
            [self.rotateWheel.layer removeAnimationForKey:@"zhuandong"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.block) {
                    self.block(json[@"data"]);
                }
            });
        });
    }
    }];
}

- (void)repetWithAnimation:(BOOL)isYes {
    [UIView animateWithDuration:1 animations:^{
        
        self.rotateWheel.transform = CGAffineTransformMakeRotation(M_PI*2/6*(7-self.numberIndex));
        self.link.paused = YES;
    } completion:^(BOOL finished) {
        if (isYes) {
            [self repetWithAnimation:YES];
        }
        self.numberIndex = 6;
    }];
}

- (SSHomeViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSHomeViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark - UIAlertViewDelegate

// 开始转动(一直不停的转动)
- (void)startRotate
{
    CADisplayLink* link = [CADisplayLink displayLinkWithTarget:self selector:@selector(Rotate)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

- (void)Rotate
{
    //每次旋转6°
    self.rotateWheel.transform = CGAffineTransformRotate(self.rotateWheel.transform, M_PI * 2 / 6/ 60 );
}

@end
