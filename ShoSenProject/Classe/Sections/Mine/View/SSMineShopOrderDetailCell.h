//
//  SSMineShopOrderDetailCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSShopOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SSMineShopOrderDetailCellType)
{
   SSMineShopOrderDetailCellTypeYue,
    SSMineShopOrderDetailCellTypeJiFen,
};

@interface SSMineShopOrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *num_label;
@property (weak, nonatomic) IBOutlet UILabel *number_label;

- (void)initCellWithModel:(SSShopOrderGoodsListModel *)goodsModel cellType:(SSMineShopOrderDetailCellType)type;

@end

NS_ASSUME_NONNULL_END
