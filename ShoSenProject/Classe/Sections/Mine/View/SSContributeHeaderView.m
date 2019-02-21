//
//  SSContributeHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSContributeHeaderView.h"

@implementation SSContributeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    SSAccount *account = [SSAccountTool share].account;
    self.header_imageview.layer.cornerRadius = 13;
    self.header_imageview.clipsToBounds = YES;
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:account.headimg] placeholderImage:[UIImage imageNamed:@"mine_header_normal"]];
    self.leading_layout.constant = 24+([account.level intValue] - 1)*44*(kwidth/375);
    self.top_layout.constant = 170 - 21*([account.level intValue] - 1);
    self.contributecontent_label.text = [NSString stringWithFormat:@"当前贡献值  %@",account.contribution];
    self.detail_button.layer.cornerRadius = self.detail_button.height*0.5;
    self.detail_button.layer.borderWidth = 1;
    self.detail_button.layer.borderColor = [UIColor whiteColor].CGColor;
    self.content_label.text = @"1、什么是贡献值？\n贡献值是X商务社区用户通过某些行为获得的奖励，贡献值的累计总额决定会员等级。\n 2、贡献值的用途？ \n贡献值到达相应的等级即可享受该等级对应的权益，贡献值越高，获得的权益越丰厚。 更多会员权益正在筹备中，敬请期待！";
    self.header_bg_view.layer.cornerRadius = 60;
}

- (IBAction)detailButtonTapAction:(UIButton *)sender {
    self.block();
}

@end
