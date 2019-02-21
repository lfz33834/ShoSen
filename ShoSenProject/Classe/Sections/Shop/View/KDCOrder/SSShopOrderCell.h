//
//  SSShopOrderCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"

typedef NS_ENUM(NSInteger,SSShopOrderCellType)
{
    SSShopOrderCellTypeYue,
    SSShopOrderCellTypeJiFen,
};

NS_ASSUME_NONNULL_BEGIN

@interface SSShopOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *money_label;
@property (weak, nonatomic) IBOutlet UILabel *num_label;

- (void)initCellWithModel:(ShopModel *)model cellType:(SSShopOrderCellType)type;

@end

NS_ASSUME_NONNULL_END
