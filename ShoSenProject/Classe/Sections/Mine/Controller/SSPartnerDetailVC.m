//
//  SSPartnerDetailVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/29.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPartnerDetailVC.h"
#import "SSPartnerDetailItemCell.h"
#import "SSPartnerItemModel.h"

@interface SSPartnerDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *item_array;

@end

@implementation SSPartnerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"详情"];
    self.item_view.layer.cornerRadius = 5;
    self.item_tableview.delegate = self;
    self.item_tableview.dataSource = self;
    self.item_tableview.scrollEnabled = NO;
    self.item_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    SSAccount *account = [SSAccountTool share].account;
    NSString *string = [NSString stringWithFormat:@"剩余%@个席位",account.remainNum];
    NSDictionary *attributedDict1 = @{
                                      NSFontAttributeName:[UIFont systemFontOfSize:18],
                                      NSForegroundColorAttributeName:kColor(@"D6B35B"),
                                      };
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttributes:attributedDict1 range:NSMakeRange(2,account.remainNum.length )];
    self.titleLabel.attributedText = attributedString;
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSPartnerDetailItemCell *cell = [SSPartnerDetailItemCell cellWithTableView:tableView];
    SSPartnerItemModel *model = self.item_array[indexPath.row];
    cell.content_label.text = model.contentStr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.item_array.count;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSPartnerItemModel *model = self.item_array[indexPath.row];
    return model.heightCell;
}

- (NSMutableArray *)item_array
{
    if (_item_array == nil) {
        _item_array = [[NSMutableArray alloc]init];
        SSPartnerItemModel *model1 = [[SSPartnerItemModel alloc]init];
        model1.contentStr = @"全额支付车款25万元";
        [_item_array addObject:model1];
        SSPartnerItemModel *model2 = [[SSPartnerItemModel alloc]init];
        model2.contentStr = @"享受商务智慧社区的所有权益，获得金钥匙 俱乐部身份（前一万名：包括全国所有6S汽 车馆免费预订权益）";
        [_item_array addObject:model2];
        SSPartnerItemModel *model3 = [[SSPartnerItemModel alloc]init];
        model3.contentStr = @"按照时间次序享受全球MAXMaker新能源汽 车唯一编号，并拥有相同编号的证书和超级 合伙人奖杯";
        [_item_array addObject:model3];
     }
    return _item_array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
