//
//  LoginMedol.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/29.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
@interface LoginMedol : NSObject
{
    UIAlertView *alertview;
}
- (void)obtainInfoList:(NSString *)Email userPwd:(NSString *)userPwd;
@end
