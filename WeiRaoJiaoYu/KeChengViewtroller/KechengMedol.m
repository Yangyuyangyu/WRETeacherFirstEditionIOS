//
//  KechengMedol.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/11.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "KechengMedol.h"
#import "AFHTTPSessionManager.h"
#import "SVProgressHUD.h"
@implementation KechengMedol

+(void)requsetWithKecheng:(void (^)(NSArray *))complete week:(NSString *)week
{
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/courseList?id=%@&week=%@",ShareS.uid,week];
    NSLog(@"urlstr %@",urlstr);
    AFHTTPSessionManager *manger=[[AFHTTPSessionManager alloc]init];
    [manger GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"课程表 %@",responseObject);
         
         //NSLog(@"share %@",ShareS.sharedic);
         NSArray *DataArry=[ShareS.sharedic objectForKey:@"data"];
         NSArray *DataArry1=[responseObject objectForKey:@"data"];
         //第一个
         NSDictionary *dic1=[DataArry1 objectAtIndex:0];
         NSArray *courseArry1=[dic1 objectForKey:@"course"];
         ShareS.courseArry1=courseArry1;
         
         NSDictionary *dic2=[DataArry1 objectAtIndex:1];
         NSArray *courseArry2=[dic2 objectForKey:@"course"];
         ShareS.courseArry2=courseArry2;
         
        
         NSDictionary *dic3=[DataArry1 objectAtIndex:2];
         NSArray *courseArry3=[dic3 objectForKey:@"course"];
         ShareS.courseArry3=courseArry3;
         
         NSDictionary *dic4=[DataArry1 objectAtIndex:3];
         NSArray *courseArry4=[dic4 objectForKey:@"course"];
         ShareS.courseArry4=courseArry4;
         
         NSDictionary *dic5=[DataArry1 objectAtIndex:4];
         NSArray *courseArry5=[dic5 objectForKey:@"course"];
         ShareS.courseArry5=courseArry5;
         
         
         NSDictionary *dic6=[DataArry1 objectAtIndex:5];
         NSArray *courseArry6=[dic6 objectForKey:@"course"];
         ShareS.courseArry6=courseArry6;
         
         NSDictionary *dic7=[DataArry1 objectAtIndex:6];
         NSArray *courseArry7=[dic7 objectForKey:@"course"];
         ShareS.courseArry7=courseArry7;
         
         ShareS.sharedic=responseObject;
         ShareS.Dtarry=DataArry;
         //NSLog(@"数组%@",DataArry);
         if (complete)
         {
             complete(DataArry1);
         }
       
         // NSLog(@"share %@",ShareS.sharedic);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
     }];

    
}
+ (void)QianDaoRequestClassid:(NSString *)class_id Lng:(NSString *)lng Lat:(NSString *)lat
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/signUp";
    NSDictionary *dic=@{@"class_id":class_id,@"lng":lng,@"lat":lat};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"签到的结果%@",responseObject);
        
        [SVProgressHUD showSuccessWithStatus:@"签到成功"];
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"KaiShiShangKe" object:nil];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)KaiShiShangKeRequestStatus:(NSString *)ststus Cid:(NSString *)cid
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/courseState";
    NSDictionary *dic=@{@"status":ststus,@"cid":cid};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"开始上课的结果%@",responseObject);
        NSString *msg=[responseObject objectForKey:@"msg"];
        
        [SVProgressHUD showSuccessWithStatus:msg];
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"KaiShiShangKeggg" object:nil];

        //[[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}
