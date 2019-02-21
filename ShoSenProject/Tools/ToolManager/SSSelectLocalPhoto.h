//
//  SSSelectLocalPhoto.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/28.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSSelectLocalPhoto : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**
 *  选择本地照片的回调属性
 *
 *  @param filePath 本地照片的路径
 *  @param getImg   image照片
 */
typedef void(^getLocalPhotoBlock)(NSString * filePath, UIImage *headImg);
/**
 *  本地照片的block回调
 */
@property(nonatomic,copy)getLocalPhotoBlock block;
/**
 *  选择本地照片上传的方法
 *
 *  @param uploadWay 选择方式
 *  @param tragetVC  目标VC
 */
- (void)selectLocalPhotoWithWay:(NSString *)uploadWay targetVC:(UIViewController *)tragetVC;

@end
