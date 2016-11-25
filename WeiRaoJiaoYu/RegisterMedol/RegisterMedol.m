//
//  RegisterMedol.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/29.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "RegisterMedol.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@implementation RegisterMedol
- (void)obtainInfoList:(NSString *)MObile UserPwd:(NSString *)userPwd Code:(NSString *)code{
    NSString *logid=[[NSUserDefaults standardUserDefaults]objectForKey:@"log_id"];
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
        NSString *urlstr=@"http:www.weiraoedu.com/Api/TeacherApi/register";
    NSDictionary *dic=@{@"mobile":MObile,@"pass":userPwd,@"code":code,@"log_id":logid};
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"注册正确的接口  %@",responseObject);
        NSString *msgstr=[responseObject objectForKey:@"msg"];
        [SVProgressHUD showWithStatus:msgstr maskType:SVProgressHUDMaskTypeClear];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
          NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        [mutDic setObject:responseObject[@"code"] forKey:@"code"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reginfoList" object:nil userInfo:mutDic];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    }
- (void)obtainInfoList1:(NSString *)MObile1 UserPwd1:(NSString *)userPwd1 Code1:(NSString *)code1
{
    NSString *logid=[[NSUserDefaults standardUserDefaults]objectForKey:@"log_id"];
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/editPwd";
    NSDictionary *dic=@{@"mobile":MObile1,@"pass":userPwd1,@"code":code1,@"log_id":logid};
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"找回密码的接口  %@",responseObject);
        NSString *msgstr=[responseObject objectForKey:@"msg"];
        [SVProgressHUD showWithStatus:msgstr maskType:SVProgressHUDMaskTypeClear];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        [mutDic setObject:responseObject[@"code"] forKey:@"code"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reginfoList" object:nil userInfo:mutDic];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)dismiss
{
    [SVProgressHUD dismiss];
    NSLog(@"ssss");
}
@end
