//
//  SSHomeHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSHomeHeaderView.h"
#import "SSHomCollectionCell.h"
#import "SSHomeModel.h"
#import "SSHomeViewModel.h"
#import "SSInvitationCodeVC.h"
#import "SSCircleTwoView.h"

@interface SSHomeHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSHomeViewModel *viewModel;
@property (nonatomic, strong) SSCircleTwoView *circel_twoview;

@end

@implementation SSHomeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpCollectionView];
    [self setUpScrollView];
    [self.book_button addTarget:self action:@selector(bookButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bookButtonTapAction
{
    if (self.block) {
        self.block(SSHomeHeaderViewTypeBook);
    }
}
- (IBAction)moreButtonTapAction:(UIButton *)sender {
    
    if (self.block) {
        self.block(SSHomeHeaderViewTypeMore);
    }
}

- (void)setUpScrollView
{
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kwidth, 155) delegate:self placeholderImage:[UIImage imageNamed:@"circle_placeholder_1"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.currentPageDotImage = [UIImage imageWithColor:kColor(@"D6B35B") size:CGSizeMake(15, 1)];
    cycleScrollView2.pageDotImage = [UIImage imageWithColor:kColor(@"ffffff") size:CGSizeMake(15, 1)];
    self.scrollView = cycleScrollView2;
    [self.scrollview_image addSubview:cycleScrollView2];
    //         block监听点击方式
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
    };
}

- (void)setUpCollectionView
{
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
        //第二个参数是cell的布局
    self.collection_view.collectionViewLayout = flowLayout;
    self.collection_view.dataSource = self;
    self.collection_view.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"SSHomCollectionCell" bundle: [NSBundle mainBundle]];
    [self.collection_view registerNib:nib forCellWithReuseIdentifier:@"SSHomCollectionCell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSHomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SSHomCollectionCell" forIndexPath:indexPath];
    cell.homeModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSAccount *account = [SSAccountTool share].account;
    if (!account) {
        SSLoginVC *loginVC = [[SSLoginVC alloc]init];
        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:loginVC animated:YES];
    }else{
        if (indexPath.row == 0) {//活动
            self.block(SSHomeHeaderViewTypeActive);
        }else if (indexPath.row == 1)//签到
        {
            SSAccount *account = [SSAccountTool share].account;
            if (!account) {
                SSLoginVC *loginVC = [[SSLoginVC alloc]init];
                [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:loginVC animated:YES];
            }else{
                [self.viewModel homeSignInWithPhoneCallBack:^(id json) {
                    //                [ProgressHUD showSuccess:@"签到成功"];
                    if([json[@"code"]  intValue]== 997)
                    {
                        self.block(SSHomeHeaderViewTypeSigninFailure);
                    }else{
                        [self updateUserInfo];
                        self.block(SSHomeHeaderViewTypeSignin);
                    }
                }];
            }
        }else if (indexPath.row == 2)//有奖
        {
            SSInvitationCodeVC *codeVC = [[SSInvitationCodeVC alloc]init];
            [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:codeVC animated:YES];
        }else if (indexPath.row == 3)//商城
        {
            self.block(SSHomeHeaderViewTypeMall);
          }
    }
    NSLog(@"%d %d", (int)indexPath.section, (int)indexPath.row);
}


- (void)updateUserInfo
{
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        [FZHttpTool post:UserInfoUrl parameters:@{@"phone":account.phone} isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
            [[SSAccountTool share]saveAccountData:[json[@"data"]mutableCopy]];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat with = (kwidth- 10*3)/ 4;
    return CGSizeMake(with, 95);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (SSCircleTwoView *)circel_twoview
{
    if (_circel_twoview == nil) {
        _circel_twoview = [[[NSBundle mainBundle]loadNibNamed:@"SSCircleTwoView" owner:self options:nil]lastObject];
        _circel_twoview.frame = CGRectMake(0, 0, kwidth, kheight);
    }
    return _circel_twoview;
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
        SSHomeModel *model1 = [[SSHomeModel alloc]init];
        model1.titleStr = @"活动";
        model1.imageName = @"https://api.shosen.cn/app/img/btn1.png";
        SSHomeModel *model2 = [[SSHomeModel alloc]init];
        model2.titleStr = @"签到";
        model2.imageName = @"https://api.shosen.cn/app/img/btn2.png";
        SSHomeModel *model3 = [[SSHomeModel alloc]init];
        model3.titleStr = @"邀请有奖";
        model3.imageName = @"https://api.shosen.cn/app/img/btn3.png";
        SSHomeModel *model4 = [[SSHomeModel alloc]init];
        model4.titleStr = @"会员中心";
        model4.imageName = @"https://api.shosen.cn/app/img/btn4.png";
        [_dataArray addObject:model1];
        [_dataArray addObject:model2];
        [_dataArray addObject:model3];
        [_dataArray addObject:model4];
    }
    return _dataArray;
}

@end
