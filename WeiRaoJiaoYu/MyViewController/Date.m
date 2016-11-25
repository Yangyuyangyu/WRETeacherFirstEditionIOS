//
//  Date.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/11.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "Date.h"

@implementation Date
+ (Date* )getView
{
    NSArray* buttonViewArr =  [[NSBundle mainBundle] loadNibNamed:@"Date" owner:nil options:nil];
    Date* btnView = (Date* )buttonViewArr[0];
    //[btnView.BtnLab  adjustsFontSizeToFitWidth];
    
    return btnView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
