//
//  SSHomeCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSNewsModel.h"

@interface SSHomeCell : UITableViewCell

@property (nonatomic, strong) SSNewsModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UIButton *look_button;

@end
