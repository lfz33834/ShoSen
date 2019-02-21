//
//  LYLuckyCardRotationView.m
//  LYLuckyCardDemo
//
//  Created by leo on 17/2/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "LYLuckyCardRotationView.h"
#import "Masonry.h"
#import "LYLuckyCardCellView.h"
#import "SSHomeViewModel.h"

#define kLuckyCardCellCount 6 //转盘小格子数
#define kLuckyCardCellViewSize CGSizeMake(100, 120) //每个小格子大小

@interface LYLuckyCardRotationView () <CAAnimationDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *canRotationView;
@property (nonatomic,strong) SSHomeViewModel *viewModel;
@property (nonatomic, assign) int numberIndex;

@property (nonatomic, strong) NSMutableArray *cellArray;

@end

@implementation LYLuckyCardRotationView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil];
    [self addSubview:_contentView];
    _canRotationView.layer.cornerRadius = (kwidth - 80)*0.5;
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)initCellWichModel:(NSMutableArray *)prizeArray;
{
    self.cellArray = [NSMutableArray arrayWithCapacity:kLuckyCardCellCount];
    CGFloat angle = 2 * M_PI / (CGFloat)kLuckyCardCellCount;
    for (int i = 0; i < prizeArray.count; i++) {
        CGRect cellFrame = CGRectZero;
        cellFrame.origin = CGPointMake(0, 0);
        cellFrame.size = kLuckyCardCellViewSize;
        LYLuckyCardCellView *cellView = [[LYLuckyCardCellView alloc] initWithFrame:cellFrame];
        SSPrizeModel *model = prizeArray[i];
        [cellView configCell:model.dicValue];
        cellView.layer.anchorPoint = CGPointMake(0.5, 1);
        cellView.layer.position = CGPointMake((kwidth - 80) / 2.0, (kwidth - 80) / 2.0);
        cellView.transform = CGAffineTransformMakeRotation(angle * i);
        [self.canRotationView addSubview:cellView];
        [self.cellArray addObject:cellView];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)beignRotaion {
    
    [self.viewModel feltPrizeWithPhoneCallBack:^(id json) {
        if ([json[@"data"][@"data"] intValue] == -1) {
            if (self.block) {
                self.block(json[@"data"]);
            }
            return ;
        }else{
            self.numberIndex = [json[@"data"][@"data"] intValue];
        }
        LYLuckyCardCellView *cellView = self.cellArray[self.numberIndex];
        CGFloat angle = atan2(cellView.transform.b, cellView.transform.a);
        self.canRotationView.transform = CGAffineTransformMakeRotation(-angle);
        [self animationPart1];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.block) {
                self.block(json[@"data"]);
            }
        });
    }];
}

- (void)animationPart1 {
    [self.canRotationView.layer removeAllAnimations];
    CABasicAnimation *animationPart1 = [CABasicAnimation animation];
    animationPart1.keyPath = @"transform.rotation";
    animationPart1.byValue = @(6 * 2 * M_PI);
    animationPart1.duration = 2;
    animationPart1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationPart1.fillMode = kCAFillModeForwards;
//    animationPart1.repeatCount = CGFLOAT_MAX;
    animationPart1.removedOnCompletion = NO;
    animationPart1.delegate = self;
    [self.canRotationView.layer addAnimation:animationPart1 forKey:@"animationPart1"];
}

- (void)animationPart2 {
    [self.canRotationView.layer removeAllAnimations];
    CABasicAnimation *animationPart2 = [CABasicAnimation animation];
    animationPart2.keyPath = @"transform.rotation";
    //    animationPart2.byValue = @(3 * 2 * M_PI);
    //    animationPart2.duration = 0.8;
    animationPart2.byValue = @(2 * 2 * M_PI);
    animationPart2.duration = 0.8;
    animationPart2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationPart2.fillMode = kCAFillModeForwards;
    animationPart2.removedOnCompletion = NO;
    animationPart2.delegate = self;
    [self.canRotationView.layer addAnimation:animationPart2 forKey:@"animationPart2"];
}

- (void)animationPart3 {
    [self.canRotationView.layer removeAllAnimations];
    CABasicAnimation *animationPart3 = [CABasicAnimation animation];
    animationPart3.keyPath = @"transform.rotation";
    //    animationPart3.byValue = @(1 * 2 * M_PI);
    //    animationPart3.duration = 0.25;
    animationPart3.byValue = @(1 / 2.0 * 2 * M_PI);
    animationPart3.duration = 0.125;
    animationPart3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationPart3.fillMode = kCAFillModeForwards;
    animationPart3.removedOnCompletion = NO;
    animationPart3.delegate = self;
    [self.canRotationView.layer addAnimation:animationPart3 forKey:@"animationPart3"];
}

- (void)animationPart4 {
    [self.canRotationView.layer removeAllAnimations];
    CABasicAnimation *animationPart4 = [CABasicAnimation animation];
    animationPart4.keyPath = @"transform.rotation";
    //    animationPart4.byValue = @(1 * 2 * M_PI);
    //    animationPart4.duration = 0.5;
    animationPart4.byValue = @(1 / 2.0 * 2 * M_PI);
    animationPart4.duration = 0.2;
    animationPart4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationPart4.fillMode = kCAFillModeForwards;
    animationPart4.removedOnCompletion = NO;
    animationPart4.delegate = self;
    [self.canRotationView.layer addAnimation:animationPart4 forKey:@"animationPart4"];
}

- (void)animationPart5 {
    [self.canRotationView.layer removeAllAnimations];
    CABasicAnimation *animationPart5 = [CABasicAnimation animation];
    animationPart5.keyPath = @"transform.rotation";
    //    animationPart5.byValue = @(1 * 2 * M_PI);
    //    animationPart5.duration = 1.3;
    animationPart5.byValue = @(1 * 2 * M_PI);
    animationPart5.duration = 0.6;
    animationPart5.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationPart5.fillMode = kCAFillModeForwards;
    animationPart5.removedOnCompletion = NO;
    animationPart5.delegate = self;
    [self.canRotationView.layer addAnimation:animationPart5 forKey:@"animationPart5"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAAnimation *animation1 = [self.canRotationView.layer animationForKey:@"animationPart1"];
    CAAnimation *animation2 = [self.canRotationView.layer animationForKey:@"animationPart2"];
    CAAnimation *animation3 = [self.canRotationView.layer animationForKey:@"animationPart3"];
    CAAnimation *animation4 = [self.canRotationView.layer animationForKey:@"animationPart4"];
    CAAnimation *animation5 = [self.canRotationView.layer animationForKey:@"animationPart5"];
    if (anim == animation1) {
        [self animationPart2];
    } else if (anim == animation2) {
        [self animationPart3];
    } else if (anim == animation3) {
        [self animationPart4];
    } else if (anim == animation4) {
        [self animationPart5];
    } else if (anim == animation5) {
        NSLog(@"转动结束");
    }
}
- (IBAction)circleButtonTapAction:(UIButton *)sender {

    [self beignRotaion];
}

- (SSHomeViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSHomeViewModel alloc]init];
    }
    return _viewModel;
}

@end