+(void)QingJiaRequestReason:(NSString *)reason Remark:(NSString *)remark ID:(NSString *)Id Class_id:(NSString *)class_id
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/leave";
    NSDictionary *dic=@{@"reason":reason,@"remark":remark,@"id":Id,@"class_id":class_id};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请假的结果%@",responseObject);
        NSString *msg=[responseObject objectForKey:@"msg"];
        [SVProgressHUD showSuccessWithStatus:msg];
        
        
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"KaiShiShangKe" object:nil];
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)DaikeRequestReason:(NSString *)reason Account:(NSString *)account Pass:(NSString *)pass Remark: (NSString *)remark Cid:(NSString *)cid ID:(NSString *)Id Tid:(NSString *)tid;
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/replace";
    NSDictionary *dic=@{@"reason":reason,@"account":account,@"pass":pass,@"remark":remark,@"cid":cid,@"id":Id,@"tid":tid};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"代课的结果%@",responseObject);
        NSString *msg=[responseObject objectForKey:@"msg"];
        [SVProgressHUD showSuccessWithStatus:msg];
        
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"KaiShiShangKelou" object:nil];
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)AllstudentRequest:(NSString *)Id
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/rollCall";
    NSDictionary *dic=@{@"id":Id};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"全部学生的结果%@",responseObject);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AllstudentRequest" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)BuDianMingRequest:(NSString *)Id
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/recall";
    NSDictionary *dic=@{@"id":Id};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"全部学生的结果%@",responseObject);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)BaoCunStuentRequest:(NSString *)KeId Presrnt:(NSArray *)present Absent:(NSArray *)absent
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/saveCall";
    NSDictionary *dic=@{@"id":KeId,@"present":present,@"absent":absent};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"点名学生的结果%@",responseObject);
        NSString *msg=[responseObject objectForKey:@"msg"];
        [SVProgressHUD showSuccessWithStatus:msg];
        
        NSNotificationCenter * dianmingnotificationCenter = [NSNotificationCenter defaultCenter];
        [dianmingnotificationCenter postNotificationName:@"dianmin" object:nil];
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList" object:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)TiJiaoBaoGaoRequest:(NSString *)Keid Content:(NSString *)content Problem: (NSString *)problem Solution:(NSString *)solution Homwork:(NSString *)homwork Work:(NSString *)work Img:(NSString *)img
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/report";
    NSDictionary *dic=@{@"id":Keid,@"content":content,@"problem":problem,@"solution":solution,@"homework":homwork,@"work":work,@"img":img};
    
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"提交课程的结果%@",responseObject);
        NSString *msg=[responseObject objectForKey:@"msg"];
        [SVProgressHUD showSuccessWithStatus:msg];
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"KaiShiShangKe" object:nil];
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)requsetWithjiaru:(void (^)(NSArray * responseArr))complete
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/joinedGroup?id=%@",ShareS.uid];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *DataArry=[responseObject objectForKey:@"data"];
        NSLog(@"加入机构%@",responseObject);
        if (complete) {
            
            complete(DataArry);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)SeacherJigouRequest:(NSString *)type Name:(NSString *)name
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/agency?type=%@&name=%@",type,name];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"搜索机构%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)JigouXiangQRequest:(NSString *)agencyId Tid:(NSString *)tid
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/agencyDetail?agencyId=%@&tid=%@",agencyId,tid];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList222" object:nil userInfo:responseObject];
        NSLog(@"机构详情%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)requsetWithShenTuan:(void (^)(NSArray * responseArr))complete
{
   NSString *Id= [[NSUserDefaults standardUserDefaults]objectForKey:@"agencyid"];
     //NSString *Id=[NSString stringWithFormat:@"%d",ShareS.JiGouDetaildataMedol.HdID];
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/groupOfAgency?id=%@",Id];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *msg=[responseObject objectForKey:@"msg"];
        [SVProgressHUD showInfoWithStatus:msg];
        NSLog(@"机构下社团%@",responseObject);
        NSArray *DataArry=[responseObject objectForKey:@"data"];
        if (complete)
        {
            complete(DataArry);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)ShenQingJiaruRequest:(NSString *)agencyId ID:(NSString *)Id
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/join?agencyId=%@&id=%@",agencyId,Id];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"申请加入社团%@",responseObject);
         [[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList111" object:nil userInfo:responseObject];
        NSString *msg=[responseObject objectForKey:@"msg"];
         [SVProgressHUD showSuccessWithStatus:msg];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)requsetWithSheTuanDetail:(void (^)(NSDictionary * responseDic))complete
{
    NSString *groupId=[[NSUserDefaults standardUserDefaults]objectForKey:@"GroupId"];
    NSLog(@"%@",groupId);
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/groupDetail?&groupId=%@",groupId];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"社团详情%@",responseObject);
        if (complete)
        {
            complete(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)requsetWithSheTuanguanli:(void (^)(NSDictionary * responseDic))complete
{
    NSString *groupId=[[NSUserDefaults standardUserDefaults]objectForKey:@"GroupId"];
    NSLog(@"%@",groupId);
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/groupRule?&groupId=%@",groupId];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"社团管理%@",responseObject);
        if (complete)
        {
            complete(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)requsetWithSheTuanJianShe:(void (^)(NSDictionary * responseDic))complete
{
    
    NSString *groupId=[[NSUserDefaults standardUserDefaults]objectForKey:@"GroupId"];
    
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/groupBuild?&groupId=%@",groupId];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"社团建设%@",responseObject);
        if (complete)
        {
            complete(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)requsetWithSheTuanKechengGuiHua:(void (^)(NSDictionary * responseDic))complete
{
    NSString *groupId=[[NSUserDefaults standardUserDefaults]objectForKey:@"GroupId"];
    
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/coursePlan?&groupId=%@",groupId];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"社团规划%@",responseObject);
        if (complete)
        {
            complete(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)DongTaiXaingQing:(NSString *)ID
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/newsDetail?&id=%@",ID];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"动态详情%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
+(void)JiaoyuJIngli:(NSString *)content Uid:(NSString *)uid
{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/editEdu";
    NSDictionary *dic=@{@"content":content,@"id":uid};
    [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"教育经历的结果%@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"kkkk" object:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)ZhuYeKecengUid:(NSString *)uid
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/course?&id=%@",uid];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"老师课程%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)LishiKecheng:(NSString *)uid
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/finishedClass?&id=%@",uid];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"历史课程%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)SeacherTuiJIan:(NSString *)type Page:(NSString *)page
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/agency?&type=%@&page=%@",type,page];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"搜索推荐%@",responseObject);
         NSString *msgstr=[responseObject objectForKey:@"msg"];
        alertview111=[[UIAlertView alloc]initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [alertview111 show];

       [[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList" object:nil userInfo:responseObject];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)SeacherTuiJIan1:(NSString *)type Page:(NSString *)page
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/agency?&type=%@&page=%@",type,page];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"搜索推荐%@",responseObject);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList1" object:nil userInfo:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
+(void)Seacher:(NSString *)type Name:(NSString*)name Page:(NSString *)page
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/agency?&type=%@&name=%@&page=%@",type,name,page];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList1" object:nil userInfo:responseObject];
        NSLog(@"搜索结果%@",responseObject);
        NSString *msg=[responseObject objectForKey:@"msg"];
         [SVProgressHUD showSuccessWithStatus:msg];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
+(void)KechengDeTail:(NSString *)cid
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/courseInfo?id=%@",cid];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"modificationinfoList1" object:nil userInfo:responseObject];
        NSLog(@"课程详情结果%@",responseObject);
        NSString *msg=[responseObject objectForKey:@"msg"];
        [SVProgressHUD showSuccessWithStatus:msg];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//- (void)dismissqQ
//{
//    [SVProgressHUD dismiss];
//}
- (NSDictionary *)deleteAllNullValue:(NSDictionary *)dic
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in dic.allKeys) {
        if ([[dic  objectForKey:keyStr] isEqual:[NSNull null]]) {
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            [mutableDic setObject:[dic objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}
//-(NSArray *)deleteAllNullValue1:(NSArray *)arry
//{
//    NSMutableArray *muArry=[[NSMutableArray alloc]init];
//    for (int i=0; i<arry.count; i++)
//    {
//        if ([[arry objectAtIndex:i] isEqual:[NSNull null]])
//        {
//            [arry objectAtIndex:i];
//            
//        }
//    }
//}
-(void)performDismiss:(NSTimer*)timer

{
    
    [alertview111 dismissWithClickedButtonIndex:0 animated:NO];
    
}
@end
