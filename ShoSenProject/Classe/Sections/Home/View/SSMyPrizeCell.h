//
//  SSMyPrizeCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPrizeModel.h"

@interface SSMyPrizeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UIImageView *left_imageview;
@property (weak, nonatomic) IBOutlet UILabel *subTiltle_label;
@property (weak, nonatomic) IBOutlet UILabel *subContent_label;
@property (weak, nonatomic) IBOutlet UIView *bg_view;

- (void)initCellWithModel:(SSPrizeModel *)model;

@end
