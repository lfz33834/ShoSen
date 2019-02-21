//
//  SSMineCtrl.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineCtrl.h"
#import "SSMineHeaderView.h"
#import "SSMineFooterView.h"
#import "SSMineCell.h"
#import "SSHomeModel.h"
#import "SSUserInfoVC.h"
#import "SSSettingVC.h"
#import "SSPartnerDetailVC.h"
#import "SSCircleVC.h"
#import "SSContributeDetailVC.h"
#import "SSBBSVC.h"
#import "SSEnterBBSVC.h"
#import "SSActiveBBSVC.h"
#import "SSLoveVC.h"

@interface SSMineCtrl ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SSMineHeaderView *headerView;
@property (nonatomic, strong) SSMineFooterView *footerView;
@property (nonatomic, strong) NSMutableArray   *data_array;
@property (nonatomic, strong) NSMutableArray   *lovedetail_array;
@property (nonatomic, strong) UITableView      *mine_table;

@end

@implementation SSMineCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wr_setNavBarTintColor:kColor(@"111113")];
    [self wr_setNavBarBarTintColor:kColor(@"111113")];
    [self wr_setNavBarTitleColor:kColor(@"ffffff")];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.view addSubview:self.mine_table];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginUserInfoUpdate) name:@"LoginNotification" object:nil];
    
    UIButton * rightBtn = [UIButton itemWithFream:CGRectMake(0.0, 0.0, 30.0f, 30.0f) withbackGroundColor:[UIColor clearColor] withTitle:@"" withTitleColor:[UIColor whiteColor] withTitleSize:16 withIsBold:NO];
    [rightBtn setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUserInfo];
}

- (void)loginUserInfoUpdate
{
    [self.headerView updateUserInfo];
}

