//
//  DataReauest.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/11.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataReauest : NSObject
@property (nonatomic,copy)NSString *ask,*start,*place,*class_time,*img,*date,*birthday,*class_video,*ctime,*edu_school,*email,*label_admin,*password,*name,*phone,*msg,*sex,*head,*user_id,*group_id,*subject_id,*location,*brief,*feature,*balance,*school_name,*mobile,*longitude,*latitude,*teacherNum,*account,*admins,*groupId,*course_plan,*create_time,*detail,*group,*send_to,*time,*agency_name,*admin,*agency,*score_items,*tutor,*studentNum,*subjectNum,*adminNum,*qualification,*joined,*fit_crowd,*goal,*quit_rule,*join_rule,*course_num,*tInfo,*user_img,*user_name,*content,*address,*teacher_name,*agency_id,*refuse;
@property(nonatomic,assign)int HdID;
//@property(nonatomic,assign)int Hcid,Htid,Hsid,present,confim,leave,replace,report,type;
@property(nonatomic,assign)int authed;
@property(nonatomic,assign)int edu,edu_exp;
@property(nonatomic,assign)float price1,state,yue;
@property (nonatomic,assign)int edu_age;
//@property (nonatomic,assign)int code;
@property(nonatomic,retain)NSArray *news;
@property (nonatomic,copy)NSString *cid,*tid,*sid,*status,*present,*confirm,*leave,*replace,*report,*type;
- (DataReauest *)initWithDictiory:(NSDictionary *)dic;
@end
