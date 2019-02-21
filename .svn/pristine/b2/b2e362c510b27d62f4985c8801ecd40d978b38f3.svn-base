//
//  SSMessageDetailListCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/23.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMessageDetailListCell.h"
#import "SSCircleCommentCell.h"
#import "SSCircleViewModel.h"

@interface SSMessageDetailListCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSCircleViewModel *viewModel;

@end

@implementation SSMessageDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.comment_tableview.delegate = self;
    self.comment_tableview.dataSource = self;
    self.comment_tableview.scrollEnabled = NO;
    self.comment_tableview.backgroundColor = kColor(@"f8f8f8");
    self.comment_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.header_imageview.layer.cornerRadius = 25;
    self.header_imageview.clipsToBounds = YES;
    self.del_button.hidden = YES;
    
    [self.dianzan_button addTarget:self action:@selector(dianzanButonTapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.del_button addTarget:self action:@selector(delCommentActon) forControlEvents:UIControlEventTouchUpInside];
}

- (void)delCommentActon
{
    if (self.block) {
        self.block(self.model,SSMessageDetailTypeDel);
    }
}

- (void)initCellWithModel:(SSCircleMessageDetailModel *)model
{
    self.model = model;
    SSAccount *account = [SSAccountTool share].account;
    if ([account.uid intValue] == [model.userId intValue]) {
        self.del_button.hidden = NO;;
    }
   [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"mine_header_normal"]];
    self.title_label.text = model.name;
    NSString *showText = [model.content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.content_label.text = showText;
    _time_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"hh:mm"];
    self.dataArray = model.commontList;
    [self.comment_tableview reloadData];
    self.tableview_height.constant = model.tableview_height;
    self.content_label_height.constant = model.content_height;
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSCircleCommentCell *cell = [SSCircleCommentCell cellWithTableView:tableView];
    SSCircleMessageDetailModel *model = self.dataArray[indexPath.row];
    [cell initCellWithModel:model];
//    cell.block = ^(SSCircleMessageDetailModel *model) {
//        NSLog(@"点击了数据");
//    };
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
    SSCircleMessageDetailModel *model = self.dataArray[indexPath.row];
    return model.commont_height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSCircleMessageDetailModel *model = self.dataArray[indexPath.row];
    if (self.block) {
        self.block(model,SSMessageDetailTypeCellTap);
        NSLog(@"点击了cell");
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)dianzanButonTapAction{
    if ([self.model.markStatus intValue] == 1) {
        self.model.markStatus = @"0";
//        self.model.markCount = [NSString stringWithFormat:@"%d",[self.model.markCount intValue] - 1];
    }else{
        self.model.markStatus = @"1";
//        self.model.markCount = [NSString stringWithFormat:@"%d",[self.model.markCount intValue] + 1];
    }
    WEAKSELF
    [self.viewModel circleUpdateMessMarkWithMessId:self.model.ID markStatus:self.model.markStatus allBack:^(id obj) {
        if ([self.model.markStatus intValue] == 1) {
//            [weakSelf.dianzan_button setTitleColor:kColor(@"D6B35B") forState:UIControlStateNormal];
            [weakSelf.dianzan_button setImage:[UIImage imageNamed:@"circle_dianzan_select"] forState:UIControlStateNormal];
        }else{
//            [weakSelf.dianzan_button setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
            [weakSelf.dianzan_button setImage:[UIImage imageNamed:@"circle_dianzan_normal"] forState:UIControlStateNormal];
        }
//        [weakSelf.dianzan_button setTitle:self.model.markCount forState:UIControlStateNormal];
    }];
}

- (SSCircleViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSCircleViewModel alloc]init];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
