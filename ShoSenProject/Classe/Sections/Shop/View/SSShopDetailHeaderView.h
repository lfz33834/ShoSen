//
//  SSShopDetailHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSShopDetailModel.h"
#import "SDCycleScrollView.h"

typedef NS_ENUM(NSInteger, SSShopDetailHeaderViewType)
{
    SSShopDetailHeaderViewTypeJiFen,
    SSShopDetailHeaderViewTypeMoney,
};

NS_ASSUME_NONNULL_BEGIN

@interface SSShopDetailHeaderView : UIView

@property (nonatomic, strong) SSGoodSInfoModel *detailModel;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *subtitle_label;
@property (weak, nonatomic) IBOutlet UIImageView *footer_imageview;
@property (weak, nonatomic) IBOutlet UIWebView *webview_info;
@property (weak, nonatomic) IBOutlet UIView *scrollview;

@property (nonatomic, strong) SDCycleScrollView *scroll_View;


- (void)initCellWithModel:(SSGoodSInfoModel *)detailModel viewType:(SSShopDetailHeaderViewType )viewType;

@end

NS_ASSUME_NONNULL_END
