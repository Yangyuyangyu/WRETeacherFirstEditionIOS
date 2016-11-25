//
//  LYTableViewCell.h
//  tableviewControll
//
//  Created by 李杨 on 16/2/14.
//  Copyright © 2016年 李杨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;
@interface LYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLab;
@property(assign, nonatomic)NSIndexPath* clickCount;
- (void)cellWithData:(Model *)model;
@end
