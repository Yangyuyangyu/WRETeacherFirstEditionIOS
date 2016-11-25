//
//  Repair.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/6/27.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repair : NSObject
/*!
 *  @brief 补点名
 *
 *  @param recordId 上课记录id
 */
- (void)recallInfoList:(NSString *)recordId;
/*!
 *  @brief 签到
 *
 *  @param class_id 上课记录id
 *  @param lng      经度
 *  @param lat      纬度
 *  @param location 签到地址
 */
- (void)signUpInfoList:(NSString *)class_id lng:(NSString *)lng lat:(NSString *)lat location:(NSString *)location;
/*!
 *  @brief 老师主页信息
 */
- (void)infoInfoList;
/*!
 *  @brief 上传多张图片
 *
 *  @param imgArray 图片数组
 */
- (void)moreImgUploadInfokInfoList:(NSData *)name;
/*!
 *  @brief 提交课程报告
 *
 *  @param content  上课内容
 *  @param problem  上课情况及问题
 *  @param solution 解决方案
 *  @param homework 是否有作业，0无，1有
 *  @param work     作业内容，无作业时传空值
 *  @param img      作业图片，无作业时传空值
 */
- (void)reportInfoList:(NSString *)content problem:(NSString *)problem solution:(NSString *)solution homework:(NSString *)homework work:(NSString *)work img:(NSString *)img;
@end
