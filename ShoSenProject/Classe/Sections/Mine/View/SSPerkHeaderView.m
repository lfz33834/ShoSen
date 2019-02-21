//
//  SSPerkHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPerkHeaderView.h"

@implementation SSPerkHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.withdraw_button.layer.cornerRadius = 5;
    self.withdraw_button.layer.borderColor = [UIColor colorWithHexColorString:@"D6B35B" alpha:0.5].CGColor;
    self.withdraw_button.layer.borderWidth = 1;
    SSAccount *account = [SSAccountTool share].account;
    self.money_label.text = [NSString stringWithFormat:@"￥%@",account.rewardMoney];
}

- (IBAction)withdrawButtonTapAction:(UIButton *)sender {
 
    self.block(SSPerkHeaderTypeWithDraw);
}

- (IBAction)perkDetailButtonTapAction:(UIButton *)sender {
    self.block(SSPerkHeaderTypeInfo);

}

@end
