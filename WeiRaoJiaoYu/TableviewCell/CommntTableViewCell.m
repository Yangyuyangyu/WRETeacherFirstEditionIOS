//
//  CommntTableViewCell.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/24.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "CommntTableViewCell.h"

@implementation CommntTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.TouXiang.layer.borderWidth=1;
    self.TouXiang.layer.borderColor=[[UIColor colorWithWhite:0.800 alpha:1.000] CGColor];
    self.TouXiang.layer.masksToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
