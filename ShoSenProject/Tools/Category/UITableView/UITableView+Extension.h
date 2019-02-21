//
//  UITableView+Convenience.h
//  qingsongchou
//
//  Created by CaoPing on 15/5/22.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)

@property (nonatomic) BOOL canHeaderViewToFloat;//default is NO
@property (nonatomic) BOOL canFooterViewToFloat;//default is NO

- (void)registerCellClasses:(NSArray *)cellClasses;
- (id)dequeueReusableCellWithCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

-(void)setExtraCellLineHidden:(BOOL)hidden;

- (NSIndexPath *)indexPathForLastRow;
- (NSArray *)indexPathsForAllSection;
- (NSArray *)indexPathsForAllRowsInSection:(NSInteger)section;
- (NSArray *)indexPathsForRowInSection:(NSInteger)section fromIndex:(NSInteger)anIndex length:(NSInteger)length;



@end
