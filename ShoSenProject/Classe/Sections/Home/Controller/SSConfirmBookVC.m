//
//  SSConfirmBookVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSConfirmBookVC.h"
#import "SSOrderFooterView.h"
#import "SSConfirmOrderDetailVC.h"
#import "ChinaPlckerView.h"
#import "SSOrderListModel.h"
#import "SSPayOrderVC.h"
#import "SSConfirmBookViewModel.h"
#import "UITextField+Extension.h"

@interface SSConfirmBookVC ()<UITextFieldDelegate>

@property(nonatomic, strong) SSOrderFooterView *bookView;
@property(nonatomic, strong) SSOrderListModel *orderModel;
@property(nonatomic, strong) SSConfirmBookViewModel *viewModel;

@end

@implementation SSConfirmBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.info_view.layer.cornerRadius = 5;
    self.info_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.info_view.userInteractionEnabled=YES;
    self.info_view.layer.shadowOpacity=0.15;
    [self.info_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.info_view.bounds] CGPath]];
    self.info_view.layer.shadowRadius = 5.0;//半径
    self.info_view.layer.shadowOffset = CGSizeMake(5, 5);
    self.info_view.clipsToBounds = NO;
    
    [self.home_bg_imageview sd_setImageWithURL:[NSURL URLWithString:@"https://api.shosen.cn/wx/images/reservation/banner.png"] placeholderImage:[UIImage imageNamed:@"home_confirm_bg"]];
    
    self.orderModel.invitorUserPhone = @"";
     [self.name_textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phone_textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.phone_textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.phone_textfield.delegate = self;
    self.invitation_textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.invitation_textfield.delegate = self;
    [self.invitation_textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self setTitle:@"确认预订"];
    [self.view addSubview:self.bookView];
    self.orderModel = [[SSOrderListModel alloc]init];
    self.orderModel.bookMoney = @"250000";
    self.viewModel  = [[SSConfirmBookViewModel alloc]init];
    self.service_label.attributedText = [NSMutableAttributedString attributeStringWithFont1:[UIFont systemFontOfSize:14] color1:kColor(@"666666") Font2:[UIFont systemFontOfSize:14] color2:kColor(@"D6B35B") text1:@"我已阅读并同意" text2:@"《认购书通用条款》"];
//    SSAccount *account = [SSAccountTool share].account;
//    if (account.invitorPhone.length > 1) {
//        self.invator_view.hidden = NO;
//        self.invatorPhoneview_height_layout.constant = 50;
//        self.infoview_height_layout.constant = 294;
//        self.invitation_textfield.text = account.invitorPhone;
//    }else{
//        self.invator_view.hidden = YES;
//        self.invatorPhoneview_height_layout.constant = 0;
//        self.infoview_height_layout.constant = 244;
//    }

 }

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.bookView.frame = CGRectMake(0, kheight - kTopHeight -  55, kwidth, 55);
}
- (IBAction)selectButtonTapAction:(UIButton *)sender {
    [ChinaPlckerView customChinaPicker:self superView:self.view];
}

- (void)chinaPlckerViewDelegateChinaModel:(ChinaArea *)chinaModel{
    self.orderModel.province = chinaModel.provinceModel.NAME;
    self.orderModel.city = chinaModel.cityModel.NAME;
    self.loction_textfield.text = [NSString stringWithFormat:@"%@-%@",self.orderModel.province,self.orderModel.city];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _phone_textfield || textField == _invitation_textfield)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    return YES;
}

-(void) textFieldDidChange:(UITextField *)textField
{
    if (textField == self.name_textfield){
        [textField validateTextFieldTextLengh:20];
    }else if (textField == self.phone_textfield || textField == self.invitation_textfield){
        [textField validateTextFieldTextLengh:11];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }

- (SSOrderFooterView *)bookView
{
    if (_bookView == nil) {
        WEAKSELF
        _bookView = [[NSBundle mainBundle]loadNibNamed:@"SSOrderFooterView" owner:self options:nil].lastObject;
        [_bookView initWithViewWithType:OrderFooterViewTypeBook operateType:0];
        _bookView.block = ^(OrderFooterOperateType type) {
            weakSelf.orderModel.bookUserName = weakSelf.name_textfield.text;
            weakSelf.orderModel.bookUserPhone = weakSelf.phone_textfield.text;
            weakSelf.orderModel.invitorUserPhone = weakSelf.invitation_textfield.text;
            if (weakSelf.orderModel.province.length < 1) {
                [ProgressHUD showSuccess:@"请选择地区"];
                return ;
            }else if (weakSelf.orderModel.bookUserName.length < 1)
            {
                [ProgressHUD showSuccess:@"请填写预订人姓名"];
                return ;
            }
//            else if (weakSelf.orderModel.bookUserPhone.length < 1)
//            {
//                [ProgressHUD showSuccess:@"请填写预订人电话"];
//                return ;
//            }
            else if (![weakSelf.orderModel.bookUserPhone validatePhone]){
                [ProgressHUD showSuccess:@"手机号不合法"];
                return ;
            }
//            SSAccount *account = [SSAccountTool share].account;
            [weakSelf.viewModel userBookOrderWithContactPhone:weakSelf.orderModel.bookUserPhone invatationPhone:weakSelf.orderModel.invitorUserPhone  bookMoney:weakSelf.orderModel.bookMoney bookProvince:weakSelf.orderModel.province bookCity:weakSelf.orderModel.city bookUsername:weakSelf.orderModel.bookUserName callBack:^(id obj) {
                SSPayOrderVC *bookVC = [[SSPayOrderVC alloc]init];
                bookVC.bookID = obj[@"data"][@"id"];
                bookVC.viewType = SSPayOrderVCTypeCar;
                [weakSelf.navigationController pushViewController:bookVC animated:YES];
            }];
        };
     }
    return _bookView;
}
- (IBAction)confirmBookButtonTapAction:(UIButton *)sender {
    FZWebViewController *webVC = [[FZWebViewController alloc]init];
    webVC.title = @"认购书通用条款";
//    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_back"]];
//    webVC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:image];
    webVC.loadUrl = @"https://api.shosen.cn/news/note.html";
    [[FZRouteUrlTool share].getCurrentVC.navigationController pushViewController:webVC animated:YES];
    
}

@end
