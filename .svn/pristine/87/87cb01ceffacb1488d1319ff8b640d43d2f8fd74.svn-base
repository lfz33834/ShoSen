//
//  SSCircleReportView.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCircleReportCell.h"


typedef void(^SSCircleReportViewBlock)(NSString *content);

@interface SSCircleReportView : UIView
@property (weak, nonatomic) IBOutlet UIButton *finish_button;
@property (weak, nonatomic) IBOutlet UICollectionView *reason_collectionview;
@property (nonatomic, copy) SSCircleReportViewBlock block;

- (void)showView;

@end
