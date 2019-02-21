//
//  SSInvitationCodeVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSInvitationCodeVC.h"
#import "SSInvationCodeCell.h"
#import "SSMineRulesVC.h"
#import <UShareUI/UShareUI.h>
#import "SSInvatorCodeWarningView.h"


@interface SSInvitationCodeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *orderListTable;
@property (nonatomic, strong) SSInvatorCodeWarningView *warningView;

@end

@implementation SSInvitationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.orderListTable];
    [self setTitle:@"邀请有礼"];
}

- (void)UMengShare
{

    SSAccount *account = [SSAccountTool share].account;
    NSString *buyCarUrl = [NSString stringWithFormat:@"%@?phone=%@",kBuyCarYesOrNo,account.phone];
    [FZHttpTool get:buyCarUrl parameters:nil httpToolSuccess:^(id  _Nullable json) {
        if([json[@"data"][@"isPay"] intValue] == 100)//1isPay = 100:己进行过付款isPay =  101:未进行过付款isSocial = 0  未激活社区管理平台 isSocial = 1 己激活社区管理平台
        {
            [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession)]];
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                // 根据获取的platformType确定所选平台进行下一步操作
                [self shareMiniProgramToPlatformType:platformType];
            }];
            
        }else{
            [self.warningView showView];
            
        }
    } failure:^(NSError * _Nullable error) {
    }];
    

}

- (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    NSData *data = [NSData  dataWithContentsOfURL:[NSURL URLWithString:@"https://api.shosen.cn/wx/images/share/share.png"]];
    UIImage *share_image =  [UIImage imageWithData:data];
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:@"MaxMaker" descr:@"加入社区合伙人，打造顶级商务智慧社区" thumImage:share_image];
    shareObject.webpageUrl = @"www.baidu.com";
    shareObject.userName = @"gh_ca9acc95304d";
    SSAccount *account = [SSAccountTool share].account;
    NSString *sharePath = [NSString stringWithFormat:@"%@?invitorPhone=%@",@"/pages/login/login",account.phone];
    shareObject.path = sharePath;
//    "/pages/login/login?invitorPhone="+手机号
//    pages/index/index?id=shosen
    messageObject.shareObject = shareObject;
    shareObject.hdImageData = data;
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 可选体验版和开发板
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}

- (void)shareAction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //分享的标题
        NSString *textToShare = @"首信天赐";
        //分享的图片
        UIImage *imageToShare = [UIImage imageNamed:@"mine_car"];
        //分享的url
        NSString *shareUrl = [NSString stringWithFormat:@"www.baidu.com"];
        NSURL *urlToShare = [NSURL URLWithString:shareUrl];
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
        NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
        // 分享之后的回调
        activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                [ProgressHUD showSuccess:@"分享成功"];
                //分享 成功
            } else  {
                [ProgressHUD showSuccess:@"分享取消"];
                //分享 取消
            }
        };
        
    });
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSInvationCodeCell *cell = [SSInvationCodeCell cellWithTableView:tableView];
    cell.block = ^(CodeType type) {
        if (type == CodeTypeRule) {
                SSMineRulesVC *ruleVC = [[SSMineRulesVC alloc]init];
                [self.navigationController pushViewController:ruleVC animated:YES];
        }else if (type == CodeTypeInvatation)
        {
            [self UMengShare];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
 }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 650;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [UIView new];
}

- (UITableView *)orderListTable
{
    if (!_orderListTable) {
        _orderListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
        _orderListTable.delegate = self;
        _orderListTable.dataSource = self;
        _orderListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _orderListTable;
}

- (SSInvatorCodeWarningView *)warningView
{
    if (_warningView == nil) {
        _warningView = [[NSBundle mainBundle]loadNibNamed:@"SSInvatorCodeWarningView" owner:self options:nil].lastObject;
        _warningView.frame = CGRectMake(0, 0, kwidth, kheight);
        _warningView.block = ^{
            
        };
    }
    return _warningView;
}

@end
