//
//  SSCircleMineHeaderView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSCircleMineHeaderViewType)
{
    SSCircleMineHeaderViewTypeMessage,
    SSCircleMineHeaderViewTypePrivateMessage,
    SSCircleMineHeaderViewTypeHuati,
    SSCircleMineHeaderViewTypeGuanzhu,
    SSCircleMineHeaderViewTypeFensi,
};

typedef void(^SSCircleMineHeaderViewBlock)(SSCircleMineHeaderViewType type);

@interface SSCircleMineHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *fensi_label;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *huati_label;
@property (weak, nonatomic) IBOutlet UIView *message_view;
@property (weak, nonatomic) IBOutlet UILabel *guanzhu_label;
@property (weak, nonatomic) IBOutlet UIView *sixin_view;
@property (weak, nonatomic) IBOutlet UIStackView *header_view;
@property (weak, nonatomic) IBOutlet UIView *headerbg_view;
@property (nonatomic, copy) SSCircleMineHeaderViewBlock block;

@end
