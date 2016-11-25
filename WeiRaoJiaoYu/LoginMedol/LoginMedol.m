//
//  LoginMedol.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/29.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "LoginMedol.h"
#import "SVProgressHUD.h"
@implementation LoginMedol
- (void)obtainInfoList:(NSString *)userName userPwd:(NSString *)userPwd  {
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
   // NSString *urlstr=[NSString stringWithFormat:@"http://192.168.10.143/operate/Api/TeacherApi/login"];
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/login";
    NSDictionary *dic = @{@"mobile":userName,@"pass":userPwd};
    NSLog(@"mobile %@",userName);
    NSLog(@"pass %@",userPwd);
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"登录%@",responseObject);

        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"responseObject"];
        NSString *msgstr=[responseObject objectForKey:@"msg"];
//        [SVProgressHUD showWithStatus:msgstr maskType:SVProgressHUDMaskTypeClear];
//        [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
        //[SVProgressHUD showErrorWithStatus:msgstr maskType:SVProgressHUDMaskTypeClear];
        
       alertview=[[UIAlertView alloc]initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
           [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [alertview show];
        
        NSString *code=[responseObject objectForKey:@"code"];
        
        NSLog(@"code %@",code);
        if ([code intValue]==0)
        {
            
            NSDictionary *dataDic=[responseObject objectForKey:@"data"];
            DataReauest *datamedol=[[DataReauest alloc]initWithDictiory:dataDic];
            ShareS.DataMedol=datamedol;
            NSLog(@"datamedol %d",datamedol.edu);
            NSLog(@"datamedol1 %d",ShareS.DataMedol.edu);
            NSString *name=[dataDic objectForKey:@"name"];
            NSString *headimg=[dataDic objectForKey:@"head"];
            NSString *uid=[dataDic objectForKey:@"id"];
            NSString *phone=[dataDic objectForKey:@"phone"];
            NSString *sex=[dataDic objectForKey:@"sex"];
            NSString *birthday=[dataDic objectForKey:@"birthday"];
            ShareS.sex=sex;
            ShareS.name=name;
            ShareS.headImgUrl=headimg;
            [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uId"];
            ShareS.uid=uid;
            ShareS.phone=phone;
            ShareS.birthday=birthday;
            NSLog(@"  %@, %@,%@,%@",ShareS.sex,ShareS.name,ShareS.headImgUrl,ShareS.uid);
            
            NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
            [mutDic setObject:responseObject[@"data"] forKey:@"uId"];
            [mutDic setObject:responseObject[@"code"] forKey:@"code"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logininfoList" object:nil userInfo:mutDic];

        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)performDismiss:(NSTimer*)timer

{
    
    [alertview dismissWithClickedButtonIndex:0 animated:NO];
    
}
//- (void)dismiss
//{
//    [SVProgressHUD dismiss];
//    NSLog(@"ssss");
//}
@end
