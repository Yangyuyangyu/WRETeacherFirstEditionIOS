//
//  CollectionViewCell.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TouXiang;
@property (weak, nonatomic) IBOutlet UILabel *Sexlab;
@property (weak, nonatomic) IBOutlet UILabel *Namelab;

@property (weak, nonatomic) IBOutlet UIView *backView;

@end
