//
//  SSRechargeVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/24.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSRechargeVC.h"
#import "SSMyPurseViewModel.h"
#import "SSPayOrderVC.h"

@interface SSRechargeVC ()

@property (nonatomic, strong) SSMyPurseViewModel *viewModel;
@property (nonatomic, copy) NSString *rechargeMoney;

@end

@implementation SSRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.one_button.layer.cornerRadius = 5;
    self.one_button.layer.borderWidth = 1;
    self.one_button.layer.borderColor = kColor(@"D6B35B").CGColor;

    self.two_button.layer.cornerRadius = 5;
    self.two_button.layer.borderWidth = 1;
    self.two_button.layer.borderColor = kColor(@"D6B35B").CGColor;
    
    self.three_butotn.layer.cornerRadius = 5;
    self.three_butotn.layer.borderWidth = 1;
    self.three_butotn.layer.borderColor = kColor(@"D6B35B").CGColor;
    
    self.foure_button.layer.cornerRadius = 5;
    self.foure_button.layer.borderWidth = 1;
    self.foure_button.layer.borderColor = kColor(@"D6B35B").CGColor;
    
    self.charge_button.layer.cornerRadius = 5;
    self.charge_button.clipsToBounds = YES;
    self.rechargeMoney = @"0";
//    self.money_textfield.text = self.rechargeMoney;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"充值";
    [self setNavBlack];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newbacks)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];
}

- (void)newbacks
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chargeButtonTapAction:(UIButton *)sender {
    
    NSString *money_str;
    if (self.money_textfield.text.length > 0) {
        money_str = self.money_textfield.text;
    }else{
        money_str = self.rechargeMoney;
    }
    [self.viewModel chargeMoneyWithMoney:money_str callback:^(id  _Nonnull object) {
        NSString *orderNo = object[@"data"][@"chargeNo"];
        SSPayOrderVC *bookVC = [[SSPayOrderVC alloc]init];
        bookVC.bookID = orderNo;
        bookVC.money_str = money_str;
        bookVC.viewType = SSPayOrderVCTypeRecharge;
        [self.navigationController pushViewController:bookVC animated:YES];
    }];
}

- (IBAction)moneyButtonTapAction:(UIButton *)sender {
    for (id obj in self.charge_money_view.subviews)  {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btnPrice = (UIButton*)obj;
            if (sender ==  btnPrice) {
                btnPrice.layer.borderColor = kColor(@"D6B35B").CGColor;
                btnPrice.backgroundColor = kColor(@"D6B35B");
                [btnPrice setTitleColor:kColor(@"ffffff") forState:UIControlStateNormal];
                self.rechargeMoney = [NSString stringWithFormat:@"%ld",(long)sender.tag];
                self.money_textfield.text = self.rechargeMoney;
            }else{
                btnPrice.layer.borderColor = kColor(@"D6B35B").CGColor;
                btnPrice.backgroundColor = [UIColor whiteColor];
                [btnPrice setTitleColor:kColor(@"D6B35B") forState:UIControlStateNormal];
                btnPrice.layer.borderWidth = 1;
                btnPrice.layer.borderColor = kColor(@"D6B35B").CGColor;
            }
        }
    }
}


- (SSMyPurseViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSMyPurseViewModel alloc]init];
    }
    return _viewModel;
}

@end
