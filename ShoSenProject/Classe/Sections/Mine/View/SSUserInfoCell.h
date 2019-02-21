//
//  SSUserInfoCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/25.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

typedef NS_ENUM(NSInteger, UserInfoTapType)
{
    UserInfoTapTypeLocation,
    UserInfoTapTypeStatus,
    UserInfoTapTypeHeaderImage,
    UserInfoTapTypeFinish,
};

typedef void(^SSUserInfoCellBlock)(UserInfoTapType type);

#import <UIKit/UIKit.h>

@interface SSUserInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UITextField *nickname_textfield;
@property (weak, nonatomic) IBOutlet UITextField *content_textfield;
@property (weak, nonatomic) IBOutlet UIButton *man_button;
@property (weak, nonatomic) IBOutlet UIButton *women_button;
@property (weak, nonatomic) IBOutlet UILabel *status_label;
@property (weak, nonatomic) IBOutlet UIButton *status_button;
@property (weak, nonatomic) IBOutlet UIButton *location_button;
@property (weak, nonatomic) IBOutlet UICollectionView *flags_collection;
@property (weak, nonatomic) IBOutlet UIButton *finish_button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collection_height;
@property (nonatomic, assign) NSInteger selectNum;
@property (nonatomic, assign) NSInteger selectSex;


@property (nonatomic, copy) SSUserInfoCellBlock block;
@property (nonatomic, strong) NSMutableArray *flagsArray;

@end

