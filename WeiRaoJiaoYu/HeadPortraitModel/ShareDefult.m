//
//  ShareDefult.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/11.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "ShareDefult.h"

@implementation ShareDefult
+ (ShareDefult *)shareInstance{
    static ShareDefult *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[ShareDefult alloc] init];
    });
    return share;
}

@end
