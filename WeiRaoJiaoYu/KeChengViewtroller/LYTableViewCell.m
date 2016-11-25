//
//  LYTableViewCell.m
//  tableviewControll
//
//  Created by 李杨 on 16/2/14.
//  Copyright © 2016年 李杨. All rights reserved.
//

#import "LYTableViewCell.h"
#import "Model.h"
@implementation LYTableViewCell

- (void)awakeFromNib {
   
}

-(void)layoutSubviews{

    [super layoutSubviews];
//    self.clickCount = 0;
    

}
- (void)cellWithData:(Model *)model {
    if (model.isSelected) {
        [self.btn setBackgroundImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
    } else {
        [self.btn setBackgroundImage:[UIImage imageNamed:@"unselected_btn"] forState:UIControlStateNormal];
    }
}

@end
