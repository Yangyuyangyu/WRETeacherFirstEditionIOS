//
//  ShareDefult.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/11.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataReauest.h"
#import "DataMedol.h"
@interface ShareDefult : NSObject
@property (nonatomic, strong)NSString *headImgUrl;//头像
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *sex;//性别
@property (nonatomic, strong)NSString *birthday;//生日
@property (nonatomic, strong)NSString *phone;//电话
@property (nonatomic, strong)NSString *uid;
@property (nonatomic,retain)DataReauest *DataMedol;
@property (nonatomic,retain)DataReauest *DataMedol1;
@property (nonatomic,retain)DataMedol *JiGouDetaildataMedol;
@property(nonatomic,retain)DataReauest *JiGouDetailRequestMedol;
@property (nonatomic,retain)NSDictionary *sharedic;
@property (nonatomic,retain)NSDictionary *SheTuanXiangQing;
@property (nonatomic,retain)NSArray *Dtarry;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,retain)NSArray *courseArry1;
@property (nonatomic,retain)NSArray *courseArry2;
@property (nonatomic,retain)NSArray *courseArry3;
@property (nonatomic,retain)NSArray *courseArry4;
@property (nonatomic,retain)NSArray *courseArry5;
@property (nonatomic,retain)NSArray *courseArry6;
@property (nonatomic,retain)NSArray *courseArry7;
@property (nonatomic,copy)NSString *imgurl;
//搜索数组
@property (nonatomic,retain)NSArray *DataArry;

@property (nonatomic, assign) BOOL isZero;
//用户ID

+ (ShareDefult *)shareInstance;

@end
