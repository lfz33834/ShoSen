//
//  SSHomeHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

typedef NS_ENUM(NSInteger,SSHomeHeaderViewType) {
    SSHomeHeaderViewTypeBook,
    SSHomeHeaderViewTypeActive,
    SSHomeHeaderViewTypeSignin,
    SSHomeHeaderViewTypeSigninFailure,
    SSHomeHeaderViewTypePrize,
    SSHomeHeaderViewTypeMall,
    SSHomeHeaderViewTypeMore,
};

typedef void(^SSHomeHeaderViewBlock)(SSHomeHeaderViewType type);

@interface SSHomeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *scrollview_image;
@property (weak, nonatomic) IBOutlet UICollectionView *collection_view;
@property (weak, nonatomic) IBOutlet UIButton *book_button;
@property (nonatomic, strong) SDCycleScrollView *scrollView;

@property (nonatomic, copy) SSHomeHeaderViewBlock block;

@end
