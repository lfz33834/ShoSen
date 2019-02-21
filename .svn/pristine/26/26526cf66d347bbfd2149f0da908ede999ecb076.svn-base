//
//  SSConfirmOrderDetailVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSConfirmOrderDetailVC.h"
#import "SSPaySuccessVC.h"

@interface SSConfirmOrderDetailVC ()

@end

@implementation SSConfirmOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"确认预订"];
    self.pay_button.layer.cornerRadius = 5;
    self.name_label.text = self.model.bookUserName;
    self.phone_label.text = self.model.bookUserPhone;
    self.location_label.text = [NSString stringWithFormat:@"%@-%@",self.model.province,self.model.city];
}
- (IBAction)payButtonTapAction:(UIButton *)sender {
    SSPaySuccessVC *successVC = [[SSPaySuccessVC alloc]init];
    [self.navigationController pushViewController:successVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
