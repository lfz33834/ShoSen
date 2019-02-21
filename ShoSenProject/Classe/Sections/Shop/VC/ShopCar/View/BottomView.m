//
//  BottomView.m
//  ShopCarDemo
//
//  Created by 周智勇 on 16/7/25.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "BottomView.h"
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface BottomView ()

@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UILabel * titleLable;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UILabel * totalLable;
@property (nonatomic, strong)UIView * lineView;
@property (nonatomic, assign)BottomViewType type;

@end
@implementation BottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
//        [self addSubview:self.lineView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.titleLable];
        [self addSubview:self.totalLable];
        self.backgroundColor = kColor(@"ffffff");
        
        [self.rightBtn setBackgroundImage:[UIImage imageWithColor:kColor(@"d2d2d2")] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark -- 

-(UIView *)lineView{
    if (_lineView == nil) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        _lineView.backgroundColor = RGBAColor(200, 200, 200, .5);
        
    }
    return _lineView;
}

- (UIButton *)leftBtn{
    if (_leftBtn == nil) {
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(15, 12, 30, 30);
        [_leftBtn setImage:[UIImage imageNamed:@"shoppingCar_unselect"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(clickedLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}


-(UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(55, 18, 100, 20)];
        _titleLable.text = @"全选";
        _titleLable.textColor = kColor(@"666666");
        _titleLable.font = [UIFont systemFontOfSize:16];
    }
    return _titleLable;
}

- (UIButton *)rightBtn{
    if (_rightBtn == nil) {
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame =CGRectMake(kwidth - 135, 0, 135, 55);
        _rightBtn.backgroundColor = kColor(@"d2d2d2");
        [_rightBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(jieSuanClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(UILabel *)totalLable{
    if (_totalLable == nil) {
        self.totalLable = [[UILabel alloc] initWithFrame:CGRectMake(125, 17.5, 150, 20)];
         _totalLable.font = [UIFont systemFontOfSize:15];
        _totalLable.textAlignment = NSTextAlignmentLeft;
        _totalLable.textColor = kColor(@"F95959");
      }
    return _totalLable;
}

#pragma mark---
- (void)clickedLeftBtn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedBottomSelecteAll)]) {
        [self.delegate clickedBottomSelecteAll];
    }
}

- (void)jieSuanClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedBottomJieSuanWithType:model:)]) {
        if (self.type == BottomViewTypePay) {
            [self.delegate clickedBottomJieSuanWithType:BottomViewTypePay model:self.model];
        }else if (self.type == BottomViewTypeDelete)
        {
            [self.delegate clickedBottomJieSuanWithType:BottomViewTypeDelete model:self.model];
        }else{
            [self.delegate clickedBottomJieSuanWithType:BottomViewTypeNormal model:self.model];
        }
    }
}


#pragma mark -- setter
-(void)setModel:(BottomModel *)model{
    _model = model;
    if (_model.isSelecteAll) {
        [self.leftBtn setImage:[UIImage imageNamed:@"shoppingCar_select"] forState:UIControlStateNormal];
    }else{
        [self.leftBtn setImage:[UIImage imageNamed:@"shoppingCar_unselect"] forState:UIControlStateNormal];
    }    
    if (_model.isEdit) {
        if (_model.totalCount > 0) {
            self.type = BottomViewTypeDelete;
        }else{
            self.type = BottomViewTypeNormal;
        }
        [self.rightBtn setTitle:@"删除所选" forState:UIControlStateNormal];
    }else{
        if (_model.totalCount > 0) {
            self.type = BottomViewTypePay;
            [self.rightBtn setTitle:@"去结算" forState:UIControlStateNormal];
        }else{
            self.type = BottomViewTypeNormal;
            [self.rightBtn setTitle:@"去结算" forState:UIControlStateNormal];
        }
    }
    
    if (_model.totalCount > 0) {
        [self.leftBtn setImage:[UIImage imageNamed:@"shoppingCar_select"] forState:UIControlStateNormal];
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"shop_bottom_button"] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:kColor(@"ffffff") forState:UIControlStateNormal];
   
        if (!_model.isEdit) {
            self.totalLable.text = [NSString stringWithFormat:@"￥%.2f",_model.totalMoney];
        }else{
            self.totalLable.text = @"";
        }
        
        self.titleLable.text = [NSString stringWithFormat:@"已选（%ld）",(long)_model.totalCount];

    }else{
        self.titleLable.text = @"全选";
        [self.leftBtn setImage:[UIImage imageNamed:@"shoppingCar_unselect"] forState:UIControlStateNormal];
        [self.rightBtn setBackgroundImage:[UIImage imageWithColor:kColor(@"d2d2d2")] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
        self.totalLable.text = @"";
    }
}

@end
