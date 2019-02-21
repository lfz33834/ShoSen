//
//  LuckyDrawView.h
//  大转盘
//
//  Created by 谭启宏 on 16/3/2.
//  Copyright © 2016年 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPrizeModel.h"

typedef void(^LuckyDrawViewBlock)(NSDictionary *data);

@protocol LuckyDrawView <NSObject>

- (void)LuckyDrawViewDidFinishWidthIndex:(NSInteger)index;

@end

//抽奖用的大转盘
@interface LuckyDrawView : UIView

@property (nonatomic,assign)NSInteger numberIndex;
@property (nonatomic,assign)id<LuckyDrawView>delegate;
@property (nonatomic, copy) LuckyDrawViewBlock block;

- (void)initCellWichModel:(NSMutableArray *)prizeArray;

- (void)playButtonPressed ;


@end
