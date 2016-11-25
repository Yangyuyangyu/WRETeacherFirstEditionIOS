//
//  Person.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/25.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "Person.h"

@implementation Person
//- (void)initWith:(NSString *)name
- (Person *)initWithName:(NSString *)name
{
    
    self = [super init];
    if (self) {
        self.name=name;
    }
    return self;
}
    

@end
