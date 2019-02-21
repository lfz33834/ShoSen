//
//  SSCircleReportView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleReportView.h"
#import "SSCircleReportCell.h"
#import "SSCircleListModel.h"

@interface SSCircleReportView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *reason_array;
@property (nonatomic, copy)   NSString *reasonString;

@end

@implementation SSCircleReportView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpCollectionView];
    
    [self.finish_button addTarget:self action:@selector(finishButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)cancelButtonTapAction:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)finishButtonTapAction
{
    if (self.reasonString.length > 0) {
        self.block(self.reasonString);
        [self removeFromSuperview];
    }else{
        [ProgressHUD showError:@"请选择举报原因"];
    }

}

- (void)showView
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}



- (void)setUpCollectionView
{
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
//    flowLayout.minimumInteritemSpacing = 10.0;//item间距(最小值)
    CGFloat with = (kwidth- 40)/2;
    flowLayout.itemSize = CGSizeMake(with, 52);//item的大小
     //第二个参数是cell的布局
    [self.reason_collectionview setCollectionViewLayout:flowLayout];
    self.reason_collectionview.dataSource = self;
    self.reason_collectionview.delegate = self;
    self.reason_collectionview.scrollEnabled = NO;
    self.reason_collectionview.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"SSCircleReportCell" bundle: [NSBundle mainBundle]];
    [self.reason_collectionview registerNib:nib forCellWithReuseIdentifier:@"SSCircleReportCell"];
 }

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.reason_array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSCircleReportCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SSCircleReportCell" forIndexPath:indexPath];
    SSCircleListModel *model = self.reason_array[indexPath.row];
    [cell initCellWithModel:model];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d %d", (int)indexPath.section, (int)indexPath.row);
    [self.reason_array enumerateObjectsUsingBlock:^(SSCircleListModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            obj.isSelect = YES;
            self.reasonString = obj.name;
        }else{
            obj.isSelect = NO;
        }
    }];
    [self.reason_collectionview reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat with = (kwidth - 40)/2;
    return CGSizeMake(with, 52);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (NSMutableArray *)reason_array{
    if(_reason_array == nil){
        _reason_array = [[NSMutableArray alloc]init];
        SSCircleListModel *model = [[SSCircleListModel alloc]init];
        model.name = @"淫秽色性";
        model.isSelect = NO;
        [_reason_array addObject:model];
        SSCircleListModel *model1 = [[SSCircleListModel alloc]init];
        model1.name = @"违法信息";
        model1.isSelect = NO;
        [_reason_array addObject:model1];
        SSCircleListModel *mode2 = [[SSCircleListModel alloc]init];
        mode2.name = @"营销广告";
        mode2.isSelect = NO;
        [_reason_array addObject:mode2];
        SSCircleListModel *model3 = [[SSCircleListModel alloc]init];
        model3.name = @"恶意攻击谩骂";
        model3.isSelect = NO;
        [_reason_array addObject:model3];
        SSCircleListModel *model4 = [[SSCircleListModel alloc]init];
        model4.name = @"其他";
        model4.isSelect = NO;
        [_reason_array addObject:model4];
    }
    return _reason_array;
}

@end
