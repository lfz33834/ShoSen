//
//  SSPSQLookInCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/15.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPSQLookInCell.h"
#import "SSPSQItemCell.h"

@interface SSPSQLookInCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, copy) NSString *selectobj;

@end

@implementation SSPSQLookInCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpCollectionView];
}

- (void)initCellWithModel:(SSHomeModel *)homeModel
{
    self.homeModel = homeModel;
    self.title_height.constant = homeModel.titleHeight;
    self.title_label.text = homeModel.title;
    self.dataArray = homeModel.data;
    [self.item_collectionview reloadData];
}

- (void)setUpCollectionView
{
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    //第二个参数是cell的布局
    self.item_collectionview.collectionViewLayout = flowLayout;
    self.item_collectionview.dataSource = self;
    self.item_collectionview.delegate = self;
    self.item_collectionview.scrollEnabled = NO;
    self.item_collectionview.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"SSPSQItemCell" bundle: [NSBundle mainBundle]];
    [self.item_collectionview registerNib:nib forCellWithReuseIdentifier:@"SSPSQItemCell"];
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
    SSPSQItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SSPSQItemCell" forIndexPath:indexPath];
    SSAnswerModel *model = self.dataArray[indexPath.row];
    if ([self.homeModel.type intValue] == 0) {//单选
        if (model.isSelected) {
            cell.left_imageview.image = [UIImage imageNamed:@"home_lookin_one_select"];
        }else{
            cell.left_imageview.image = [UIImage imageNamed:@"home_lookin_one_normal"];
        }
    }else if([self.homeModel.type intValue] == 1){//多选
        if (model.isSelected) {
            cell.left_imageview.image = [UIImage imageNamed:@"home_lookin_more_select"];
        }else{
            cell.left_imageview.image = [UIImage imageNamed:@"home_lookin_more_normal"];
        }
    }
    
    cell.item_label.text = model.answerValue;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.homeModel.type intValue] == 0) {//单选
        [self.dataArray enumerateObjectsUsingBlock:^(SSAnswerModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == indexPath.row) {
                obj.isSelected = YES;
            }else{
                obj.isSelected = NO;
            }
        }];
     }else if([self.homeModel.type intValue] == 1){//多选
         
         [self.dataArray enumerateObjectsUsingBlock:^(SSAnswerModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
             if (idx == indexPath.row) {
                 obj.isSelected = !obj.isSelected;
             }
         }];
     }
    
    [self.item_collectionview reloadData];
    
    [self.dataArray enumerateObjectsUsingBlock:^(SSAnswerModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            self.homeModel.isSelected = YES;
        }
    }];
    self.homeModel.data = self.dataArray;
    self.block(self.homeModel);
    NSLog(@"%d %d", (int)indexPath.section, (int)indexPath.row);
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int with = (kwidth- 50)/[self.homeModel.spanCount intValue];

    return CGSizeMake(with, 40);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray *)selectArray
{
    if (_selectArray == nil) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
}

@end
