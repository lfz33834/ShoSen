//
//  FZBaseViewController.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pushVCBlock)(NSInteger idx);
typedef void(^lostNetworkBlock)(void);

@interface FZBaseViewController : UIViewController

@property (nonatomic,strong) NSString * classname;
@property(nonatomic, strong)UIImageView * emptyTipImg;
@property(nonatomic, strong)UILabel * emptyTipLab;
@property(nonatomic, strong)UIButton * emptyRefresBtn;
@property(nonatomic, copy)lostNetworkBlock neteorkBlock;
@property(nonatomic, copy)pushVCBlock navBlock;


- (void)setback;
- (void)setNavBlack;
- (void)setBlackMode;
- (void)setNavBlackBack;
- (void)setLeftItemNull;
- (void)setLeftBar:(NSString *)leftStr rightBar:(NSString *)rightStr block:(pushVCBlock)block;
- (void) setTitleViewText:(NSString *)text;

@end

@interface FZTableViewController : UITableViewController
- (void)setTitleViewText:(NSString *)text;
@end

@interface FZBaseViewController (emptyPage)
- (void)emptyPage; //空页面
- (void)emptyLostNetWork;//无网络页面
@end
