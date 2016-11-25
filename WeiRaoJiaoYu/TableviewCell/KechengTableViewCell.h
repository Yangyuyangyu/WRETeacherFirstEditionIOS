//
//  KechengTableViewCell.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/3.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIbutton.h"
@interface KechengTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *yuyuebtn;
@property (weak, nonatomic) IBOutlet UILabel *Kelab;
@property (weak, nonatomic) IBOutlet UIImageView *CellImgview;
@property (weak, nonatomic) IBOutlet UIImageView *imaview;

@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UIButton *yuyuebtn1;

@end
