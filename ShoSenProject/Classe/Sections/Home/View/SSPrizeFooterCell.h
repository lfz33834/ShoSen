//
//  SSPrizeFooterCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPrizeFooterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITableView *item_tableview;
@property (weak, nonatomic) IBOutlet UIWebView *info_webview;
@property (weak, nonatomic) IBOutlet UITextView *info_textview;

- (void)initCellWithArray:(NSMutableArray *)dataArray;
@end
