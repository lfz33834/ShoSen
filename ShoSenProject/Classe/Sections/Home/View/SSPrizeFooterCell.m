//
//  SSPrizeFooterCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPrizeFooterCell.h"
#import "SSPrizeFooterItemCell.h"
#import "SSHomeViewModel.h"
#import "SSPrizeModel.h"

@interface SSPrizeFooterCell()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSHomeViewModel *viewModel;
@end

@implementation SSPrizeFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.item_tableview.delegate = self;
    self.item_tableview.dataSource = self;
    self.item_tableview.backgroundColor = kColor(@"fbdbca");
    self.item_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.info_webview.delegate = self;
//    self.info_webview.opaque = NO; //不设置这个值 页面背景始终是白色
//    self.info_webview.backgroundColor = [UIColor clearColor];
//    self.info_webview.scalesPageToFit = NO;  //禁止用户缩放页面
//    self.info_webview.dataDetectorTypes = UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink;
//    self.info_webview.scrollView.pagingEnabled = YES;
//    self.info_webview.scrollView.contentInset = UIEdgeInsetsMake(0, 0,0, 0);
//    self.info_webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://api.shosen.cn/news/sm.html"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    [self.info_webview loadRequest:request];
//    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%d;document.body.style.color=%@",15,@"#DA4142"];
//    [self.info_webview stringByEvaluatingJavaScriptFromString:jsString];
    [self feltData];
}

//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    //字体大小
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '120%'"];
//    //字体颜色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor='#DA4142'"];
//    //页面背景色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#FBDBCA'"];
//}

- (void)initCellWithArray:(NSMutableArray *)dataArray
{
    self.dataArray = dataArray;
    [self.item_tableview reloadData];
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSPrizeFooterItemCell *cell = [SSPrizeFooterItemCell cellWithTableView:tableView];
    SSPrizeModel *model = self.dataArray[indexPath.row];
    [cell initCellWithModel:model];
    if(indexPath.row%2 == 0){
        cell.contentView.backgroundColor = kColor(@"F6C3A6");
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)feltData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"questionnaire" ofType:@"json"];
    NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:nil];
    self.dataArray = [SSHomeModel mj_objectArrayWithKeyValuesArray:jsonObject];
    [self.orderListTable reloadData];
}

- (SSHomeViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSHomeViewModel alloc]init];
    }
    return _viewModel;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
