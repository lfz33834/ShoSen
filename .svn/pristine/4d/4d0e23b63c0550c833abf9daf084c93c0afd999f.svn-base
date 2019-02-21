//
//  SSCircleShareBlackListView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/31.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSCireViewTapType)
{
    SSCireViewTapTypeWechatShare,
    SSCireViewTapTypePengyouCircleShare,
    SSCireViewTapTypeJubao,
    SSCireViewTapTypeLahei,
};

typedef NS_ENUM(NSInteger, SSCircleShareBlackListType) {
    SSCircleShareBlackListTypeShare,
    SSCircleShareBlackListTypeBlackList,
};

typedef void(^SSCircleShareBlackListViewBlock)(SSCireViewTapType type);

@interface SSCircleShareBlackListView : UIView
@property (weak, nonatomic) IBOutlet UIButton *one_button;
@property (weak, nonatomic) IBOutlet UIButton *two_button;
@property (assign, nonatomic) SSCircleShareBlackListType type;
@property (nonatomic, copy) SSCircleShareBlackListViewBlock block;
- (void)initViewWithType:(SSCircleShareBlackListType )type;
- (void)showView;
+(SSCircleShareBlackListView *)share;

@end
