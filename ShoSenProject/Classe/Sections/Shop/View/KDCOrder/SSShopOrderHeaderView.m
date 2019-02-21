//
//  SSShopOrderHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderHeaderView.h"

@implementation SSShopOrderHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.info_label.hidden = YES;
    self.location_label.hidden = YES;
    self.default_label.hidden = YES;
    self.location_view.hidden = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGesture addTarget:self action:@selector(skipLocationListTapAction)];
    [self addGestureRecognizer:tapGesture];
}

- (void)setLocationModel:(SSLocationModel *)locationModel
{
    if (locationModel) {
        if (locationModel.isDefault) {
            _default_label_width_layout.constant = 32;
            _location_label_leading.constant = 15;
        }else{
            _default_label_width_layout.constant = 0;
            _location_label_leading.constant = 0;
        }
        
        _location_view.hidden = YES;
        _info_label.hidden = NO;
        _location_label.hidden = NO;
        _default_label.hidden = NO;
        _info_label.text = [NSString stringWithFormat:@"%@ %@",locationModel.name,locationModel.mobile];
        _location_label.text = [NSString stringWithFormat:@"%@ %@ %@ %@",locationModel.province,locationModel.city,locationModel.area,locationModel.address];
    }
}

- (void)skipLocationListTapAction
{
    self.block();
}
@end
