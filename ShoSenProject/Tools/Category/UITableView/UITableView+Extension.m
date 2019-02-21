//
//  UITableView+Convenience.m
//  qingsongchou
//
//  Created by CaoPing on 15/5/22.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import "UITableView+Extension.h"
#import <objc/runtime.h>

static const void *canHeaderViewToFloatKey = &canHeaderViewToFloatKey;
static const void *canFooterViewToFloatKey = &canFooterViewToFloatKey;
@implementation UITableView (Extension)

- (void)registerCellClasses:(NSArray *)cellClasses
{
    [cellClasses enumerateObjectsUsingBlock:^(Class cellClass, NSUInteger idx, BOOL *stop) {
        [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }];
}

- (id)dequeueReusableCellWithCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}



- (BOOL)allowsHeaderViewsToFloat
{
    return self.canHeaderViewToFloat;
}

- (BOOL)allowsFooterViewToFloat
{
    return self.canFooterViewToFloat;
}

- (BOOL)canHeaderViewToFloat
{
    return [objc_getAssociatedObject(self, canHeaderViewToFloatKey) boolValue];
}

- (void)setCanHeaderViewToFloat:(BOOL)canHeaderViewToFloat
{
    objc_setAssociatedObject(self, canHeaderViewToFloatKey, [NSNumber numberWithBool:canHeaderViewToFloat], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)canFooterViewToFloat
{
    return [objc_getAssociatedObject(self, canFooterViewToFloatKey) boolValue];
}

- (void)setCanFooterViewToFloat:(BOOL)canFooterViewToFloat
{
    objc_setAssociatedObject(self, canFooterViewToFloatKey, [NSNumber numberWithBool:canFooterViewToFloat], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setExtraCellLineHidden:(BOOL)hidden
{
    if (hidden == YES) {
        UIView *view =[ [UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        [self setTableFooterView:view];
    }
}


- (NSIndexPath *)indexPathForLastRow
{
    return [NSIndexPath indexPathForRow:[self numberOfRowsInSection:self.numberOfSections-1] - 1
                              inSection:self.numberOfSections-1];
}

- (NSArray *)indexPathsForAllSection
{
    NSMutableArray *indexPaths = [@[] mutableCopy];
    
    NSInteger numberOfSections = [self.dataSource numberOfSectionsInTableView:self];
    
    for (int i=0; i<numberOfSections; i++) {
        [indexPaths addObjectsFromArray:[self indexPathsForAllRowsInSection:i]];
    }
    return indexPaths;
}

- (NSArray *)indexPathsForAllRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = [self.dataSource tableView:self numberOfRowsInSection:section];
    
    return [self indexPathsForRowInSection:section fromIndex:0 length:numberOfRows];
}

- (NSArray *)indexPathsForRowInSection:(NSInteger)section fromIndex:(NSInteger)anIndex length:(NSInteger)length
{
    NSMutableArray *indexPaths = [@[] mutableCopy];
    for (NSInteger i = anIndex; i<length+anIndex; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    return indexPaths;
}

@end
