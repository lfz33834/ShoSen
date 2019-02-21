//
//  SSAccountTool.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSAccountTool.h"
#import "SSAccount.h"

#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"maxmakeraccount.data"]


@implementation SSAccountTool

+(SSAccountTool *)share{
    
    static SSAccountTool *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SSAccountTool alloc] init];
    });
    return sharedManager;
}

- (id)init
{
    if (self = [super init]) {
//        self.account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
//        NSData *resultData = [NSData dataWithContentsOfFile:kFile];
//        self.account = [NSKeyedUnarchiver unarchiveObjectWithData:resultData];
        
        [self readAccountData];
    }
    return self;
}

- (void)readAccountData
{
    NSMutableDictionary *resultData = [NSMutableDictionary dictionaryWithContentsOfFile:kFile];
    if(resultData)
    {
        self.account = [[SSAccount alloc]init];
        self.account.headimg = resultData[@"headimg"];
        self.account.name = resultData[@"name"];
        self.account.phone = resultData[@"phone"];
        self.account.sign = resultData[@"sign"];
        self.account.province = resultData[@"province"];
        self.account.city = resultData[@"city"];
        self.account.orderNum = resultData[@"orderNum"];
        self.account.remainNum = resultData[@"remainNum"];
        self.account.rewardMoney = resultData[@"rewardMoney"];
        self.account.sex = resultData[@"sex"];
        self.account.title = resultData[@"title"];
        self.account.tabs = resultData[@"tabs"];
        self.account.token = resultData[@"token"];
        self.account.uid = resultData[@"uid"];
        self.account.level = resultData[@"level"];
        self.account.contribution = resultData[@"contribution"];
        self.account.title = resultData[@"title"];
        self.account.xProperty = resultData[@"xProperty"];
        self.account.money = resultData[@"money"];
        self.account.invitorPhone = resultData[@"invitorPhone"];
        self.account.openId = resultData[@"openId"];

    }
}

- (void)saveAccountData:(NSMutableDictionary *)account
{
//    self.account = [account mj_o];
//    NSData * encodeObject = [NSKeyedArchiver archivedDataWithRootObject:account];
//    [encodeObject writeToFile:kFile atomically:YES];
    
    self.account = [[SSAccount alloc]init];
    NSMutableDictionary *resultData = [NSMutableDictionary dictionaryWithContentsOfFile:kFile];
    
    NSString *tokenString = account[@"token"];
    if(account[@"token"] == nil || [account[@"token"] isEqual:[NSNull null]] || tokenString.length == 0)
    {
        self.account.token = resultData[@"token"];
        [account setObject:resultData[@"token"] forKey:@"token"];
    }else{
        self.account.token = account[@"token"];
    }
    
    if( (account[@"level"] == nil || [account[@"level"] isEqual:[NSNull null]]) && resultData[@"level"]){
        self.account.level = resultData[@"level"];
        [account setObject:resultData[@"level"] forKey:@"level"];
    }else if(account[@"level"]){
        self.account.level = account[@"level"];
    }
    self.account.uid = account[@"uid"];
    self.account.headimg = account[@"headimg"];
    self.account.name = account[@"name"];
    self.account.phone = account[@"phone"];
    self.account.sign = account[@"sign"];
    self.account.province = account[@"province"];
    self.account.city = account[@"city"];
    
    NSString *orderNum = account[@"orderNum"];
    if(account[@"orderNum"] == nil || [account[@"orderNum"] isEqual:[NSNull null]] || orderNum.length == 0)
    {
        if(resultData[@"orderNum"]){
            self.account.orderNum = resultData[@"orderNum"];
            [account setObject:resultData[@"orderNum"] forKey:@"orderNum"];
        }
    }else{
        self.account.orderNum = account[@"orderNum"];
    }
    
//    NSString *remainNum = account[@"remainNum"];
//    if(account[@"remainNum"] == nil || [account[@"remainNum"] isEqual:[NSNull null]] || remainNum.length == 0)
//    {
//        self.account.remainNum = resultData[@"remainNum"];
//        [account setObject:resultData[@"remainNum"] forKey:@"remainNum"];
//    }else{
//        self.account.token = account[@"remainNum"];
//    }
    
    self.account.remainNum = account[@"remainNum"];
    self.account.rewardMoney = account[@"rewardMoney"];
    self.account.sex = account[@"sex"];
    self.account.title = account[@"title"];
    self.account.tabs = account[@"tabs"];
//    self.account.level = account[@"level"];
    self.account.contribution = account[@"contribution"];
    self.account.title = account[@"title"];
    self.account.xProperty = account[@"xProperty"];
    self.account.money = account[@"money"];
    self.account.invitorPhone = account[@"invitorPhone"];
    self.account.openId = account[@"openId"];



   //获取归档路路径,清空沙盒
    BOOL isSaveSuccess = [account writeToFile:kFile atomically:YES];
    if (isSaveSuccess) {
        
    }
}

- (void)saveAccount:(SSAccount *)account
{
    self.account = account;
    NSData * encodeObject = [NSKeyedArchiver archivedDataWithRootObject:account];
    [encodeObject writeToFile:kFile atomically:YES];

}
/**
 *  是否登录
 */
- (BOOL)isLogin
{
//    if (QSCLoginAccountTool.account) {
//        return YES;
//    }else{
        return NO;
//    }
}

/**
 *  退出app账户操作
 */
- (void)logoutAccount
{
//    [self unbindAccount];
//    [self removeAgent];
    
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:kFile error:nil];    //获取归档路路径,清空沙盒
    self.account = nil;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *shahePath = [pathArray objectAtIndex:0];
    NSError *error;
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:shahePath error:nil];
    for (NSString *filename in tmplist) {
        MYLog(@"沙盒文件-----%@",filename);
        if([filename rangeOfString:@"storePdf"].location !=NSNotFound || [filename rangeOfString:@"account.data"].location !=NSNotFound){
            NSString *fullpath = [shahePath stringByAppendingPathComponent:filename];
            if ([defaultManager isDeletableFileAtPath:fullpath]) {
                [defaultManager removeItemAtPath:fullpath error:&error];
            }
        }
    }
    MYLog(@"退出登录");
}




@end
