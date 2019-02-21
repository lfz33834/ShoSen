//
//  SSCircleListCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/22.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleListCell.h"
#import "SSCircleListImageCell.h"
#import "SSCircleViewModel.h"

@interface SSCircleListCell() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) SSCircleViewModel *viewModel;

@end

@implementation SSCircleListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.del_button.hidden = YES;
    
    self.header_imageview.layer.cornerRadius = self.header_imageview.width*0.5;
    self.header_imageview.clipsToBounds = YES;
    
    [self.message_button addTarget:self action:@selector(messageTapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.dianzan_button addTarget:self action:@selector(dianzanTapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.del_button addTarget:self action:@selector(delTapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.zhankai_button addTarget:self action:@selector(zhankaiButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    }
    return cell;
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
    CGFloat with = (kwidth - 60- 15*2)/3;
    return CGSizeMake(with, 80);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)initCellWithModel:(SSCircleListModel *)model index:(NSInteger)index
{
    self.model = model;
    self.index = index;
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"mine_header_normal"]];
    self.title_lable.text = model.name;
    _time_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd hh:mm"];
     _content_label.text = model.content;
    
    
    if(self.model.contentHeight < 120){
        self.zhankai_button.hidden = YES;
    }else{
        self.zhankai_button.hidden = NO;
    }
    
    if(model.isUnfold){
        [self.zhankai_button setTitle:@"收起" forState:UIControlStateNormal];
    }else{
        [self.zhankai_button setTitle:@"展开" forState:UIControlStateNormal];
    }
    
    CGFloat content_height = 0;
    if (model.contentHeight > 120 && model.isUnfold) {
        content_height = model.contentHeight;
    }else if(model.contentHeight > 120 && !model.isUnfold){
        content_height = 120;
    }else{
        content_height = model.contentHeight;
    }
    
    _content_label_height.constant = content_height;
    [_dianzan_button setTitle:model.markCount forState:UIControlStateNormal];
    [_message_button setTitle:model.comCount forState:UIControlStateNormal];
    self.location_label.text = model.location;
    self.bg_view_height.constant = content_height+model.bottomViewHeight+model.imageHeight+ 60 + 30;

    NSArray *picArray = [model.picture componentsSeparatedByString:@","];
    self.dataArray = [picArray mutableCopy];
    [self.image_collection reloadData];
    if (model.location.length > 1) {
        self.location_label_height.constant = 21;
        self.bottom_view_height.constant = 100;
        self.dianzan_button_top.constant = 50;
        self.message_button_top.constant = 50;
    }else{
        self.location_label_height.constant = 0;
        self.bottom_view_height.constant = 70;
        self.dianzan_button_top.constant = 20;
        self.message_button_top.constant = 20;
    }
    

    
    self.bg_view.layer.cornerRadius = 5;
    self.bg_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.bg_view.layer.shadowOpacity=0.15;
    [self.bg_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kwidth - 30,  self.bg_view_height.constant)] CGPath]];
    self.bg_view.layer.shadowRadius = 5.0;//半径
    self.bg_view.layer.shadowOffset = CGSizeMake(4, 4);
    
    if ([model.markStatus intValue] == 1) {
        [_dianzan_button setTitleColor:kColor(@"D6B35B") forState:UIControlStateNormal];
        [_dianzan_button setImage:[UIImage imageNamed:@"circle_dianzan_select"] forState:UIControlStateNormal];
    }else{
        [_dianzan_button setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
        [_dianzan_button setImage:[UIImage imageNamed:@"circle_dianzan_normal"] forState:UIControlStateNormal];
    }
    
 }

- (void)messageTapAction
{
    self.block(SSCircleListCellTypeMessage,self.model,self.index);
}


- (void)delTapAction
{
    self.block(SSCircleListCellTypeUserDel,self.model,self.index);
}

- (void)zhankaiButtonTapAction
{
    self.block(SSCircleListCellTypeUserZhanKai,self.model,self.index);
}

- (void)dianzanTapAction
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
        self.block(SSCircleListCellTypeDianzan,self.model,self.index);

    }];
    
 }
- (IBAction)userInfoButtonTapAction:(UIButton *)sender {
    self.block(SSCircleListCellTypeUserInfo,self.model,self.index);
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
