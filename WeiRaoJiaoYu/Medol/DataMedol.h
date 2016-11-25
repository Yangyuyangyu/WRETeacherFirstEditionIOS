//
//  DataMedol.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/29.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataMedol : NSObject
@property (nonatomic,copy)NSString *ask,*start,*place,*class_time,*img,*date,*birthday,*class_video,*ctime,*edu_school,*email,*label_admin,*password,*name,*phone,*msg,*sex,*head,*user_id,*group_id,*subject_id,*location,*brief,*feature,*balance,*school_name,*mobile,*longitude,*latitude,*teacherNum,*account,*qualification;
@property(nonatomic,assign)int authed;
@property(nonatomic,assign)int edu,edu_exp;
@property(nonatomic,assign)float price1,state,yue;
@property (nonatomic,assign)int edu_age;
@property (nonatomic,assign)int code;
@property (nonatomic,copy)NSString *cid,*tid,*sid,*status,*present,*confirm,*leave,*replace,*report,*type;
@property(nonatomic,assign)int HdID;
- (DataMedol *)initWithDictiory:(NSDictionary *)dic;
@end
