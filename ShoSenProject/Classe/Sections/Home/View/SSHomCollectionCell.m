//
//  SSHomCollectionCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/13.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSHomCollectionCell.h"

@implementation SSHomCollectionCell

- (void)setHomeModel:(SSHomeModel *)homeModel
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [_imageview sd_setImageWithURL:[NSURL URLWithString:homeModel.imageName] placeholderImage:nil];
    _title_label.text = homeModel.titleStr;
}

@end
