//
//  BottomView.h
//  ShopCarDemo
//
//  Created by 周智勇 on 16/7/25.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomModel.h"

typedef NS_ENUM(NSInteger, BottomViewType)
{
    BottomViewTypeDelete,
    BottomViewTypePay,
    BottomViewTypeNormal,
};

@protocol BottomViewDelegate <NSObject>

- (void)clickedBottomSelecteAll;

- (void)clickedBottomJieSuanWithType:(BottomViewType)type model:(BottomModel *)model;

@end
@interface BottomView : UIView

@property (nonatomic, weak)id<BottomViewDelegate>delegate;

@property (nonatomic, strong)BottomModel * model;

@end
