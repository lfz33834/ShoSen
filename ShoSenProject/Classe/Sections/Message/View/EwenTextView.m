//
//  EwenTextView.m
//  0621TextViewDemo
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EwenTextView.h"
#import "Masonry.h"
#import "UITextView+Placeholder.h"
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenwidth (kScreenBounds.size.width)
#define kScreenheight (kScreenBounds.size.height)
#define UIColorRGB(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

@interface EwenTextView()<UITextViewDelegate,UIScrollViewDelegate>
{
    BOOL statusTextView;//当文字大于限定高度之后的状态
    NSString *placeholderText;//设置占位符的文字
}
@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UIButton *sendButton;
@end


@implementation EwenTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
    /**
     点击 空白区域取消
     */
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self addGestureRecognizer:centerTap];
    return self;
}

- (void)createUI{
    
    self.textView.hidden = YES;
    self.edite_view.hidden = NO;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kScreenwidth-30);
    }];
    
    [self.edite_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    self.textView.placeholder = @"请输入你的评论";
    
  //    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(5);
//        make.left.mas_equalTo(20);
//        make.height.mas_equalTo(30);
//    }];
//    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(8);
//        make.right.mas_equalTo(-5);
//        make.width.mas_equalTo(50);
//    }];
}

//暴露的方法
- (void)setPlaceholderText:(NSString *)text{
    placeholderText = text;
    self.placeholderLabel.text = placeholderText;
}


//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    self.frame = kScreenBounds;
    self.backgroundColor = UIColorFromRGBAlpha(0x000000, 0.2);
//    self.backgroundColor = [UIColor clearColor];
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    self.backGroundView.frame = CGRectMake(0, kheight-height-120, kScreenwidth, 120);

    self.textView.hidden = NO;
    self.edite_view.hidden = YES;
    [self.textView becomeFirstResponder];

//    if (self.textView.text.length == 0) {
//        self.backGroundView.frame = CGRectMake(0, kheight-height-120, kScreenwidth, 120);
//    }else{
//        CGRect rect = CGRectMake(0, kScreenheight - self.backGroundView.frame.size.height-height, kScreenwidth, self.backGroundView.frame.size.height);
//        self.backGroundView.frame = rect;
//    }
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];//取消第一响应者

        if (self.EwenTextViewBlock) {
            self.EwenTextViewBlock(self.textView.text);
            self.textView.text = @"";
        }
        return NO;
    }
    
    return YES;
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.textView.hidden = YES;
    self.edite_view.hidden = NO;
    self.backGroundView.frame = CGRectMake(0, 0, kScreenwidth, 50);
    self.frame = CGRectMake(0, kScreenheight  - 50, kScreenwidth, 50);

//    if (self.textView.text.length == 0) {
//        self.backGroundView.frame = CGRectMake(0, 0, kScreenwidth, 50);
//        self.frame = CGRectMake(0, kScreenheight, kScreenwidth, 50);
//    }else{
//        CGRect rect = CGRectMake(0, 0, kScreenwidth, self.backGroundView.frame.size.height);
//        self.backGroundView.frame = rect;
//        self.frame = CGRectMake(0, kScreenheight - rect.size.height, kScreenwidth, self.backGroundView.frame.size.height);
//    }
}

- (void)centerTapClick{
    [self.textView resignFirstResponder];
}

#pragma mark --- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    /**
     *  设置占位符
     */
//    if (textView.text.length == 0) {
//        self.placeholderLabel.text = placeholderText;
//        [self.sendButton setTitleColor:kColor(@"4A90E2") forState:UIControlStateNormal];
//        self.sendButton.userInteractionEnabled = NO;
//    }else{
//        self.placeholderLabel.text = @"";
//        [self.sendButton setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
//        self.sendButton.userInteractionEnabled = YES;
//    }
//
//    //---- 计算高度 ---- //
//    CGSize size = CGSizeMake(kScreenwidth-65, CGFLOAT_MAX);
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil];
//    CGFloat curheight = [textView.text boundingRectWithSize:size
//                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                                 attributes:dic
//                                                    context:nil].size.height;
//    CGFloat y = CGRectGetMaxY(self.backGroundView.frame);
//    if (curheight < 19.094) {
//        statusTextView = NO;
//        self.backGroundView.frame = CGRectMake(0, y - 50, kScreenwidth, 50);
//    }else if(curheight < MaxTextViewHeight){
//        statusTextView = NO;
//        self.backGroundView.frame = CGRectMake(0, y - textView.contentSize.height-10, kScreenwidth,textView.contentSize.height+10);
//    }else{
//        statusTextView = YES;
//        return;
//    }
    
}

#pragma  mark -- 发送事件
- (void)sendClick:(UIButton *)sender{
    [self.textView endEditing:YES];
    if (self.EwenTextViewBlock) {
        self.EwenTextViewBlock(self.textView.text);
    }
    //---- 发送成功之后清空 ------//
    self.textView.text = nil;
    self.placeholderLabel.text = placeholderText;
//    [self.sendButton setBackgroundColor:UIColorRGB(180, 180, 180)];
    [self.sendButton setTitleColor:kColor(@"666666") forState:UIControlStateNormal];
    self.sendButton.userInteractionEnabled = NO;
    self.frame = CGRectMake(0, kScreenheight, kScreenwidth, 50);
    self.backGroundView.frame = CGRectMake(0, 0, kScreenwidth, 50);
}



#pragma mark --- 懒加载控件
- (UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenwidth, 50)];
        _backGroundView.backgroundColor = kColor(@"ffffff");
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}

- (SSCircleInputView *)edite_view
{
    if (!_edite_view) {
        _edite_view = [[[NSBundle mainBundle]loadNibNamed:@"SSCircleInputView" owner:self options:nil]lastObject];
        [self.backGroundView addSubview:_edite_view];
    }
    return _edite_view;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.delegate = self;
        _textView.layer.cornerRadius = 5;
        _textView.returnKeyType = UIReturnKeySend;//改变为完成键，如果在项目中导入了YYText框架那么原生的就被替换掉了，变为returnKeyType = UIKeyboardTypeTwitter;
        [self.backGroundView addSubview:_textView];
    }
    return _textView;
}

//- (UILabel *)placeholderLabel{
//    if (!_placeholderLabel) {
//        _placeholderLabel = [[UILabel alloc]init];
//        _placeholderLabel.font = [UIFont systemFontOfSize:16];
//        _placeholderLabel.textColor = [UIColor grayColor];
//        [self.backGroundView addSubview:_placeholderLabel];
//    }
//    return _placeholderLabel;
//}
//
//- (UIButton *)sendButton{
//    if (!_sendButton) {
//        _sendButton = [[UIButton alloc]init];
//        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
//        _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_sendButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_sendButton setTitleColor:kColor(@"4A90E2") forState:UIControlStateNormal];
//        _sendButton.userInteractionEnabled = NO;
//        [self.backGroundView addSubview:_sendButton];
//    }
//    return _sendButton;
//}

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (statusTextView == NO) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        
    }
}

@end
