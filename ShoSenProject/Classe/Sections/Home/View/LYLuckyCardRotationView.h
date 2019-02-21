//
//  LYLuckyCardRotationView.h
//  LYLuckyCardDemo
//
//  Created by leo on 17/2/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSPrizeModel.h"

typedef void(^LYLuckyCardRotationViewBlock)(NSDictionary *data);

@interface LYLuckyCardRotationView : UIView

@property (nonatomic, copy) LYLuckyCardRotationViewBlock block;

- (void)initCellWichModel:(NSMutableArray *)prizeArray;

- (void)beignRotaion;

@end
