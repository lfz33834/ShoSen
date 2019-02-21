//
//  SSShopOrderPayView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/13.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderPayView.h"

@interface SSShopOrderPayView()

@property (nonatomic, assign) int selectIndex;

@end

@implementation SSShopOrderPayView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectIndex = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGesture addTarget:self action:@selector(tapGestureAction)];
    [self.yue_select_view addGestureRecognizer:tapGesture];
}

- (void)tapGestureAction
{
    SSAccount *account = [SSAccountTool share].account;
    if (self.selectIndex == 0) {
        self.selectIndex = 1;
        self.yue_imageview.image = [UIImage imageNamed:@"shoppingCar_select"];
        if (self.block) {
            self.block(YES,account.money);
        }
    }else{
        self.selectIndex = 0;
        self.yue_imageview.image = [UIImage imageNamed:@"shoppingCar_unselect"];
        if (self.block) {
            self.block(NO,account.money);
        }
    }
}



- (void)initViewWithTyp:(SSShopOrderPayViewType )type moddel:(BottomModel *)model
{
    self.model = model;
    if(type == SSShopOrderPayViewTypeYuE)
    {
         self.yue_view.hidden = NO;
        self.yue_height_layou.constant = 45;
        self.jifen_view.hidden = YES;
        SSAccount *account = [SSAccountTool share].account;

        if ([account.money intValue] == 0) {
            self.yue_title_label.textColor = kColor(@"999999");
            self.yue_num_label.textColor = kColor(@"999999");
            self.yue_use_label.textColor = kColor(@"999999");
            self.yue_use_label.text = @"无可用";
            self.yue_imageview.hidden = YES;
            self.yue_trailing_layout.constant = 15;
            self.yue_num_label.text = @"￥ 0.00";
        }else{
            self.yue_title_label.textColor = kColor(@"333333");
            self.yue_num_label.textColor = kColor(@"333333");
            _yue_num_label.text = [NSString stringWithFormat:@"￥%@",account.money];
            self.yue_use_label.textColor = kColor(@"333333");
            self.yue_imageview.hidden = NO;
            self.yue_trailing_layout.constant = 30;
            
        
            if ( model.totalMoney < [account.money intValue]) {
                _yue_use_label.text = [NSString stringWithFormat:@"使用￥%.2f",model.totalMoney];
            }else{
                _yue_use_label.text = [NSString stringWithFormat:@"使用￥%.2f",[account.money floatValue]];
            }
        }
        _money_label.text = [NSString stringWithFormat:@"￥%.2f",model.totalMoney];
        _jifenTotal_label.text = [NSString stringWithFormat:@"￥%.2f",model.totalMoney];
        
    }else if (type == SSShopOrderPayViewTypeJiFen){
        self.yue_view.hidden = YES;
        self.yue_height_layou.constant = 0;
        self.jifen_view.hidden = NO;
        
        _money_label.text = [NSString stringWithFormat:@"%.2f积分",model.totalMoney];
        _jifenTotal_label.text = [NSString stringWithFormat:@"%.2f积分",model.totalMoney];
    }    
}

@end
