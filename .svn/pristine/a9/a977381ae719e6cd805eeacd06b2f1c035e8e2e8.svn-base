//
//  SSCircleCommentCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCircleMessageDetailModel.h"

typedef void(^SSCircleCommentCellBlock)(SSCircleMessageDetailModel *model);

@interface SSCircleCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (nonatomic, copy) SSCircleCommentCellBlock block;
@property (nonatomic, strong) SSCircleMessageDetailModel *detailModel;
- (void)initCellWithModel:(SSCircleMessageDetailModel *)detailModel;

@end
