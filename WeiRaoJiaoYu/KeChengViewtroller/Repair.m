//
//  Repair.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/6/27.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "Repair.h"
#import "NetworkingManager.h"
#import "AFNetworking.h"

@implementation Repair

- (void)recallInfoList:(NSString *)recordId{
    NSString *urlstr=[NSString stringWithFormat:@"%@/Api/TeacherApi/recall?id=%@",Basicurl,recordId];
    [NetworkingManager sendGetRequestWithURL:urlstr parametesDic:nil successBlock:^(id object) {
        NSLog(@"补点名时查询未到学生%@",object);
        NSLog(@"%@",object[@"msg"]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recallInfoList" object:nil userInfo:object];
    } failureBlock:^(id object) {
        NSLog(@"补点名时查询未到学生失败%@",object);
    }];
}

- (void)signUpInfoList:(NSString *)class_id lng:(NSString *)lng lat:(NSString *)lat location:(NSString *)location{
    NSString *urlstr=[NSString stringWithFormat:@"%@/Api/TeacherApi/signUp",Basicurl];
    NSString *unique_code = [[NSUserDefaults standardUserDefaults] objectForKey:@"unique_code"];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm"];
    NSString *time = [dateFormatter stringFromDate:currentDate];
    
    NSDictionary *dic = @{@"class_id":class_id,@"lng":lng,@"lat":lat,@"location":location,@"unique_code":unique_code,@"time":time};
    [NetworkingManager sendPOSTRequesWithURL:urlstr parameters:dic successBlock:^(id object) {
        NSLog(@"签到成功%@",object);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"signUpInfoList" object:nil userInfo:object];
    } failureBlock:^(id object) {
        NSLog(@"签到失败%@",object);
    }];
}

- (void)infoInfoList{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uId"];
    NSString *urlstr=[NSString stringWithFormat:@"%@/Api/TeacherApi/info?id=%@",Basicurl,uid];
    [NetworkingManager sendGetRequestWithURL:urlstr parametesDic:nil successBlock:^(id object) {
        NSLog(@"老师主页信息接口%@",object);
        NSLog(@"%@",object[@"msg"]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"infoInfoList" object:nil userInfo:object];
    } failureBlock:^(id object) {
        NSLog(@"老师主页信息接口失败%@",object);
    }];
}

- (void)moreImgUploadInfokInfoList:(NSData *)name{
    
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlstr=[NSString stringWithFormat:@"%@/Api/CommonApi/imgUpload",Basicurl];
    NSDictionary *dic = @{@"name":name};
    [session POST:urlstr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:name name:@"pic" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);//进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"图片上传接口成功%@",responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moreImgUploadInfokInfoList" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"图片上传接口失败%@",error);
    }];
}

- (void)reportInfoList:(NSString *)content problem:(NSString *)problem solution:(NSString *)solution homework:(NSString *)homework work:(NSString *)work img:(NSString *)img{
    
    NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"TiJiaoBaoGaokid"];
    NSString *urlstr=[NSString stringWithFormat:@"%@/Api/TeacherApi/report",Basicurl];
    if (content.length == 0) {
        content = @"";
    }
    if (problem.length == 0) {
        problem = @"";
    }
    if (solution.length == 0) {
        solution = @"";
    }
    if (homework.length == 0) {
        homework = @"";
    }
    if (work.length == 0) {
        work = @"";
    }
    if (img.length == 0) {
        img = @"";
    }
    NSDictionary *dic = @{@"courseId":cid,@"content":content,@"problem":problem,@"solution":solution,@"homework":homework,@"work":work, @"img":img};
    NSLog(@"%@",dic);
    [NetworkingManager sendPOSTRequesWithURL:urlstr parameters:dic successBlock:^(id object) {
        NSLog(@"提交课程报告成功%@",object);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reportInfoList" object:nil userInfo:object];
    } failureBlock:^(id object) {
        NSLog(@"提交课程报告失败%@",object);
    }];
}
@end
