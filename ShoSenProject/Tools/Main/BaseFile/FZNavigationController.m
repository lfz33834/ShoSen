//
//  FZNavigationController.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZNavigationController.h"

@interface FZNavigationController ()<UINavigationControllerDelegate>

@end

@implementation FZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

#pragma mark 设置导航栏的属性
//+ (void)initialize
//{
//    //1拿到设置主题的对象
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
//
//    //2设置导航栏的背景图片
//    if (!iOS7) {
//        //1设置navBar的背景图片,设置状态栏的样式
//         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        //2设置导航栏上面的barButtonItem的背景图片
//        [barButtonItem setBackgroundImage:[UIImage resizedImage:@"nav_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [barButtonItem setBackgroundImage:[UIImage resizedImage:@"nav_back"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//        [barButtonItem setBackgroundImage:[UIImage resizedImage:@"nav_back"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
//    }
//
//    if (iOS7) {
////        [navBar setBackgroundImage:[UIImage createImageWithColor:QSCTextColor] forBarMetrics:UIBarMetricsDefault];
//        [navBar setBarTintColor: RGB(248, 248, 248)];
//        [navBar setTintColor:RGB(248, 248, 248)];
//    }
//    //3设置导航栏标题颜色
//    [navBar setTitleTextAttributes:@{
//
//                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:17],
//                                     NSForegroundColorAttributeName : [UIColor whiteColor],
//                                     NSShadowAttributeName: [NSValue valueWithUIOffset:UIOffsetZero]
//                                     }];
//}

//判断是否为根控制器展示元素
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏nav条
    if ( viewController == self) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    }
    else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
    
    //判断将要显示的是否为根控制器
    if (viewController != navigationController.viewControllers[0] && viewController.navigationItem.leftBarButtonItem == nil) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) icon:@"home_left_arrow" highlightedIcon:@"home_left_arrow"];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
 
//    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:QSCTextColor] forBarMetrics:UIBarMetricsDefault];
     if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) icon:@"home_left_arrow" highlightedIcon:@"home_left_arrow"];
    }
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    [super popToRootViewControllerAnimated:animated];
    
//    [self removeTabBarButton];
    
    NSArray *vcs = [self viewControllers];
    return [vcs subarrayWithRange:NSMakeRange(1, [vcs count] - 1)];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super popToViewController:viewController animated:animated];
    
//    [self removeTabBarButton];
    
    NSArray *vcs = [self viewControllers];
    NSUInteger index = [vcs indexOfObject:viewController];
    index = index == NSNotFound ? [vcs count] : index;
    return [vcs subarrayWithRange:NSMakeRange(index + 1, [vcs count] - index - 1)];
}

-(void) removeTabBarButton {
    
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
//返回
- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
