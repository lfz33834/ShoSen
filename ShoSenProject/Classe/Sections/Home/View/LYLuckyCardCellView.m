//
//  LYLuckyCardCellView.m
//  LYLuckyCardDemo
//
//  Created by leo on 17/2/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "LYLuckyCardCellView.h"

@interface LYLuckyCardCellView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation LYLuckyCardCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    self.label.font = [UIFont systemFontOfSize:13];
    self.label.textColor = kColor(@"da4142");
    self.label.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 - 20);
    [self addSubview:self.label];
}

- (void)configCell:(NSString *)type {
    NSArray *contentArray = [type componentsSeparatedByString:@","];
    if (contentArray.count == 2) {
        self.label.text = [NSString stringWithFormat:@"%@\n%@",contentArray[0],contentArray[1]];
    }else{
        self.label.text = type;
    }
}

@end
