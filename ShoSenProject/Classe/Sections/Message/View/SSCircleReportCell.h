//
//  SSCircleReportCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCircleListModel.h"

@interface SSCircleReportCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *left_imageview;
@property (weak, nonatomic) IBOutlet UILabel *content_label;

@property (nonatomic, strong) SSCircleListModel *model;

- (void)initCellWithModel:(SSCircleListModel *)model;

@end
