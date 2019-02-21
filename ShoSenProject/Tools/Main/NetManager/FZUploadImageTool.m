//
//  FZUploadImageTool.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/31.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZUploadImageTool.h"
#import "AFNetworking.h"
#import "HXPhotoModel.h"

static AFHTTPSessionManager *manager;

@implementation FZUploadImageTool

////为了防止内存泄露
//+ (AFHTTPSessionManager *)share
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer.timeoutInterval = 10;
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
//    });
//    return manager;
//}

#pragma mark 上传单张图片
+ (void)uploadImageWithPath:(NSString *)path image:(UIImage *)image params:(NSDictionary *)params success:(HttpUploadSuccessBlock)success failure:(HttpUploadFailureBlock)failure
{
    NSArray *array = [NSArray arrayWithObject:image];
    [self uploadImageWithPath:path photos:array params:params success:success failure:failure];
}

#pragma mark 上传图片
+ (void)uploadImageWithPath:(NSString *)path photos:(NSArray *)photos params:(NSDictionary *)params success:(HttpUploadSuccessBlock)success failure:(HttpUploadFailureBlock)failure
{
    [ProgressHUD showSuccess:@"正在上传,请稍等."];
    NSMutableDictionary *dicData;
    dicData = [self getRequestParam];
//    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [FZUploadImageTool getAFHTTPRequestOperationManager];
    [manager POST:path parameters:dicData constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < photos.count; i ++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.png",str];
            HXPhotoModel *model = photos[i];
            UIImage *image;
            if (model.previewPhoto) {
                 image = model.previewPhoto;
            }else {
                 image = model.thumbPhoto;
            }
            NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
//            UIImagePNGRepresentation(image);

            [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress is %lld,总字节 is %lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        NSString *resultInfo = [responseObject objectForKey:@"data"];
        NSLog(@"resultInfo is %@",resultInfo);
        if ([resultCode isEqualToString:@"100"]) {
            [ProgressHUD showSuccess:@"上传成功"];
            if (success == nil) return ;
            success(responseObject);
        }else {
            [ProgressHUD showSuccess:@"上传失败"];
            if (failure == nil) return ;
            failure();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"上传失败"];
        if (failure == nil) return ;
        failure();
    }];
}

+ (NSMutableDictionary *)getRequestParam
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    SSAccount *account = [SSAccountTool share].account;
    //    @"ddbfefb471384bfeb4abefca93d4dfa8"
    NSDictionary *userDic = @{@"securityToken":account.token,@"uid":account.uid};
    params[@"user"] = userDic;
    return params;
}

+ (AFHTTPSessionManager *)getAFHTTPRequestOperationManager
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 20;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/javascript",@"text/html",nil];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    return manager;
}

@end
