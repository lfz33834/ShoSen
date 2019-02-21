//
//  SSPrizeHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LuckyDrawView.h"
#import "LYLuckyCardRotationView.h"

typedef NS_ENUM(NSInteger,SSPrizeHeaderViewType )
{
    SSPrizeHeaderViewTypeRewardList,
    SSPrizeHeaderViewTypeDianjiNull,
};

typedef void(^SSPrizeHeaderViewBlock)(SSPrizeHeaderViewType type);

@interface SSPrizeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIView *circle_view;
@property (weak, nonatomic) IBOutlet LYLuckyCardRotationView *circleview;
@property (weak, nonatomic) IBOutlet UIButton *lookPrize_button;
@property (nonatomic, copy) SSPrizeHeaderViewBlock block;
@property (nonatomic, strong) LuckyDrawView *luk;

- (void)initCircelViewWithArray:(NSMutableArray *)dataArray;

@end
