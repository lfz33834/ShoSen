//
//  SSSelectLocalPhoto.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/28.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSSelectLocalPhoto.h"

@implementation SSSelectLocalPhoto

- (void)selectLocalPhotoWithWay:(NSString *)uploadWay targetVC:(UIViewController *)tragetVC
{
    if ([uploadWay isEqualToString:@"拍照"]) {
//        [self openTakePhoto:tragetVC];
    }else{
        [self openLocalPhoto:tragetVC];
    }
}
- (void)openTakePhoto:(UIViewController *)tragetVC
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [tragetVC presentViewController:picker animated:YES completion:nil];
    }else
    {
        [ProgressHUD showError:@"此设备不支持拍照"];
    }
}
- (void)openLocalPhoto:(UIViewController *)tragetVC
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [tragetVC presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerController delegate -
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"])
    {
        weak_Self(self);
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (self.block) {
            self.block(@"", image);
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data;
            if (UIImagePNGRepresentation(image) == nil)
            {
                data = UIImageJPEGRepresentation(image, 0.1);
            }
            else
            {
                data = UIImageJPEGRepresentation(image, 0.1);
            }
            NSString *pathStr= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];

            NSString * lcoalPath = [[NSString alloc]initWithFormat:@"%@%@",pathStr,@"/perIcon.png"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
             BOOL state =  [data writeToFile:lcoalPath atomically:YES];
             if (state) {
                
            }
  
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.block) {
                    weakSelf.block(lcoalPath,image);
                }
            });
        });
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
