


//
//  SSMessageDetailVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/23.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMessageDetailVC.h"
#import "EwenTextView.h"
#import "SSMessageDetailCell.h"
#import "SSMessageDetailListCell.h"
#import "SSCircleMessageDetailModel.h"
#import "SSCircleInputView.h"
#import "UITextView+Placeholder.h"
#import "SSCircleViewModel.h"
#import "SSCircleCommentDelView.h"

@interface SSMessageDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) EwenTextView *input_view;
@property (nonatomic, strong) SSCircleInputView *edite_view;
@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSCircleCommentDelView *delView;

@property (nonatomic, copy)   NSString *parentId;
@property (nonatomic, copy)   NSString *contentStr;

@property (nonatomic, assign) int pageNum;
@end

@implementation SSMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    [self wr_setNavBarShadowImageHidden:NO];
    [self setTitle:@"消息详情"];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:kColor(@"f8f8f8")]];
    [self.view addSubview:self.orderListTable];
    [self.input_view.edite_view.message_button setTitle:self.model.comCount forState:UIControlStateNormal];
    [self feltData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //TODO: 页面appear 禁用
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[UIApplication sharedApplication].keyWindow addSubview:self.input_view];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.input_view removeFromSuperview];
    //TODO: 页面Disappear 启用
    [[IQKeyboardManager sharedManager] setEnable:YES];
}


#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SSMessageDetailCell *cell = [SSMessageDetailCell cellWithTableView:tableView];
        [cell initCellWithModel:self.model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    SSMessageDetailListCell *cell = [SSMessageDetailListCell cellWithTableView:tableView];
    SSCircleMessageDetailModel *detailModel = self.dataArray[indexPath.row - 1];
    [cell initCellWithModel:detailModel];
    WEAKSELF
    cell.block = ^(SSCircleMessageDetailModel *model, SSMessageDetailType type) {
        if (type == SSMessageDetailTypeCellTap) {
            SSAccount *account = [SSAccountTool share].account;
            if ([account.uid intValue] ==  [model.userId intValue]) {
                [self.delView showDelView];
                self.delView.block = ^(SSCircleCommentDelViewType type) {
                    if (type == SSCircleCommentDelViewTypeDel) {
                        [[SSCircleViewModel share]delCommentWithCommentID:model.ID callBack:^(id obj) {
                            [ProgressHUD showSuccess:@"删除成功"];
                            [weakSelf feltData];
                        }];
                    }
                };
            }else{
                self.parentId = model.ID;
                weakSelf.input_view.textView.placeholder = [NSString stringWithFormat:@"回复:%@",model.name];
                [weakSelf.input_view.edite_view.content_textview becomeFirstResponder];
            }
        }else if(type == SSMessageDetailTypeDel){
            [[SSCircleViewModel share]delCommentWithCommentID:model.ID callBack:^(id obj) {
                [ProgressHUD showSuccess:@"删除成功"];
                [self feltData];
            }];
        }

    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 110 + 30 + self.model.contentHeight + self.model.cirledetail_bottomViewHeight + self.model.imageHeight;
    }
    SSCircleMessageDetailModel *detailModel = self.dataArray[indexPath.row - 1];
    return detailModel.tableview_height + 88 + detailModel.content_height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.parentId = @"";
        _input_view.textView.placeholder = [NSString stringWithFormat:@"回复:%@",self.model.name];
        [_input_view.edite_view.content_textview becomeFirstResponder];
    }else{
        SSCircleMessageDetailModel *detailModel = self.dataArray[indexPath.row - 1];
        self.parentId = detailModel.ID;
        _input_view.textView.placeholder = [NSString stringWithFormat:@"回复:%@",detailModel.name];
        [_input_view.edite_view.content_textview becomeFirstResponder];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"mine_order_null"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无订单";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:kColor(@"999999")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

//添加评论
- (void)addCommentWithContent:(NSString*)content parentId:(NSString *)parentId
{
    [[SSCircleViewModel share]addCommentWithMessageID:self.model.ID content:content parentId:parentId callBack:^(id obj) {
        [self feltData];
        self.parentId = @"";
        _input_view.textView.placeholder = [NSString stringWithFormat:@"回复:%@",self.model.name];
    }];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 50- kStatusBarHeight) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.backgroundColor = kColor(@"ffffff");
        _orderListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageNum = 1;
            [self feltData];
            [self.orderListTable.mj_header endRefreshing];
        }];
//        _orderListTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            self.pageNum ++;
//            [self feltData];
//            [self.orderListTable.mj_footer endRefreshing];
//        }];
        _orderListTable.mj_footer.automaticallyHidden = YES;
        _orderListTable.emptyDataSetSource = self;
        _orderListTable.emptyDataSetDelegate = self;
        [_orderListTable.mj_header beginRefreshing];
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (void)feltData
{
//    NSString *pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
    NSDictionary *params = @{@"messId":self.model.ID?self.model.ID:self.model.messId};
    [FZHttpTool post:UserCircleMessageComm parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        self.dataArray = [SSCircleMessageDetailModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        [self.orderListTable reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
 }

- (EwenTextView *)input_view{
    WEAKSELF
    if (!_input_view) {
        _input_view = [[EwenTextView alloc]initWithFrame:CGRectMake(0, kheight - 50, kwidth, 50)];
        _input_view.textView.placeholder = @"请输入评论的内容";
        _input_view.edite_view.block = ^(SSCircleInputType type) {
            if (type == SSCircleInputTypeMessage) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            SSMessageDetailCell *cell =[weakSelf.orderListTable cellForRowAtIndexPath:index];
            if (cell.height > kheight - 64) {
                [weakSelf.orderListTable setContentOffset:CGPointMake(0, cell.height) animated:YES];
            }
            }
        };
        _input_view.EwenTextViewBlock = ^(NSString *test){
            [weakSelf addCommentWithContent:test parentId:weakSelf.parentId];
            NSLog(@"%@",test);
        };
    }
    return _input_view;
}

- (SSCircleCommentDelView *)delView
{
    if (_delView == nil) {
        _delView = [[NSBundle mainBundle]loadNibNamed:@"SSCircleCommentDelView" owner:self options:nil].lastObject;
    }
    return _delView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end