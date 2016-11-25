//
//  CommntTableViewCell.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/24.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommntTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TouXiang;
@property (weak, nonatomic) IBOutlet UILabel *Namelab;
@property (weak, nonatomic) IBOutlet UILabel *Timelab;
@property (weak, nonatomic) IBOutlet UILabel *CommentLab;

@end
