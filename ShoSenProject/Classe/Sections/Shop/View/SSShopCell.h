//
//  SSShopCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSShopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSShopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *subtitle_label;

- (void)initCellWithModel:(SSGoodsListModel *)model section:(NSInteger )section;

@end

NS_ASSUME_NONNULL_END
