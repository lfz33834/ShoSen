//
//  SSCircleMineHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleMineHeaderView.h"

@implementation SSCircleMineHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.headerbg_view.layer.cornerRadius = 5;
    self.headerbg_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.headerbg_view.userInteractionEnabled=YES;
    self.headerbg_view.layer.shadowOpacity=0.15;
    [self.headerbg_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kwidth- 30, 100)] CGPath]];
    self.headerbg_view.layer.shadowRadius = 5.0;//半径
    self.headerbg_view.layer.shadowOffset = CGSizeMake(5, 5);

    SSAccount *account = [SSAccountTool share].account;
    self.header_imageview.layer.cornerRadius = self.header_imageview.width*0.5;
    self.header_imageview.clipsToBounds = YES;
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:account.headimg] placeholderImage:[UIImage imageNamed:@"circle_placeholder_3"]];
    self.title_label.text = account.name;
    
    UITapGestureRecognizer *messageGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self.message_view addGestureRecognizer:messageGesture];
    
    UITapGestureRecognizer *xiaoxiGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xiaoxiTapClick)];
    [self.sixin_view addGestureRecognizer:xiaoxiGesture];
}

- (void)centerTapClick
{
    if (self.block) {
        self.block(SSCircleMineHeaderViewTypeMessage);
    }
}

- (void)xiaoxiTapClick
{
    if (self.block) {
        self.block(SSCircleMineHeaderViewTypePrivateMessage);
    }
}

- (IBAction)huatiButtonTapAction:(UIButton *)sender {
    if (self.block) {
        self.block(SSCircleMineHeaderViewTypeHuati);
    }
}
- (IBAction)guanzhuButtonTapAction:(UIButton *)sender {
    if (self.block) {
        self.block(SSCircleMineHeaderViewTypeGuanzhu);
    }
}
- (IBAction)fensiButtonTapAction:(UIButton *)sender {
    
    if (self.block) {
        self.block(SSCircleMineHeaderViewTypeFensi);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
