//
//  SSShopDetailHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopDetailHeaderView.h"

@interface SSShopDetailHeaderView()<SDCycleScrollViewDelegate>



@end

@implementation SSShopDetailHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
//        self.webview_info.delegate = self;
//        self.webview_info.opaque = NO; //不设置这个值 页面背景始终是白色
//        self.webview_info.backgroundColor = [UIColor clearColor];
//        self.webview_info.scalesPageToFit = NO;  //禁止用户缩放页面
//        self.webview_info.dataDetectorTypes = UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink;
//        self.webview_info.scrollView.pagingEnabled = YES;
//        self.webview_info.scrollView.contentInset = UIEdgeInsetsMake(0, 0,0, 0);
//        self.webview_info.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://api.shosen.cn/app/line/inter/nfk12999/012217470501.html"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//        [self.webview_info loadRequest:request];
//        NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%d;document.body.style.color=%@",15,@"#DA4142"];
//        [self.webview_info stringByEvaluatingJavaScriptFromString:jsString];
    
    [self setUpScrollView];
}


- (void)setUpScrollView
{
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kwidth, 150) delegate:self placeholderImage:[UIImage imageNamed:@"circle_placeholder_1"]];
//    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.currentPageDotImage = [UIImage imageWithColor:kColor(@"D6B35B") size:CGSizeMake(15, 1)];
    cycleScrollView2.pageDotImage = [UIImage imageWithColor:kColor(@"ffffff") size:CGSizeMake(15, 1)];
    self.scroll_View = cycleScrollView2;
    [self.scrollview addSubview:self.scroll_View];
    //         block监听点击方式
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
    };
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    //字体大小
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '120%'"];
//    //字体颜色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor='#DA4142'"];
//    //页面背景色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#FBDBCA'"];
}

- (void)initCellWithModel:(SSGoodSInfoModel *)detailModel viewType:(SSShopDetailHeaderViewType )viewType
{
    _title_label.text = detailModel.name;
    if (viewType == SSShopDetailHeaderViewTypeJiFen) {
        _subtitle_label.text = [NSString stringWithFormat:@"%.2f积分",[detailModel.retailPrice floatValue]];
    }else{
        _subtitle_label.text = [NSString stringWithFormat:@"￥%.2f",[detailModel.retailPrice floatValue]];
    }
//    [_header_imageview sd_setImageWithURL:[NSURL URLWithString:detailModel.gallery[0]] placeholderImage:nil];
    self.scroll_View.imageURLStringsGroup = detailModel.gallery;

    [_footer_imageview sd_setImageWithURL:[NSURL URLWithString:detailModel.detail] placeholderImage:nil];
}

@end
