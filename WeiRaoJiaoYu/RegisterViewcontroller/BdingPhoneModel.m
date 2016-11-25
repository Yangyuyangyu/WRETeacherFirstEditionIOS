//
//  BdingPhoneModel.m
//  BanDouApp
//
//  Created by waycubeIOSb on 16/3/28.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "BdingPhoneModel.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

@implementation BdingPhoneModel

//- (void)bdingInfoList:(NSString *)uid phone:(NSString *)phone {
//    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
//    NSString *urlstr=[NSString stringWithFormat:@"%@//app/user/editPhoneSave?uid=%@&phone=%@",Baseurl,uid,phone];
//    NSLog(@"%@",urlstr);
//    [session GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//       // [[NSNotificationCenter defaultCenter] postNotificationName:@"bdingInfoList" object:nil userInfo:responseObject];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"eero:%@",error);
//    }];
//}
//获取短信验证码
- (void)verificationInfoListphone:(NSString *)phone{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/sendCode?mobile=%@",phone];
    NSLog(@"%@",urlstr);
    [session GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *logid=[responseObject objectForKey:@"log_id"];
        [[NSUserDefaults standardUserDefaults]setObject:logid forKey:@"log_id"];
        NSLog(@"log  %@",logid);
       // [[NSNotificationCenter defaultCenter] postNotificationName:@"verificationInfoList" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"eero:%@",error);
    }];
}
- (void)verificationInfoListphone1:(NSString *)phone1
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/sendFindCode?mobile=%@",phone1];
    NSLog(@"%@",urlstr);
    [session GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *logid=[responseObject objectForKey:@"log_id"];
        [[NSUserDefaults standardUserDefaults]setObject:logid forKey:@"log_id"];
        NSLog(@"log  %@",logid);
        // [[NSNotificationCenter defaultCenter] postNotificationName:@"verificationInfoList" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"eero:%@",error);
    }];

}
//校验手机验证码
//- (void)verifyInfoList:(NSString *)uid code:(NSString *)code{
//    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
//    NSString *urlstr=[NSString stringWithFormat:@"%@//app/user/checkAuthCode?uid=%@&code=%@&type=1",Baseurl,uid,code];
//    NSLog(@"%@",urlstr);
//    [session GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"verifyInfoList" object:nil userInfo:responseObject];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"eero:%@",error);
//    }];
//}
@end