- (void)rightBtnAction
{
    if([SSAccountTool share].account)
    {
        SSSettingVC *settingVC = [[SSSettingVC alloc]init];
        settingVC.block = ^{
            [self.headerView updateUserInfo];
        };
        [self.navigationController pushViewController:settingVC animated:YES];
        
    }else{
        
        SSLoginVC *loginVC = [[SSLoginVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

#pragma --tableDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSMineCell *cell = [SSMineCell cellWithTableView:tableView];
    cell.model = self.data_array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data_array.count;
}
#pragma --tableDelegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSAccount *account = [SSAccountTool share].account;
     if(account)
    {
        if(indexPath.row == 4)
        {
            NSString *buyCarUrl = [NSString stringWithFormat:@"%@?phone=%@",kBuyCarYesOrNo,account.phone];
            [FZHttpTool get:buyCarUrl parameters:nil httpToolSuccess:^(id  _Nullable json) {
                if([json[@"data"][@"isPay"] intValue] == 100)//1isPay = 100:己进行过付款isPay =  101:未进行过付款isSocial = 0  未激活社区管理平台 isSocial = 1 己激活社区管理平台
                {
                    if([json[@"data"][@"isSocial"] intValue] == 1){
                        SSEnterBBSVC *enterBBSVC = [[SSEnterBBSVC alloc]init];
                        [self.navigationController pushViewController:enterBBSVC animated:YES];
                    }else{
                        SSActiveBBSVC *enterBBSVC = [[SSActiveBBSVC alloc]init];
                        [self.navigationController pushViewController:enterBBSVC animated:YES];
                    }
                }else{
                    SSBBSVC *bbsVC = [[SSBBSVC alloc]init];
                    [self.navigationController pushViewController:bbsVC animated:YES];
                }
            } failure:^(NSError * _Nullable error) {
            }];
        }else if (indexPath.row == 5){
            FZWebViewController *webview = [[FZWebViewController alloc]init];
            webview.loadUrl = @"https://api.shosen.cn/app/help.html";
            webview.title = @"帮助中心";
            [self.navigationController pushViewController:webview animated:YES];
        }else if (indexPath.row == 6){
            FZWebViewController *webview = [[FZWebViewController alloc]init];
            webview.loadUrl = @"https://api.shosen.cn/app/sysnote.html";
            webview.title = @"系统公告";
            [self.navigationController pushViewController:webview animated:YES];
        }else{
            SSHomeModel *model = self.data_array[indexPath.row];
            FZBaseViewController *VC = [[NSClassFromString(model.className) alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else{
        SSLoginVC *loginVC = [[SSLoginVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *num = [[NSUserDefaults standardUserDefaults] objectForKey:KIsReview];
    if ([num intValue] == 1) {
        self.headerView.headerDetail_height_layout.constant = 0;
        self.headerView.headerDetail_view.hidden = YES;
        return 240 - 55;
//        return 240 - 55 + 50;
    }
    
    self.headerView.headerDetail_height_layout.constant = 55;
    self.headerView.headerDetail_view.hidden = NO;
//    return 240 + 50;
    return 240;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)updateUserInfo
{
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        [FZHttpTool post:UserInfoUrl parameters:@{@"phone":account.phone} isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
            [[SSAccountTool share]saveAccountData:[json[@"data"]mutableCopy]];
            [self.headerView updateUserInfo];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}

- (void)updateUserAddInfo
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *paramsDic = @{@"phone":account.phone};
    [FZHttpTool post:UserUpdateAddInfo parameters:paramsDic isShowHUD:YES httpToolSuccess:^(id json) {
        [self.headerView updateUserInfo];
    } failure:^(NSError *error) {
        [ProgressHUD showSuccess:@"请求失败"];
    }];
}

- (void)loveDetailList
{
    [FZHttpTool get:LoveDetailList parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {

    } failure:^(NSError * _Nullable error) {

    }];
}

- (UITableView *)mine_table
{
    if (!_mine_table) {
        _mine_table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - TABBAR_HEIGHT - kTopHeight) style:UITableViewStylePlain];
        _mine_table.delegate = self;
        _mine_table.dataSource = self;
//        _mine_table.scrollEnabled = NO;
        _mine_table.backgroundColor = kColor(@"f8f8f8");
        _mine_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mine_table;
}

- (SSMineHeaderView *)headerView
{
    if (_headerView == nil) {
        WEAKSELF
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"SSMineHeaderView" owner:self options:nil].lastObject;
        _headerView.block = ^(MineHeaderTapType type) {
            if([SSAccountTool share].account)
            {
                if (type == MineHeaderTapTypeUserInfo) {
                    SSUserInfoVC *infoVC = [[SSUserInfoVC alloc]init];
                    infoVC.block = ^{
                        [weakSelf updateUserInfo];
                    };
                    [weakSelf.navigationController pushViewController:infoVC animated:YES];
                }else if (type == MineHeaderTapTypePartner){
                    SSPartnerDetailVC *infoVC = [[SSPartnerDetailVC alloc]init];
                    [weakSelf.navigationController pushViewController:infoVC animated:YES];
                }else if (type == MineHeaderTapTypeLevel)
                {
                    SSContributeDetailVC *infoVC = [[SSContributeDetailVC alloc]init];
                    [weakSelf.navigationController pushViewController:infoVC animated:YES];
                }
            }else{
                SSLoginVC *loginVC = [[SSLoginVC alloc]init];
                [weakSelf.navigationController pushViewController:loginVC animated:YES];
            }
        };

    }
    return _headerView;
}

- (NSMutableArray *)data_array
{
    if (_data_array == nil) {
        _data_array = [[NSMutableArray alloc]init];
        SSHomeModel *model1 = [[SSHomeModel alloc]init];
        model1.titleStr = @"MAX订单";
        model1.imageName = @"mine_car";
        model1.className = @"SSMineOrderListVC";
        [_data_array addObject:model1];
        SSHomeModel *model2 = [[SSHomeModel alloc]init];
        model2.titleStr = @"商品订单";
        model2.imageName = @"mine_order";
        model2.className = @"SSMineShopAllOrderVC";
        [_data_array addObject:model2];
        
        SSHomeModel *model5 = [[SSHomeModel alloc]init];
        model5.titleStr = @"我的钱包";
        model5.imageName = @"mine_purse";
        model5.className = @"SSMyPurseVC";
        [_data_array addObject:model5];

        SSHomeModel *model3 = [[SSHomeModel alloc]init];
        model3.titleStr = @"邀请有礼";
        model3.imageName = @"mine_invatationcode";
        model3.className = @"SSInvitationCodeVC";
        [_data_array addObject:model3];

        SSHomeModel *model4 = [[SSHomeModel alloc]init];
        model4.titleStr = @"我的社区";
        model4.imageName = @"mine_bbs";
        model4.className = @"SSMineBBSAssetVC";
        [_data_array addObject:model4];
        
//        SSHomeModel *model8 = [[SSHomeModel alloc]init];
//        model8.titleStr = @"公益慈善";
//        model8.imageName = @"mine_love";
//        model8.className = @"SSLoveVC";
//        [_data_array addObject:model8];
        
        SSHomeModel *model6 = [[SSHomeModel alloc]init];
        model6.titleStr = @"帮助中心";
        model6.imageName = @"mine_help";
        model6.className = @"https://api.shosen.cn/app/help.html";
        [_data_array addObject:model6];
        
        SSHomeModel *model7 = [[SSHomeModel alloc]init];
        model7.titleStr = @"系统公告";
        model7.imageName = @"mine_warning";
        model7.className = @"SSMineBBSAssetVC";
        [_data_array addObject:model7];
    }
    return _data_array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
