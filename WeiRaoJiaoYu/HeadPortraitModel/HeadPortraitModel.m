//
//  HeadPortraitModel.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/10.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "HeadPortraitModel.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@implementation HeadPortraitModel
- (void)headPortraitInfoList:(NSData *)pic{
    //NSLog(@"imgfile %@",pic);
     //NSString *dataString=[[NSString alloc]initWithData:pic encoding:NSUTF8StringEncoding];
            //NSLog(@"datastring %@",dataString);
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    //session.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlstr=@"http://www.weiraoedu.com/Api/CommonApi/imgUpload";
   
     NSDictionary *dic = @{@"pic":pic};
    [session POST:urlstr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:[NSDate date]]];
        NSLog(@"%@",fileName);
       
        [formData appendPartWithFileData:pic name:@"pic" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);//进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        [[NSNotificationCenter defaultCenter] postNotificationName:@"headPortraitInfoList" object:nil userInfo:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)xiugaiziliaoInfolist:(NSString *)headimg Name:(NSString *)name Sex:(NSString *)sex Birthday:(NSString *)birthday aId:(NSString *)Id
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
       NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/editInfo";
    NSDictionary *dic=@{@"head_img":headimg,@"name":name,@"sex":sex,@"birthday":birthday,@"id":Id};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"修改信息的结果%@",responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"xiugaiziliaoInfolist" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}
//字典转json格式字符串：
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//把nsstring转化成jsonStr
+ (NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}


@end
