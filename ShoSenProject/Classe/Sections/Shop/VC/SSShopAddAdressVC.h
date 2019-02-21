//
//  SSShopAddAdressVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "SSLocationModel.h"

typedef NS_ENUM(NSInteger, SSShopAddAdressVCType)
{
    SSShopAddAdressVCTypeAdd,
    SSShopAddAdressVCTypeEdit,
};

typedef void(^SSShopAddAdressVCBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SSShopAddAdressVC : FZBaseViewController

@property (nonatomic, assign) SSShopAddAdressVCType vcType;
@property (nonatomic, strong) SSLocationModel *locationModel;
@property (weak, nonatomic) IBOutlet UITextField *name_textfield;
@property (weak, nonatomic) IBOutlet UITextField *phone_textfield;
@property (weak, nonatomic) IBOutlet UITextField *location_textfield;
@property (weak, nonatomic) IBOutlet UITextField *detail_textfield;
@property (weak, nonatomic) IBOutlet UIButton *default_button;
@property (weak, nonatomic) IBOutlet UIButton *delete_button;

@property (nonatomic, copy) SSShopAddAdressVCBlock block;

@end

NS_ASSUME_NONNULL_END
