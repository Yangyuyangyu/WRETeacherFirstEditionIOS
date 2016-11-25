//
//  BdingPhoneModel.h
//  BanDouApp
//
//  Created by waycubeIOSb on 16/3/28.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BdingPhoneModel : NSObject
//绑定手机
//- (void)bdingInfoList:(NSString *)uid phone:(NSString *)phone;
//发送手机验证码
- (void)verificationInfoListphone:(NSString *)phone;
- (void)verificationInfoListphone1:(NSString *)phone1;
//校验手机验证码
//- (void)verifyInfoList:(NSString *)uid code:(NSString *)code;
@end
