//
//  KechengMedol.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/11.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KechengMedol :NSObject
{
    UIAlertView*alertview111;
}



+(void)requsetWithKecheng:(void (^)(NSArray *))complete week:(NSString *)week;
//签到
+(void)QianDaoRequestClassid:(NSString *)class_id Lng:(NSString *)lng Lat:(NSString *)lat;
+(void)KaiShiShangKeRequestStatus:(NSString *)ststus Cid:(NSString *)cid;
// 请假  备注是啥
+(void)QingJiaRequestReason:(NSString *)reason Remark:(NSString *)remark ID:(NSString *)Id Class_id:(NSString *)class_id;
//申请代课
+(void)DaikeRequestReason:(NSString *)reason Account:(NSString *)account Pass:(NSString *)pass Remark: (NSString *)remark Cid:(NSString *)cid ID:(NSString *)Id Tid:(NSString *)tid;
//全部学生
+ (void)AllstudentRequest: (NSString *)Id;
//补点名
+(void)BuDianMingRequest:(NSString *)Id;
//保存点名信息
+(void)BaoCunStuentRequest:(NSString *)KeId Presrnt:(NSArray *)present Absent:(NSArray *)absent;
//提交报告
+(void)TiJiaoBaoGaoRequest:(NSString *)Keid Content:(NSString *)content Problem: (NSString *)problem Solution:(NSString *)solution Homwork:(NSString *)homwork Work:(NSString *)work Img:(NSString *)img;
//老师加入的机构
+(void)requsetWithjiaru:(void (^)(NSArray * responseArr))complete;
//搜素机构
+(void)SeacherJigouRequest:(NSString *)type Name:(NSString *)name;
//机构详情
+(void)JigouXiangQRequest:(NSString *)agencyId Tid:(NSString *)tid;
//机构下的社团
+(void)requsetWithShenTuan:(void (^)(NSArray * responseArr))complete;
//申请加入机构
+(void)ShenQingJiaruRequest:(NSString *)agencyId ID:(NSString *)Id;
//社团详情
+(void)requsetWithSheTuanDetail:(void (^)(NSDictionary * responseDic))complete;
//社团管理制度
+(void)requsetWithSheTuanguanli:(void (^)(NSDictionary * responseDic))complete;
//社团建设
+(void)requsetWithSheTuanJianShe:(void (^)(NSDictionary * responseDic))complete;
//社团课程规划
+(void)requsetWithSheTuanKechengGuiHua:(void (^)(NSDictionary * responseDic))complete;
//动态详情
+(void)DongTaiXaingQing:(NSString *)ID;
//教育经历
+(void)JiaoyuJIngli:(NSString *)content Uid:(NSString *)uid;
//主页课程
+(void)ZhuYeKecengUid:(NSString *)uid;
//历史课程
+(void)LishiKecheng:(NSString *)uid;
//机构搜索  推荐数据
-(void)SeacherTuiJIan:(NSString *)type Page:(NSString *)page;
+(void)SeacherTuiJIan1:(NSString *)type Page:(NSString *)page;
//机构搜索
+(void)Seacher:(NSString *)type Name:(NSString*)name Page:(NSString *)page;
//课程详情
+(void)KechengDeTail:(NSString *)cid;
@end
