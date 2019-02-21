//
//  ShopCarTableViewCell.m
//  ShopCarDemo
//
//  Created by 周智勇 on 16/7/25.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "ShopCarTableViewCell.h"
#import "CountView.h"

@interface ShopCarTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
  @property (weak, nonatomic) IBOutlet CountView *countview;

@end
@implementation ShopCarTableViewCell

- (void)awakeFromNib {
    
    self.countview.layer.cornerRadius = 5;
    self.countview.layer.borderColor = kColor(@"CCAC5D").CGColor;
    self.countview.layer.borderWidth = 1;
    
    self.left_imageview.layer.cornerRadius = 5;
    
    __weak typeof(self)MySelf = self;
    self.countview.CountBlock = ^(NSInteger num){
        if (MySelf.delegate && [self.delegate respondsToSelector:@selector(changeTheShopCount:count:)]) {
            [MySelf.delegate changeTheShopCount:MySelf count:num];
        }
    };
}

-(void)setModel:(ShopModel *)model{
    _model = model;
    _title_label.text = _model.shopTitle;
    _num_label.text = [NSString stringWithFormat:@"￥%.2f", _model.singlePrice];
    _countview.count =  _model.count;
    if (_model.selected) {
        [_leftBtn setImage:[UIImage imageNamed:@"shoppingCar_select"] forState:UIControlStateNormal];
    }else{
        [_leftBtn setImage:[UIImage imageNamed:@"shoppingCar_unselect"] forState:UIControlStateNormal];
    }
    [_left_imageview sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
}

- (IBAction)leftBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedWichLeftBtn:)]) {
        [self.delegate clickedWichLeftBtn:self];
    }
}
@end
