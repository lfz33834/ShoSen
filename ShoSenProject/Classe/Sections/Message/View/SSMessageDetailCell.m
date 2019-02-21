//
//  SSMessageDetailCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/23.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMessageDetailCell.h"
#import "SSCircleListImageCell.h"
#import "SSCircleViewModel.h"

@interface SSMessageDetailCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SSCircleViewModel *viewModel;

@end

@implementation SSMessageDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.header_imageview.layer.cornerRadius = 25;
    self.header_imageview.clipsToBounds = YES;
    
    [self.dianzan_button addTarget:self action:@selector(dianzanMessageDetailTapAction) forControlEvents:UIControlEventTouchUpInside];

    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    self.image_collection.scrollEnabled = NO;
    //第二个参数是cell的布局
    self.image_collection.collectionViewLayout = flowLayout;
    self.image_collection.dataSource = self;
    self.image_collection.delegate = self;
    self.image_collection.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"SSCircleListImageCell" bundle: [NSBundle mainBundle]];
    [self.image_collection registerNib:nib forCellWithReuseIdentifier:@"SSCircleListImageCell"];
    
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
    SSCircleListImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SSCircleListImageCell" forIndexPath:indexPath];
    NSString *imageUrl = self.dataArray[indexPath.row];
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"circle_placeholder_2"]];
    if (self.dataArray.count == 1) {
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"circle_placeholder_1"]];
    }    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel showBrowserForSimpleCaseWithIndex:indexPath.row dataArray:self.dataArray];
    NSLog(@"%d %d", (int)indexPath.section, (int)indexPath.row);
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 1) {
        return CGSizeMake(kwidth - 60, 160);
    }
    CGFloat with = (kwidth - 30- 10*2)/3;
    return CGSizeMake(with, 80);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)initCellWithModel:(SSCircleListModel *)model
{
    self.model = model;
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"mine_header_normal"]];
    self.title_label.text = model.name;
    _time_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd hh:mm:ss"];
    _content_label.text = model.content;
    _content_label_height.constant = model.contentHeight;
    [_dianzan_button setTitle:model.markCount forState:UIControlStateNormal];
    self.loction_label.text = model.location;
    
    self.collectionimage_height.constant = model.imageHeight;
    
    NSArray *picArray = [model.picture componentsSeparatedByString:@","];
    self.dataArray = [picArray mutableCopy];
    [self.image_collection reloadData];
    if (model.location.length > 1) {
        self.bottomview_height.constant = 110;
        self.location_lable_height.constant = 20;
    }else{
        self.location_lable_height.constant = 0;
        self.bottomview_height.constant = 80;
    }
}


- (void)dianzanMessageDetailTapAction
{
    if ([self.model.markStatus intValue] == 1) {
        self.model.markStatus = @"0";
        self.model.markCount = [NSString stringWithFormat:@"%d",[self.model.markCount intValue] - 1];
    }else{
        self.model.markStatus = @"1";
        self.model.markCount = [NSString stringWithFormat:@"%d",[self.model.markCount intValue] + 1];
    }
    WEAKSELF
    [self.viewModel circleUpdateMessMarkWithMessId:self.model.ID markStatus:self.model.markStatus allBack:^(id obj) {
        if ([self.model.markStatus intValue] == 1) {
            [weakSelf.dianzan_button setTitleColor:kColor(@"D6B35B") forState:UIControlStateNormal];
            [weakSelf.dianzan_button setImage:[UIImage imageNamed:@"circle_dianzan_select"] forState:UIControlStateNormal];
        }else{
            [weakSelf.dianzan_button setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
            [weakSelf.dianzan_button setImage:[UIImage imageNamed:@"circle_dianzan_normal"] forState:UIControlStateNormal];
        }
        [weakSelf.dianzan_button setTitle:self.model.markCount forState:UIControlStateNormal];
    }];
}

- (SSCircleViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSCircleViewModel alloc]init];
    }
    return _viewModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
