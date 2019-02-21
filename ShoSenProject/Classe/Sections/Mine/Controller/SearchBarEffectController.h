//
//  SearchBarEffectController.h
//  微信搜索模糊效果
//
//  Created by MAC on 17/4/1.
//  Copyright © 2017年 MyanmaPlatform. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchReturnBlock)(NSString *returnString);

@interface SearchBarEffectController : UIView

@property(nonatomic , strong)NSArray * effectArray;
@property (nonatomic, copy) searchReturnBlock block;

- (void)hidden;
- (void)show;
@end
