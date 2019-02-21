//
//  SSCircleCommentCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleCommentCell.h"

@interface SSCircleCommentCell()<UIGestureRecognizerDelegate>

@end

@implementation SSCircleCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    centerTap.delegate = self;//遵循手势协议
    self.content_label.lineBreakMode = NSLineBreakByCharWrapping;
//    [self addGestureRecognizer:centerTap];
}

- (void)centerTapClick
{
    self.block(self.detailModel);
    
}

//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//
//    return YES;
//
//}


- (void)initCellWithModel:(SSCircleMessageDetailModel *)detailModel
{
    self.detailModel = detailModel;
    NSString *contentString;
    if ([detailModel.ID intValue] == [detailModel.parentId intValue]) {
        contentString = [NSString stringWithFormat:@"%@:%@",detailModel.name,detailModel.content];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentString];
        NSDictionary *attributedDict1 = @{
                                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                                          NSForegroundColorAttributeName:kColor(@"666666"),
                                          };
        [attributedString addAttributes:attributedDict1 range:NSMakeRange(0, detailModel.name.length)];
        
//        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle1 setLineSpacing:5];
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [contentString length])];
        self.content_label.attributedText = attributedString;
        
    }else{
        contentString = [NSString stringWithFormat:@"%@回复%@:%@",detailModel.name,detailModel.parentName,detailModel.content];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentString];
        NSDictionary *attributedDict1 = @{
                                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                                          NSForegroundColorAttributeName:kColor(@"666666"),
                                          };
        [attributedString addAttributes:attributedDict1 range:NSMakeRange(0, detailModel.name.length)];
        [attributedString addAttributes:attributedDict1 range:NSMakeRange(detailModel.name.length+2, detailModel.parentName.length)];
        
//        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle1 setLineSpacing:5];
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [contentString length])];
        self.content_label.attributedText = attributedString;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
