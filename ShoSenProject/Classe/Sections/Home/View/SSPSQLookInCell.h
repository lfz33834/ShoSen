//
//  SSPSQLookInCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/15.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSHomeModel.h"

typedef NS_ENUM(NSInteger, SSPSQLookInCellType) {
    SSPSQLookInCellTypeOne,
    SSPSQLookInCellTypeMore,
};

typedef void(^SSPSQLookInCellBlock)(SSHomeModel *returnModel);

@interface SSPSQLookInCell : UITableViewCell

@property (nonatomic, copy) SSPSQLookInCellBlock block;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UICollectionView *item_collectionview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_height;

@property (nonatomic, strong) SSHomeModel *homeModel;
@property (nonatomic, assign) SSPSQLookInCellType cellType;

- (void)initCellWithModel:(SSHomeModel *)homeModel;

@end
