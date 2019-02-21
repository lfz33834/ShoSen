//
//  SSCarConfigureVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCarConfigureVC.h"
#import "SSOrderFooterView.h"
#import "SSConfirmBookVC.h"
#import "SSPSQLookInVC.h"

@interface SSCarConfigureVC ()

@property(nonatomic, strong) SSOrderFooterView *orderView;

@end

@implementation SSCarConfigureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"汽车商务智慧社区"];
    
    //1. 建立UIScrollView窗口，我们只打算用手机的上半屏显示图像，(这一步也可以在storyboard里完成)
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kwidth , kheight - 50)];
    //2.建立内容视图
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_book_bg"]];
    bg.frame = CGRectMake(0, 0, kwidth, 1641);    //3.将内容视图作为scrollView的子视图
    [scrollview addSubview: bg];
    //4.当然了，还得把scrollView添加到视图结构中
    [self.view addSubview: scrollview];
    scrollview.contentSize = bg.bounds.size;
    [self.view addSubview:self.orderView];

}

- (void)viewWillLayoutSubviews
{
    _orderView.frame = CGRectMake(0, kheight-kTopHeight-55, kwidth, 55);
}

- (SSOrderFooterView *)orderView
{
    if (_orderView == nil) {
        WEAKSELF
        _orderView = [[NSBundle mainBundle]loadNibNamed:@"SSOrderFooterView" owner:self options:nil].lastObject;
        [_orderView initWithViewWithType:OrderFooterViewTypeBook operateType:0];
        _orderView.block = ^(OrderFooterOperateType type) {
            SSAccount *accout = [SSAccountTool share].account;
            if(accout)
            {
                SSPSQLookInVC *bookVC = [[SSPSQLookInVC alloc]init];
                [weakSelf.navigationController pushViewController:bookVC animated:YES];
            }else{
                SSLoginVC *loginVC = [[SSLoginVC alloc]init];
                [weakSelf.navigationController pushViewController:loginVC animated:YES];
            }
        };
    }
    return _orderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
