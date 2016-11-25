//
//  Person.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/25.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Person : NSObject
//- (void)initWith:(NSString *)name;
@property(nonatomic,copy)NSString *name;
- (Person *)initWithName:(NSString *)name;
@end
