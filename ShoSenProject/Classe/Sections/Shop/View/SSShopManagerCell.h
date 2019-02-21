//
//  SSShopManagerCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLocationModel.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^SSShopManagerCellBlock)(void);

@interface SSShopManagerCell : UITableViewCell

@property (nonatomic, strong) SSLocationModel *model;
@property (weak, nonatomic) IBOutlet UILabel *info_label;
@property (weak, nonatomic) IBOutlet UILabel *default_label;
@property (weak, nonatomic) IBOutlet UILabel *location_label;
@property (weak, nonatomic) IBOutlet UIButton *edit_button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading_layout;
@property (nonatomic, copy) SSShopManagerCellBlock block;

- (void)initCellWithModel:(SSLocationModel *)model;

@end

NS_ASSUME_NONNULL_END
