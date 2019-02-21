//
//  FZPickerTool.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/28.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZPickerTool.h"
#import "SSFlagsModel.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface FZPickerTool ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *toolBar;

@property (nonatomic, copy) PickerDidSelectBlock didSelectBlock;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *datas;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end

@implementation FZPickerTool

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
//        _bgView.backgroundColor = KColor(45, 47, 56);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_bgView addGestureRecognizer:tap];
        
        [_bgView addSubview:self];
        [_bgView addSubview:self.toolBar];
        
        
    }
    return _bgView;
}

- (UIView *)toolBar
{
    if (_toolBar==nil) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-self.bounds.size.height-34, kScreenW, 34)];
        _toolBar.backgroundColor = [UIColor whiteColor];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(kScreenW-60, 0, 60, _toolBar.bounds.size.height);
        [finishBtn setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [finishBtn addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:finishBtn];
        
//        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        cancelBtn.frame = CGRectMake(0, 0, 60, _toolBar.bounds.size.height);
//        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//        [_toolBar addSubview:cancelBtn];
    }
    return _toolBar;
}

- (void)finishClick:(UIButton *)btn
{
    if (self.didSelectBlock) {
        if (self.datas.count) {
            self.didSelectBlock(self.indexPath);
        }
    }
    [self close];
}

- (void)close
{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
    [self.toolBar removeFromSuperview];
    self.toolBar = nil;
    self.bgView = nil;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self.bgView];
}

+ (void)show:(NSArray<NSArray<NSString *> *> *)datas didSelectBlock:(PickerDidSelectBlock)didSelectBlock
{
    FZPickerTool *pickerView = [[FZPickerTool alloc] initWithFrame:CGRectMake(0, kScreenH-150, kScreenW, 150)];
    pickerView.didSelectBlock = didSelectBlock;
    pickerView.datas = datas;
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = pickerView;
    pickerView.dataSource = pickerView;
    
    [pickerView show];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.datas.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datas[component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([self.datas[component][row] isKindOfClass:[NSString class]])
    {
        return self.datas[component][row];
    }
    SSFlagsModel *model = (SSFlagsModel *)self.datas[component][row];
    return model.dicValue;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.indexPath = [NSIndexPath indexPathForRow:row inSection:component];
}


@end
