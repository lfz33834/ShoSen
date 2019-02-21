//
//  SSPSQItemCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/15.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSHomeModel.h"

@interface SSPSQItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *left_imageview;
@property (weak, nonatomic) IBOutlet UILabel *item_label;

@property (nonatomic, strong) SSHomeModel *model;
- (void)initCellWithModel:(SSHomeModel *)model;

@end
