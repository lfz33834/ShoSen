//
//  SSMineHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineHeaderView.h"
#import "UIFont+Extension.h"
#import "CCZTrotingLabel.h"


@interface SSMineHeaderView()

@property (nonatomic, strong) CCZTrotingLabel *trotView;

@end

@implementation SSMineHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.header_imageview.layer.cornerRadius = 43/2;
    self.header_imageview.clipsToBounds = YES;
    
    self.header_view.layer.cornerRadius = 5;
    self.header_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.header_view.userInteractionEnabled=YES;
    self.header_view.layer.shadowOpacity=0.15;
    [self.header_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.header_view.bounds] CGPath]];
    self.header_view.layer.shadowRadius = 5.0;//半径
    self.header_view.layer.shadowOffset = CGSizeMake(5, 5);
    
    CCZTrotingLabel *label = [[CCZTrotingLabel alloc] init];
    label.frame = CGRectMake(0, 20, kheight - 30, 20);
        label.rate = CCZTrotingRateNormal;
    label.direction = CCZTrotDirectionTop;
    [self.headerLove_view addSubview:label];
    self.trotView = label;
    label.repeatTextArr = YES;
    label.currentLabel.font = [UIFont systemFontOfSize:13];
    label.hideWhenStopTroting = YES;
    label.pause = 4;
     // 添加滚动文本
    [label addTextArray:@[@"2019-2-11 会员 迈凯思 向慈善机构捐赠1000元",@"2019-2-12 会员 迈凯思 向慈善机构捐赠1000元",@"2019-2-13 会员 迈凯思 向慈善机构捐赠1000元",@"2019-2-14 会员 迈凯思 向慈善机构捐赠1000元"]];
    
    self.detail_button.layer.cornerRadius = 10.5;
    self.level_button.layer.cornerRadius = 10;
    self.level_button.layer.borderColor = kColor(@"D6B45E").CGColor;
    self.level_button.layer.borderWidth = 1;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGesture addTarget:self action:@selector(gestureTapAction)];
    [self.header_view addGestureRecognizer:tapGesture];
    
    
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        self.level_button.hidden = NO;
        self.title_label.text = account.name;
        self.nickname_label.text = account.sign;
        [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:account.headimg] placeholderImage:[UIImage imageNamed:@"mine_header_normal"]];
        [self.level_button setTitle:account.title forState:UIControlStateNormal];
        if ([account.orderNum intValue] > 0) {
            
            self.detail_button.hidden = YES;
            self.imageView_two.image = [UIImage imageNamed:@"mine_partner_add"];
            self.header_label.attributedText = [NSMutableAttributedString attributeStringWithFont1:[UIFont systemFontOfSize:14] color1:kColor(@"ffffff") Font2:[UIFont systemFontOfSize:15] color2:kColor(@"D6B35B") Font3:[UIFont systemFontOfSize:14] color3:kColor(@"ffffff") text1:@"恭喜你成为第" text2:account.orderNum text3:@"位超级合伙人"];
        }else{
            
//            self.detail_button.hidden = NO;
            self.imageView_two.image = [UIImage imageNamed:@"mine_partner_normal"];
            NSString *remainNum = [[NSUserDefaults standardUserDefaults]objectForKey:KConfigRemainNumKey];
            self.imageView_two.image = [UIImage imageNamed:@"mine_partner_normal"];
            self.header_label.attributedText = [NSMutableAttributedString attributeStringWithFont1:[UIFont systemFontOfSize:14] color1:kColor(@"ffffff") Font2:[UIFont systemFontOfSize:15] color2:kColor(@"D6B35B") Font3:[UIFont systemFontOfSize:14] color3:kColor(@"ffffff") text1:@"社区合伙人剩余" text2:remainNum?remainNum:@"0" text3:@"个席位"];
            UITapGestureRecognizer *headerGesture = [[UITapGestureRecognizer alloc]init];
            [headerGesture addTarget:self action:@selector(headerDetailTapAction)];
            //        [self.headerDetail_view addGestureRecognizer:headerGesture];
            [self.detail_button addTarget:self action:@selector(headerDetailTapAction) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    }else{
        
        self.level_button.hidden = YES;
        self.title_label.text = @"未登录";
        self.nickname_label.text = @"";
        self.header_imageview.image = [UIImage imageNamed:@"mine_header_normal"];
        [self.level_button setTitle:@"" forState:UIControlStateNormal];
//        self.detail_button.hidden = NO;
        NSString *remainNum = [[NSUserDefaults standardUserDefaults]objectForKey:KConfigRemainNumKey];


        self.imageView_two.image = [UIImage imageNamed:@"mine_partner_normal"];
        self.header_label.attributedText = [NSMutableAttributedString attributeStringWithFont1:[UIFont systemFontOfSize:14] color1:kColor(@"ffffff") Font2:[UIFont systemFontOfSize:15] color2:kColor(@"D6B35B") Font3:[UIFont systemFontOfSize:14] color3:kColor(@"ffffff") text1:@"社区合伙人剩余" text2:remainNum?remainNum:@"0" text3:@"个席位"];
        UITapGestureRecognizer *headerGesture = [[UITapGestureRecognizer alloc]init];
        [headerGesture addTarget:self action:@selector(headerDetailTapAction)];
        //        [self.headerDetail_view addGestureRecognizer:headerGesture];
        [self.detail_button addTarget:self action:@selector(headerDetailTapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
   
}

- (void)updateUserInfo
{
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        self.level_button.hidden = NO;
        self.title_label.text = account.name;
        self.nickname_label.text = account.sign;
        [self.level_button setTitle:account.title forState:UIControlStateNormal];
        [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:account.headimg] placeholderImage:[UIImage imageNamed:@"mine_header_normal"]];
        
        
        if ([account.orderNum intValue] > 0) {
            self.detail_button.hidden = YES;
            self.imageView_two.image = [UIImage imageNamed:@"mine_partner_add"];
            self.header_label.attributedText = [NSMutableAttributedString attributeStringWithFont1:[UIFont systemFontOfSize:14] color1:kColor(@"ffffff") Font2:[UIFont systemFontOfSize:15] color2:kColor(@"D6B35B") Font3:[UIFont systemFontOfSize:14] color3:kColor(@"ffffff") text1:@"恭喜你成为第" text2:account.orderNum text3:@"位超级合伙人"];
        }else{

            NSString *remainNum = [[NSUserDefaults standardUserDefaults]objectForKey:KConfigRemainNumKey];
            self.imageView_two.image = [UIImage imageNamed:@"mine_partner_normal"];
            self.header_label.attributedText = [NSMutableAttributedString attributeStringWithFont1:[UIFont systemFontOfSize:14] color1:kColor(@"ffffff") Font2:[UIFont systemFontOfSize:15] color2:kColor(@"D6B35B") Font3:[UIFont systemFontOfSize:14] color3:kColor(@"ffffff") text1:@"社区合伙人剩余" text2:remainNum?remainNum:@"0" text3:@"个席位"];
            UITapGestureRecognizer *headerGesture = [[UITapGestureRecognizer alloc]init];
            [headerGesture addTarget:self action:@selector(headerDetailTapAction)];
            //        [self.headerDetail_view addGestureRecognizer:headerGesture];
            [self.detail_button addTarget:self action:@selector(headerDetailTapAction) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }else{
        
        self.level_button.hidden = YES;
        self.title_label.text = @"未登录";
        self.nickname_label.text = @"";
        [self.level_button setTitle:@"" forState:UIControlStateNormal];

        self.header_imageview.image = [UIImage imageNamed:@"mine_header_normal"];
        
        self.imageView_two.image = [UIImage imageNamed:@"mine_partner_normal"];

        NSString *remainNum = [[NSUserDefaults standardUserDefaults]objectForKey:KConfigRemainNumKey];

//        self.detail_button.hidden = NO;
        self.header_label.attributedText = [NSMutableAttributedString attributeStringWithFont1:[UIFont systemFontOfSize:14] color1:kColor(@"ffffff") Font2:[UIFont systemFontOfSize:15] color2:kColor(@"D6B35B") Font3:[UIFont systemFontOfSize:14] color3:kColor(@"ffffff") text1:@"社区合伙人剩余" text2:remainNum?remainNum:@"0" text3:@"个席位"];
        UITapGestureRecognizer *headerGesture = [[UITapGestureRecognizer alloc]init];
        [headerGesture addTarget:self action:@selector(headerDetailTapAction)];
        //        [self.headerDetail_view addGestureRecognizer:headerGesture];
        [self.detail_button addTarget:self action:@selector(headerDetailTapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    

}
- (IBAction)levelButtonTapAction:(UIButton *)sender {
    SSAccount *account = [SSAccountTool share].account;
    if (account) {
        self.block(MineHeaderTapTypeLevel);
    }
}

- (void)headerDetailTapAction
{
    self.block(MineHeaderTapTypePartner);
}

- (void)gestureTapAction
{
    self.block(MineHeaderTapTypeUserInfo);
}

@end
