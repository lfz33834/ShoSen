//
//  WCNoticeAlertView.m
//  WeiChuan
//
//  Created by lifuzhou on 2018/5/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "WCNoticeAlertView.h"

@interface WCNoticeAlertView()

@property (nonatomic, strong) UIView * bgMaskView;
@property (nonatomic, strong) UIView *bgContentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *horizontalLine;
@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation WCNoticeAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLayout];
    }
    return self;
}

+ (instancetype)shareInstance
{
    static WCNoticeAlertView* _sharedUtils = nil;
    static dispatch_once_t _once;
    dispatch_once(&_once, ^{
        _sharedUtils = [[self alloc] init];
     });
    return _sharedUtils;
}

-(UIView *)bgMaskView
{
    if (_bgMaskView == nil) {
        _bgMaskView = [[UIView alloc]init];
        _bgMaskView.backgroundColor = [UIColor blackColor];
        _bgMaskView.alpha = 0.5;
    }
    return _bgMaskView;
}
- (UIView *)bgContentView
{
    if (_bgContentView == nil) {
        _bgContentView = [[UIView alloc]init];
        _bgContentView.backgroundColor = kColor(@"ffffff");
        _bgContentView.layer.cornerRadius = 13;
    }
    return _bgContentView;
}

- (UIView *)horizontalLine
{
    if (_horizontalLine == nil) {
        _horizontalLine = [[UIView alloc]init];
        _horizontalLine.backgroundColor = kColor(@"F0F0F0");
    }
    return _horizontalLine;
}

- (UIView *)verticalLine
{
    if (_verticalLine == nil) {
        _verticalLine = [[UIView alloc]init];
        _verticalLine.backgroundColor = kColor(@"F0F0F0");
    }
    return _verticalLine;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel C:@[FontS(17),kColor(@"000000"),@"1"]];
        _titleLabel.text = @"提示";
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)confirmButton
{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
         [_confirmButton setTitleColor:kColor(@"007AFF") forState:UIControlStateNormal];
         _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmTapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
         [_cancelButton setTitleColor:kColor(@"737373") forState:UIControlStateNormal];
         _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton setTitle:@"再想想" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelTapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = kColor(@"222222");
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = @"确定失去这次美好的机会？何不试试？说不定认识一个有趣的朋友呢～";
    }
    return _contentLabel;
}

- (void)createLayout
{
    [self addSubview:self.bgMaskView];
    [self addSubview:self.bgContentView];
    [self.bgContentView addSubview:self.titleLabel];
    [self.bgContentView addSubview:self.contentLabel];
    [self.bgContentView addSubview:self.confirmButton];
    [self.bgContentView addSubview:self.cancelButton];
    [self.bgContentView addSubview:self.horizontalLine];
    [self.bgContentView addSubview:self.verticalLine];
 
    self.bgMaskView.frame = self.bounds;
    self.bgContentView.frame = CGRectMake(50, 231, kwidth - 100, 211);
    self.titleLabel.frame = CGRectMake(50, 22, self.bgContentView.width - 100, 20);
    self.contentLabel.frame = CGRectMake(21, 63, self.bgContentView.width - 42, self.bgContentView.height - 143);
    _horizontalLine.frame = CGRectMake(0, self.bgContentView.height - 45, self.bgContentView.width, 1);
    _verticalLine.frame = CGRectMake(self.bgContentView.width/2, self.horizontalLine.y, 1, 40);
    _cancelButton.frame = CGRectMake(0, self.bgContentView.height - 40, self.bgContentView.width/2, 40);
    _confirmButton.frame = CGRectMake(self.bgContentView.width/2, self.bgContentView.height - 40, self.bgContentView.width/2, 40);

    
    
//    _cancelButton.sd_layout.leftEqualToView(self.bgContentView).offset(0)
//    .bottomEqualToView(self.bgContentView).offset(0)
//    .widthIs((kwidth - 100)/2)
//    .heightIs(40);
//
//    self.confirmButton.sd_layout.rightEqualToView(self.bgContentView).offset(0)
//    .bottomEqualToView(self.bgContentView).offset(0)
//    .widthIs((kwidth - 100)/2)
//    .heightIs(40);
}

- (void)setDicData:(NSDictionary *)dicData
{
    _titleLabel.text = dicData[@"title"];
    _contentLabel.text = dicData[@"content"];
    [_cancelButton setTitle:dicData[@"cancel"] forState:UIControlStateNormal];
    [_confirmButton setTitle:dicData[@"confirm"] forState:UIControlStateNormal];
}

- (void)confirmTapAction
{
    self.block(WCNoticeAlertViewTypeConfirm);
    [self hideNoticeView];
 }

- (void)cancelTapAction
{
    if(self.block)
    {
        self.block(WCNoticeAlertViewTypeCancel);
    }
    [self hideNoticeView];
 }

- (void)showNoticeView
{
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}
- (void)hideNoticeView
{
    [self removeFromSuperview];
}
- (void)closeAlertView
{
    self.transform = CGAffineTransformMakeScale(1, 1);
    self.alpha = 1;
    [UIView animateWithDuration:1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
        [self removeFromSuperview];
    }];
}

@end
