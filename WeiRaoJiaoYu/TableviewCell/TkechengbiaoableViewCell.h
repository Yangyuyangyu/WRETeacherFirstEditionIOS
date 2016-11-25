//
//  TkechengbiaoableViewCell.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIbutton.h"
@interface TkechengbiaoableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *QianDaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *DaiKeBtn;
@property (weak, nonatomic) IBOutlet UILabel *KeLab;
@property (weak, nonatomic) IBOutlet UIButton *QinhJiaBtn;
@property (weak, nonatomic) IBOutlet UIImageView *CellImgview;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *Imgeview;

@end
