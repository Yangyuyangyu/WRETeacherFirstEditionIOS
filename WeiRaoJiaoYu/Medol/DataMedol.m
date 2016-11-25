//
//  DataMedol.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/29.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "DataMedol.h"

@implementation DataMedol
- (DataMedol *)initWithDictiory:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        self.HdID = [value intValue];
        
    }
    if([key isEqualToString:@"average_price"])
    {
        self.price1=[value floatValue];
    }
    
    if([key isEqualToString:@"authed"])
    {
        self.authed=[value intValue];
    }
    
    
    if([key isEqualToString:@"edu"])
    {
        self.edu=[value floatValue];
    }
    if([key isEqualToString:@"edu_exp"])
    {
        self.edu_exp=[value floatValue];
    }
    if ([key isEqualToString:@"edu_age"])
    {
        self.edu_age=[value intValue];
    }
    if ([key isEqualToString:@"code"])
    {
        self.code=[value intValue];
    }
    if([key isEqualToString:@"state"])
    {
        self.state=[value floatValue];
    }
    if([key isEqualToString:@"yue"])
    {
        self.yue=[value floatValue];
    }
    
    
    
    
}

    
    


@end
