//
//  SSHomeCollectionHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSHomeCollectionHeaderView.h"

@implementation SSHomeCollectionHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
//    self.book_button.layer.cornerRadius = 5;
//    self.book_button.layer.borderWidth = 2;
//    self.book_button.layer.borderColor = kColor(@"9b8361").CGColor;
}
- (IBAction)bookButtonTap:(UIButton *)sender {
    self.block();
}

@end
